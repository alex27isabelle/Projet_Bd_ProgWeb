using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using ProjetFinal_2386452.Data;
using ProjetFinal_2386452.Models;
using ProjetFinal_2386452.ViewModels;
using WrapUpBilleterie.ViewModels;
using System.Security.Principal;

namespace ProjetFinal_2386452.Controllers
{
	public class PistesController : Controller
	{
		private readonly RevelstokeMountainResortContext _context;

		public PistesController(RevelstokeMountainResortContext context)
		{
			_context = context;
		}

		// GET: Pistes
		public async Task<IActionResult> Index(PisteFiltrer filtre)
		{
            ViewData["PrenomNom"] = "visiteur";
            IIdentity? identite = HttpContext.User.Identity;
            if (identite != null && identite.IsAuthenticated)
            {
                string courriel = HttpContext.User.FindFirstValue(ClaimTypes.Name);
                Client? client = await _context.Clients.FirstOrDefaultAsync(x => x.Courriel == courriel);
                if (client != null)
                {
                    // Pour dire "Bonjour X" sur l'index
                    ViewData["PrenomNom"] = client.Prenom + " " + client.Nom;
                }
            }

            if (User.Identity == null || !User.Identity.IsAuthenticated)
                return RedirectToAction("Connexion");

            string query = "EXEC Versants.USP_RecherchePiste @Nom, @Difficulte, @EstSousbois, @LongueurMin";

			List<SqlParameter> parameters = new List<SqlParameter>
			{
        new SqlParameter{ParameterName="@Nom", Value=filtre.Nom ?? ""},
        new SqlParameter{ParameterName="@Difficulte", Value=filtre.Difficulte ?? ""},
        new SqlParameter{ParameterName="@EstSousbois", Value=filtre.EstSousBois.HasValue ? (object)filtre.EstSousBois.Value : false},
        new SqlParameter{ParameterName="@LongueurMin", Value=filtre.LongeurMin.HasValue ? (object)filtre.LongeurMin.Value : 0}
            };

			List<VwInfoPiste> pistes = _context.VwInfoPistes.FromSqlRaw(query, parameters.ToArray()).ToList();


			var difficulteOptions = new List<SelectListItem>
	{
		new SelectListItem { Text = "Vert", Value = "Vert" },
		new SelectListItem { Text = "Bleu", Value = "Bleu" },
		new SelectListItem { Text = "Noir", Value = "Noir" },
		new SelectListItem { Text = "Double Noir", Value = "Double Noir" }
	};
			var viewModel = new PisteVM
			{
				Pistes = pistes,
				Filtre = filtre, // Passe le modèle de filtre également
				DifficulteOptions = difficulteOptions
			};

			return View(viewModel);
		}

		// GET: Pistes/Details/5
		public async Task<IActionResult> Details(int? id)
		{
			if (id == null)
			{
				return NotFound();
			}

			var piste = await _context.Pistes
				.Include(p => p.Versant)
				.FirstOrDefaultAsync(m => m.PisteId == id);
			if (piste == null)
			{
				return NotFound();
			}

			return View(piste);
		}
		private bool PisteExists(int id)
		{
			return _context.Pistes.Any(e => e.PisteId == id);
		}


        // Inscription en requête get
        public IActionResult Inscription()
        {
            return View();
        }

        // Inscription en requête post
        [HttpPost]
        public async Task<IActionResult> Inscription(InscriptionViewModel ivm)
        {
            // A COMPLETER LORS DE L'ETAPE 1
            bool existeDeja = await _context.Clients.AnyAsync(x => x.Courriel == ivm.Courriel);
            if (existeDeja)
            {
                ModelState.AddModelError("Courriel", "Un compte ayant ce courriel existe déjà");
                return View(ivm);
            }
            string query = "EXEC Clients.USP_CreerClient @Nom, @Prenom, @Courriel,@NumTel, @MotDePasse";
            List<SqlParameter> parameters = new List<SqlParameter>
            {
                new SqlParameter{ParameterName="@Nom", Value = ivm.Nom},
                new SqlParameter{ParameterName="@Prenom", Value = ivm.Prenom},
                new SqlParameter{ParameterName="@Courriel", Value = ivm.Courriel},
                new SqlParameter{ParameterName="@NumTel", Value = ivm.NumTel},
                new SqlParameter{ParameterName="@MotDePasse", Value = ivm.MotDePasse}
            };
            try
            {
                await _context.Database.ExecuteSqlRawAsync(query, parameters.ToArray());
                ViewData["PrenomNom"] = "visiteur";
                IIdentity? identite = HttpContext.User.Identity;
                if (identite != null && identite.IsAuthenticated)
                {
                    string courriel = HttpContext.User.FindFirstValue(ClaimTypes.Name);
                    Client? client = await _context.Clients.FirstOrDefaultAsync(x => x.Courriel == courriel);
                    if (client != null)
                    {
                        // Pour dire "Bonjour X" sur l'index
                        ViewData["PrenomNom"] = client.Prenom + " " + client.Nom;
                    }
                }
            }
            catch (Exception)
            {
                ModelState.AddModelError("", "Une erreur est survenu, réessayez.");
                return View(ivm);
            }
            return RedirectToAction("Index");
        }

        public IActionResult Connexion()
        {

            return View();
        }

        [HttpPost]
        public async Task<IActionResult> Connexion(ConnexionViewModel cvm)
        {
            // A COMPLETER LORS DE L'ÉTAPE 1
            //exécution de la procédure pour la connection d'un utilisateur
            string query = "EXEC Clients.USP_AuthClient @Courriel, @MotDePasse";
            List<SqlParameter> parameters = new List<SqlParameter>
            {
                new SqlParameter{ParameterName="@Courriel", Value=cvm.Courriel},
                new SqlParameter{ParameterName="@MotDePasse", Value=cvm.MotDePasse}
            };
            Client? client = (await _context.Clients.FromSqlRaw(query, parameters.ToArray()).ToListAsync()).FirstOrDefault();
            if (client == null)
            {
                ModelState.AddModelError("", "Courriel ou Mot de passe invalide");
                return View(cvm);
            }



            // Construction du cookie d'authentification 
            List<Claim> claims = new List<Claim>
            {
                new Claim(ClaimTypes.NameIdentifier, client.ClientId.ToString()),
                new Claim(ClaimTypes.Name, client.Courriel)
            };

            ClaimsIdentity identite = new ClaimsIdentity(claims, CookieAuthenticationDefaults.AuthenticationScheme);
            ClaimsPrincipal principal = new ClaimsPrincipal(identite);        
            // Cette ligne fournit le cookie à l'utilisateur
            await HttpContext.SignInAsync(principal);
            return RedirectToAction("Index");
        }

        [HttpGet]
        public async Task<IActionResult> Deconnexion()
        {
            // Cette ligne mange le cookie 🍪 Slurp
            await HttpContext.SignOutAsync();
            return RedirectToAction("Index");
        }
    }
}
