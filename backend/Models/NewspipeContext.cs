using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;

namespace backend.Models;

public partial class NewspipeContext : DbContext
{
    public NewspipeContext()
    {
    }

    public NewspipeContext(DbContextOptions<NewspipeContext> options)
        : base(options)
    {
    }

    public virtual DbSet<Headline> Headlines { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        => optionsBuilder.UseNpgsql("Host=localhost;Port=5433;Username=postgres;Password=yourpassword;Database=newspipe");

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Headline>(entity =>
        {
            entity.HasKey(e => e.Uid).HasName("headlines_pkey");

            entity.ToTable("headlines");

            entity.HasIndex(e => e.Url, "index_headlines_on_url").IsUnique();

            entity.Property(e => e.Uid).HasColumnName("uid");
            entity.Property(e => e.CreatedAt)
                .HasColumnType("timestamp(6) without time zone")
                .HasColumnName("created_at");
            entity.Property(e => e.Metadata)
                .HasDefaultValueSql("'{}'::jsonb")
                .HasColumnType("jsonb")
                .HasColumnName("metadata");
            entity.Property(e => e.PublishedAt)
                .HasColumnType("timestamp(6) without time zone")
                .HasColumnName("published_at");
            entity.Property(e => e.Source)
                .HasColumnType("character varying")
                .HasColumnName("source");
            entity.Property(e => e.Title)
                .HasColumnType("character varying")
                .HasColumnName("title");
            entity.Property(e => e.UpdatedAt)
                .HasColumnType("timestamp(6) without time zone")
                .HasColumnName("updated_at");
            entity.Property(e => e.Url)
                .HasColumnType("character varying")
                .HasColumnName("url");
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
