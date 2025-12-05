using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace ProjetFinal_2386452.Models;

[Keyless]
public partial class VwInfoPiste
{
    [StringLength(30)]
    public string Nom { get; set; } = null!;

    [StringLength(20)]
    public string Difficulte { get; set; } = null!;

    public int Longeur { get; set; }

    public bool EstSousBois { get; set; }

    [StringLength(10)]
    [Unicode(false)]
    public string Versant { get; set; } = null!;

    [Column("Nombre de decente")]
    public int? NombreDeDecente { get; set; }

    [Column("PisteID")]
    public int PisteId { get; set; }
}
