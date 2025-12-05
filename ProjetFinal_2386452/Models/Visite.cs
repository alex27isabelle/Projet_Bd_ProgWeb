using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace ProjetFinal_2386452.Models;

[Table("Visite", Schema = "Clients")]
public partial class Visite
{
    [Key]
    [Column("VisiteID")]
    public int VisiteId { get; set; }

    public DateOnly DateVisite { get; set; }

    [Column("PasseSaisonID")]
    public int PasseSaisonId { get; set; }

    [InverseProperty("Visite")]
    public virtual ICollection<Descente> Descentes { get; set; } = new List<Descente>();

    [ForeignKey("PasseSaisonId")]
    [InverseProperty("Visites")]
    public virtual PasseSaison PasseSaison { get; set; } = null!;
}
