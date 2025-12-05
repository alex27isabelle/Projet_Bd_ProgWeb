using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace ProjetFinal_2386452.Models;

[Table("Remontee", Schema = "Versants")]
[Index("Identifiant", Name = "UC_Remontee_Identifiant", IsUnique = true)]
public partial class Remontee
{
    [Key]
    [Column("RemonteeID")]
    public int RemonteeId { get; set; }

    [StringLength(15)]
    public string Nom { get; set; } = null!;

    public int Longeur { get; set; }

    public int TempEnMinute { get; set; }

    [Column(TypeName = "decimal(4, 2)")]
    public decimal Vitesse { get; set; }

    public int NbPylone { get; set; }

    [StringLength(30)]
    public string Type { get; set; } = null!;

    public int AnneeConstruction { get; set; }

    [Column("VersantID")]
    public int VersantId { get; set; }

    public Guid Identifiant { get; set; }

    public byte[]? Photo { get; set; }

    [ForeignKey("VersantId")]
    [InverseProperty("Remontees")]
    public virtual Versant Versant { get; set; } = null!;
}
