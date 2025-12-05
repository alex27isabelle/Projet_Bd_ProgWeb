using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace ProjetFinal_2386452.Models;

[Table("Descente", Schema = "Clients")]
public partial class Descente
{
    [Key]
    [Column("DescenteID")]
    public int DescenteId { get; set; }

    public TimeOnly HeureDescente { get; set; }

    [Column("PisteID")]
    public int PisteId { get; set; }

    [Column("VisiteID")]
    public int VisiteId { get; set; }

    [ForeignKey("PisteId")]
    [InverseProperty("Descentes")]
    public virtual Piste Piste { get; set; } = null!;

    [ForeignKey("VisiteId")]
    [InverseProperty("Descentes")]
    public virtual Visite Visite { get; set; } = null!;
}
