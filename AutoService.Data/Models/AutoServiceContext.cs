namespace AutoService.Data.Models
{
    using System.Data.Entity;

    public partial class AutoServiceContext : DbContext
    {
        public AutoServiceContext()
            : base("name=AutoServiceContext")
        {
        }

        public virtual DbSet<Car> Cars { get; set; }
        public virtual DbSet<Client> Clients { get; set; }
        public virtual DbSet<Make> Makes { get; set; }
        public virtual DbSet<Model> Models { get; set; }
        public virtual DbSet<Order> Orders { get; set; }
        public virtual DbSet<Transmission> Transmissions { get; set; }
        public virtual DbSet<Work> Works { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Car>()
                .HasMany(e => e.Orders)
                .WithRequired(e => e.Car)
                .HasForeignKey(e => e.CarId)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<Client>()
                .Property(e => e.PhoneNumber)
                .HasPrecision(11, 0);

            modelBuilder.Entity<Client>()
                .HasMany(e => e.Cars)
                .WithRequired(e => e.Client)
                .HasForeignKey(e => e.OwnerId)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<Client>()
                .HasMany(e => e.Orders)
                .WithRequired(e => e.Client)
                .HasForeignKey(e => e.ClientId)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<Make>()
                .HasMany(e => e.Models)
                .WithRequired(e => e.Make)
                .HasForeignKey(e => e.MakeId)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<Model>()
                .HasMany(e => e.Cars)
                .WithRequired(e => e.Model)
                .HasForeignKey(e => e.ModelId)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<Order>()
                .Property(e => e.Cost)
                .HasPrecision(19, 4);

            modelBuilder.Entity<Transmission>()
                .HasMany(e => e.Cars)
                .WithRequired(e => e.Transmission)
                .HasForeignKey(e => e.TransmissionId)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<Work>()
                .HasMany(e => e.Orders)
                .WithRequired(e => e.Work)
                .HasForeignKey(e => e.WorkTypeId)
                .WillCascadeOnDelete(false);
        }
    }
}
