using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace ProjetFinal_2386452.Models;

[Table("Versant", Schema = "Versants")]
public partial class Versant
{
    [Key]
    [Column("VersantID")]
    public int VersantId { get; set; }

    [StringLength(10)]
    [Unicode(false)]
    public string Nom { get; set; } = null!;

    public int AltituteMaxChaise { get; set; }

    [InverseProperty("Versant")]
    public virtual ICollection<Piste> Pistes { get; set; } = new List<Piste>();

    [InverseProperty("Versant")]
    public virtual ICollection<Remontee> Remontees { get; set; } = new List<Remontee>();
}
