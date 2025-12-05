using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace ProjetFinal_2386452.Models;

[Table("Adresse", Schema = "Clients")]
public partial class Adresse
{
    [Key]
    [Column("AdresseID")]
    public int AdresseId { get; set; }

    public int NumPorte { get; set; }

    public int? NumAppartement { get; set; }

    [StringLength(50)]
    public string Rue { get; set; } = null!;

    [StringLength(7)]
    [Unicode(false)]
    public string CodePostal { get; set; } = null!;

    [StringLength(50)]
    public string Ville { get; set; } = null!;

    [StringLength(50)]
    public string Province { get; set; } = null!;

    [Column("ClientID")]
    public int ClientId { get; set; }

    [ForeignKey("ClientId")]
    [InverseProperty("Adresses")]
    public virtual Client Client { get; set; } = null!;
}
