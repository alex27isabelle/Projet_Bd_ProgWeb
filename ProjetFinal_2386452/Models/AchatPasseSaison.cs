using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace ProjetFinal_2386452.Models;

[Table("AchatPasseSaison", Schema = "Clients")]
public partial class AchatPasseSaison
{
    [Key]
    [Column("AchatPasseSaisonID")]
    public int AchatPasseSaisonId { get; set; }

    [Column("PasseSaisonID")]
    public int PasseSaisonId { get; set; }

    public DateOnly DateAchat { get; set; }

    [ForeignKey("PasseSaisonId")]
    [InverseProperty("AchatPasseSaisons")]
    public virtual PasseSaison PasseSaison { get; set; } = null!;
}
