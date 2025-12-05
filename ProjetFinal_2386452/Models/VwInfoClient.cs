using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace ProjetFinal_2386452.Models;

[Keyless]
public partial class VwInfoClient
{
    [StringLength(51)]
    public string Nom { get; set; } = null!;

    [Column("Type de Passe")]
    [StringLength(10)]
    public string TypeDePasse { get; set; } = null!;

    [Column("nombre de d�scente")]
    public int? NombreDeDScente { get; set; }
}
