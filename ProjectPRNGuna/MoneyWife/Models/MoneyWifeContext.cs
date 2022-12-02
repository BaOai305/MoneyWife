using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.Extensions.Configuration;

namespace MoneyWife.Models
{
    public partial class MoneyWifeContext : DbContext
    {
        public MoneyWifeContext()
        {
        }

        public MoneyWifeContext(DbContextOptions<MoneyWifeContext> options)
            : base(options)
        {
        }

        public virtual DbSet<Money> Money { get; set; } = null!;
        public virtual DbSet<Plan> Plans { get; set; } = null!;
        public virtual DbSet<Saving> Savings { get; set; } = null!;
        public virtual DbSet<SavingMoney> SavingMoneys { get; set; } = null!;
        public virtual DbSet<Transaction> Transactions { get; set; } = null!;
        public virtual DbSet<Type> Types { get; set; } = null!;
        public virtual DbSet<TypeOfUser> TypeOfUsers { get; set; } = null!;
        public virtual DbSet<User> Users { get; set; } = null!;

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            var builder = new ConfigurationBuilder()
                                          .SetBasePath(Directory.GetCurrentDirectory())
                                          .AddJsonFile("appsettings.json", optional: true, reloadOnChange: true);
            IConfigurationRoot configuration = builder.Build();
            optionsBuilder.UseSqlServer(configuration.GetConnectionString("MoneyWifeContext"));
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Money>(entity =>
            {
                entity.HasKey(e => new { e.Id, e.UserId });

                entity.Property(e => e.Id)
                    .ValueGeneratedOnAdd()
                    .HasColumnName("id");

                entity.Property(e => e.UserId).HasColumnName("user_id");

                entity.Property(e => e.Bank)
                    .HasColumnType("decimal(18, 0)")
                    .HasColumnName("bank");

                entity.Property(e => e.Cash)
                    .HasColumnType("decimal(18, 0)")
                    .HasColumnName("cash");

                entity.HasOne(d => d.User)
                    .WithMany(p => p.Money)
                    .HasForeignKey(d => d.UserId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Money_Users");
            });

            modelBuilder.Entity<Plan>(entity =>
            {
                entity.HasKey(e => new { e.Id, e.UserId });

                entity.ToTable("Plan");

                entity.Property(e => e.Id)
                    .ValueGeneratedOnAdd()
                    .HasColumnName("id");

                entity.Property(e => e.UserId).HasColumnName("user_id");

                entity.Property(e => e.Pfrom)
                    .HasColumnType("datetime")
                    .HasColumnName("pfrom");

                entity.Property(e => e.Progress).HasColumnName("progress");

                entity.Property(e => e.Pto)
                    .HasColumnType("datetime")
                    .HasColumnName("pto");

                entity.Property(e => e.Target)
                    .HasColumnType("decimal(18, 0)")
                    .HasColumnName("target");

                entity.Property(e => e.Title)
                    .HasMaxLength(250)
                    .HasColumnName("title");
            });

            modelBuilder.Entity<Saving>(entity =>
            {
                entity.HasKey(e => new { e.Id, e.UserId });

                entity.ToTable("Saving");

                entity.Property(e => e.Id)
                    .ValueGeneratedOnAdd()
                    .HasColumnName("id");

                entity.Property(e => e.UserId).HasColumnName("user_id");

                entity.Property(e => e.InterestRate).HasColumnName("interest_rate");

                entity.Property(e => e.NgayDaoHan).HasColumnName("ngayDaoHan");

                entity.Property(e => e.Status)
                    .HasMaxLength(50)
                    .IsUnicode(false)
                    .HasColumnName("status");

                entity.Property(e => e.TienRa)
                    .HasColumnType("decimal(18, 0)")
                    .HasColumnName("tienRa");

                entity.Property(e => e.TienVao)
                    .HasColumnType("decimal(18, 0)")
                    .HasColumnName("tienVao");

                entity.Property(e => e.Title)
                    .HasMaxLength(250)
                    .HasColumnName("title");

                entity.HasOne(d => d.User)
                    .WithMany(p => p.Savings)
                    .HasForeignKey(d => d.UserId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Saving_Users");
            });

            modelBuilder.Entity<SavingMoney>(entity =>
            {
                entity.HasKey(e => new { e.Id, e.UserId, e.SavingId });

                entity.ToTable("SavingMoney");

                entity.Property(e => e.Id)
                    .ValueGeneratedOnAdd()
                    .HasColumnName("id");

                entity.Property(e => e.UserId).HasColumnName("user_id");

                entity.Property(e => e.SavingId).HasColumnName("saving_id");

                entity.Property(e => e.DepDay)
                    .HasColumnType("datetime")
                    .HasColumnName("dep_day");

                entity.Property(e => e.Deposits)
                    .HasColumnType("decimal(18, 0)")
                    .HasColumnName("deposits");

                entity.Property(e => e.IntDay)
                    .HasColumnType("datetime")
                    .HasColumnName("int_day");

                entity.Property(e => e.Interest)
                    .HasColumnType("decimal(18, 0)")
                    .HasColumnName("interest");

                entity.HasOne(d => d.Saving)
                    .WithMany(p => p.SavingMoneys)
                    .HasForeignKey(d => new { d.SavingId, d.UserId })
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_SavingMoney_Saving");
            });

            modelBuilder.Entity<Transaction>(entity =>
            {
                entity.HasKey(e => new { e.Id, e.UserId });

                entity.ToTable("Transaction");

                entity.Property(e => e.Id)
                    .ValueGeneratedOnAdd()
                    .HasColumnName("id");

                entity.Property(e => e.UserId).HasColumnName("user_id");

                entity.Property(e => e.CashOrBank)
                    .HasMaxLength(50)
                    .IsUnicode(false)
                    .HasColumnName("cashOrBank");

                entity.Property(e => e.DateUse)
                    .HasColumnType("smalldatetime")
                    .HasColumnName("dateUse");

                entity.Property(e => e.MoneyContent).HasColumnName("moneyContent");

                entity.Property(e => e.MoneyNum)
                    .HasColumnType("decimal(18, 0)")
                    .HasColumnName("moneyNum");

                entity.Property(e => e.MoneyType).HasColumnName("moneyType");

                entity.HasOne(d => d.User)
                    .WithMany(p => p.Transactions)
                    .HasForeignKey(d => d.UserId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Transaction_Users");

                entity.HasOne(d => d.TypeOfUser)
                    .WithMany(p => p.Transactions)
                    .HasForeignKey(d => new { d.MoneyType, d.UserId })
                    .HasConstraintName("FK_Transaction_TypeOfUsers");
            });

            modelBuilder.Entity<Type>(entity =>
            {
                entity.ToTable("Type");

                entity.Property(e => e.Id).HasColumnName("id");

                entity.Property(e => e.Category)
                    .HasMaxLength(50)
                    .IsUnicode(false)
                    .HasColumnName("category");

                entity.Property(e => e.Description)
                    .HasMaxLength(250)
                    .HasColumnName("description");

                entity.Property(e => e.Name)
                    .HasMaxLength(50)
                    .HasColumnName("name");
            });

            modelBuilder.Entity<TypeOfUser>(entity =>
            {
                entity.HasKey(e => new { e.Id, e.UserId });

                entity.Property(e => e.Id)
                    .ValueGeneratedOnAdd()
                    .HasColumnName("id");

                entity.Property(e => e.UserId).HasColumnName("user_id");

                entity.Property(e => e.Category)
                    .HasMaxLength(50)
                    .IsUnicode(false)
                    .HasColumnName("category");

                entity.Property(e => e.Description)
                    .HasMaxLength(250)
                    .HasColumnName("description");

                entity.Property(e => e.Name)
                    .HasMaxLength(50)
                    .HasColumnName("name");

                entity.HasOne(d => d.User)
                    .WithMany(p => p.TypeOfUsers)
                    .HasForeignKey(d => d.UserId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_TypeOfUsers_Users");
            });

            modelBuilder.Entity<User>(entity =>
            {
                entity.Property(e => e.Id).HasColumnName("id");

                entity.Property(e => e.Email)
                    .HasMaxLength(50)
                    .IsUnicode(false)
                    .HasColumnName("email");

                entity.Property(e => e.Fullname)
                    .HasMaxLength(100)
                    .HasColumnName("fullname");

                entity.Property(e => e.Gender)
                    .HasMaxLength(100)
                    .IsUnicode(false)
                    .HasColumnName("gender");

                entity.Property(e => e.Location)
                    .HasMaxLength(50)
                    .IsUnicode(false)
                    .HasColumnName("location");

                entity.Property(e => e.Password)
                    .HasMaxLength(50)
                    .IsUnicode(false)
                    .HasColumnName("password");

                entity.Property(e => e.Phone)
                    .HasMaxLength(50)
                    .IsUnicode(false)
                    .HasColumnName("phone");

                entity.Property(e => e.Username)
                    .HasMaxLength(50)
                    .IsUnicode(false)
                    .HasColumnName("username");
            });

            OnModelCreatingPartial(modelBuilder);
        }

        partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
    }
}
