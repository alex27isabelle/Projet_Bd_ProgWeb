using Microsoft.AspNetCore.Mvc.Rendering;
using ProjetFinal_2386452.Models;

namespace ProjetFinal_2386452.ViewModels
{
	public class PisteVM
	{
		public IEnumerable<VwInfoPiste> Pistes { get; set; }
		public PisteFiltrer Filtre { get; set; } 

		public List<SelectListItem> DifficulteOptions { get; set; }
	}
}
