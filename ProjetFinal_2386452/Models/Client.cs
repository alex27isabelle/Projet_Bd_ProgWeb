using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace ProjetFinal_2386452.Models;

[Table("Client", Schema = "Clients")]
public partial class Client
{
    [Key]
    [Column("ClientID")]
    public int ClientId { get; set; }

    [StringLength(20)]
    public string Nom { get; set; } = null!;

    [StringLength(30)]
    public string Prenom { get; set; } = null!;

    [StringLength(50)]
    public string Courriel { get; set; } = null!;

    [StringLength(15)]
    public string NumTel { get; set; } = null!;

    [MaxLength(16)]
    public byte[]? MdpSel { get; set; }

    [MaxLength(32)]
    public byte[]? MdpHache { get; set; }

    [InverseProperty("Client")]
    public virtual ICollection<Adresse> Adresses { get; set; } = new List<Adresse>();

    [InverseProperty("Client")]
    public virtual ICollection<PasseSaison> PasseSaisons { get; set; } = new List<PasseSaison>();
}
