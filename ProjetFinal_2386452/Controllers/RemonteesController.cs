using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using ProjetFinal_2386452.Data;
using ProjetFinal_2386452.Models;

namespace ProjetFinal_2386452.Controllers
{
    public class RemonteesController : Controller
    {
        private readonly RevelstokeMountainResortContext _context;

        public RemonteesController(RevelstokeMountainResortContext context)
        {
            _context = context;
        }

        // GET: Remontees
        public async Task<IActionResult> Index()
        {
            var revelstokeMountainResortContext = _context.Remontees.Include(r => r.Versant);
            return View(await revelstokeMountainResortContext.ToListAsync());
        }

        // GET: Remontees/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var remontee = await _context.Remontees
                .Include(r => r.Versant)
                .FirstOrDefaultAsync(m => m.RemonteeId == id);
            if (remontee == null)
            {
                return NotFound();
            }

            return View(remontee);
        }
        private bool RemonteeExists(int id)
        {
            return _context.Remontees.Any(e => e.RemonteeId == id);
        }
    }
}
