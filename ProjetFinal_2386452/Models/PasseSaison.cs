using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace ProjetFinal_2386452.Models;

[Table("PasseSaison", Schema = "Clients")]
public partial class PasseSaison
{
    [Key]
    [Column("PasseSaisonID")]
    public int PasseSaisonId { get; set; }

    [StringLength(10)]
    public string Type { get; set; } = null!;

    [Column("ClientID")]
    public int ClientId { get; set; }

    [InverseProperty("PasseSaison")]
    public virtual ICollection<AchatPasseSaison> AchatPasseSaisons { get; set; } = new List<AchatPasseSaison>();

    [ForeignKey("ClientId")]
    [InverseProperty("PasseSaisons")]
    public virtual Client Client { get; set; } = null!;

    [InverseProperty("PasseSaison")]
    public virtual ICollection<Visite> Visites { get; set; } = new List<Visite>();
}
