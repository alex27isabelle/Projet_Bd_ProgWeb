using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using ProjetFinal_2386452.Models;

namespace ProjetFinal_2386452.Data;

public partial class RevelstokeMountainResortContext : DbContext
{
    public RevelstokeMountainResortContext()
    {
    }

    public RevelstokeMountainResortContext(DbContextOptions<RevelstokeMountainResortContext> options)
        : base(options)
    {
    }

    public virtual DbSet<AchatPasseSaison> AchatPasseSaisons { get; set; }

    public virtual DbSet<Adresse> Adresses { get; set; }

    public virtual DbSet<Changelog> Changelogs { get; set; }

    public virtual DbSet<Client> Clients { get; set; }

    public virtual DbSet<Descente> Descentes { get; set; }

    public virtual DbSet<PasseSaison> PasseSaisons { get; set; }

    public virtual DbSet<Piste> Pistes { get; set; }

    public virtual DbSet<Remontee> Remontees { get; set; }

    public virtual DbSet<Versant> Versants { get; set; }

    public virtual DbSet<Visite> Visites { get; set; }

    public virtual DbSet<VwInfoPiste> VwInfoPistes { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        => optionsBuilder.UseSqlServer("Name=RevelstokeMountainResort");

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<AchatPasseSaison>(entity =>
        {
            entity.HasKey(e => e.AchatPasseSaisonId).HasName("PK_AchatPasseSaison_AchatPasseSaisonID");

            entity.HasOne(d => d.PasseSaison).WithMany(p => p.AchatPasseSaisons)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_AchatPasseSaison_PasseSaisonID");
        });

        modelBuilder.Entity<Adresse>(entity =>
        {
            entity.HasKey(e => e.AdresseId).HasName("PK_Adresse_AdresseID");

            entity.Property(e => e.CodePostal).IsFixedLength();

            entity.HasOne(d => d.Client).WithMany(p => p.Adresses)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Adresse_ClientID");
        });

        modelBuilder.Entity<Changelog>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__changelo__3213E83F3F0A66B4");

            entity.Property(e => e.InstalledOn).HasDefaultValueSql("(getdate())");
        });

        modelBuilder.Entity<Client>(entity =>
        {
            entity.HasKey(e => e.ClientId).HasName("PK_Client_ClientID");
        });

        modelBuilder.Entity<Descente>(entity =>
        {
            entity.HasKey(e => e.DescenteId).HasName("PK_Descente_DescenteID");

            entity.HasOne(d => d.Piste).WithMany(p => p.Descentes)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Descente_PisteID");

            entity.HasOne(d => d.Visite).WithMany(p => p.Descentes)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Descente_VisiteID");
        });

        modelBuilder.Entity<PasseSaison>(entity =>
        {
            entity.HasKey(e => e.PasseSaisonId).HasName("PK_PasseSaison_PasseSaisonID");

            entity.HasOne(d => d.Client).WithMany(p => p.PasseSaisons)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_PasseSaison_ClientID");
        });

        modelBuilder.Entity<Piste>(entity =>
        {
            entity.HasKey(e => e.PisteId).HasName("PK_Piste_PisteID");

            entity.HasOne(d => d.Versant).WithMany(p => p.Pistes).HasConstraintName("FK_Piste_VersantID");
        });

        modelBuilder.Entity<Remontee>(entity =>
        {
            entity.HasKey(e => e.RemonteeId).HasName("PK_Remontee_RemonteeID");

            entity.Property(e => e.Identifiant).HasDefaultValueSql("(newid())");

            entity.HasOne(d => d.Versant).WithMany(p => p.Remontees).HasConstraintName("FK_Remontee_VersantID");
        });

        modelBuilder.Entity<Versant>(entity =>
        {
            entity.HasKey(e => e.VersantId).HasName("PK_Versant_VersantID");

            entity.Property(e => e.Nom).IsFixedLength();
        });

        modelBuilder.Entity<Visite>(entity =>
        {
            entity.HasKey(e => e.VisiteId).HasName("PK_Visite_visiteID");

            entity.HasOne(d => d.PasseSaison).WithMany(p => p.Visites)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Visite_PasseSaisonID");
        });

        modelBuilder.Entity<VwInfoPiste>(entity =>
        {
            entity.ToView("vw_InfoPiste", "Versants");

            entity.Property(e => e.Versant).IsFixedLength();
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
