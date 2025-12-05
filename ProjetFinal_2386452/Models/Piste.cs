using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace ProjetFinal_2386452.Models;

[Table("Piste", Schema = "Versants")]
[Index("EstSousBois", Name = "IX_Piste_EstSousBois")]
[Index("Longeur", Name = "IX_Piste_Longeur")]
[Index("Nom", Name = "UC_Piste_Nom", IsUnique = true)]
public partial class Piste
{
    [Key]
    [Column("PisteID")]
    public int PisteId { get; set; }

    [StringLength(30)]
    public string Nom { get; set; } = null!;

    public int Longeur { get; set; }

    [StringLength(20)]
    public string Difficulte { get; set; } = null!;

    public bool EstSousBois { get; set; }

    [Column("VersantID")]
    public int VersantId { get; set; }

    [InverseProperty("Piste")]
    public virtual ICollection<Descente> Descentes { get; set; } = new List<Descente>();

    [ForeignKey("VersantId")]
    [InverseProperty("Pistes")]
    public virtual Versant Versant { get; set; } = null!;
}
