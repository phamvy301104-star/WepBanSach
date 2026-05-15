using System.Data.Entity;

namespace WebBanSach.Models
{
    public class WebBanSachContext : DbContext
    {
        public WebBanSachContext() : base("name=WebBanSachConnection")
        {
        }

        public virtual DbSet<Category> Categories { get; set; }
        public virtual DbSet<Publisher> Publishers { get; set; }
        public virtual DbSet<Book> Books { get; set; }
        public virtual DbSet<User> Users { get; set; }
        public virtual DbSet<Order> Orders { get; set; }
        public virtual DbSet<OrderDetail> OrderDetails { get; set; }
        public virtual DbSet<CartItem> CartItems { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            // Configure relationships
            modelBuilder.Entity<Book>()
                .HasRequired(b => b.Category)
                .WithMany(c => c.Books)
                .HasForeignKey(b => b.CategoryID);

            modelBuilder.Entity<Book>()
                .HasRequired(b => b.Publisher)
                .WithMany(p => p.Books)
                .HasForeignKey(b => b.PublisherID);

            modelBuilder.Entity<Order>()
                .HasRequired(o => o.User)
                .WithMany(u => u.Orders)
                .HasForeignKey(o => o.UserID);

            modelBuilder.Entity<OrderDetail>()
                .HasRequired(od => od.Order)
                .WithMany(o => o.OrderDetails)
                .HasForeignKey(od => od.OrderID);

            modelBuilder.Entity<OrderDetail>()
                .HasRequired(od => od.Book)
                .WithMany(b => b.OrderDetails)
                .HasForeignKey(od => od.BookID);

            modelBuilder.Entity<CartItem>()
                .HasRequired(ci => ci.User)
                .WithMany(u => u.CartItems)
                .HasForeignKey(ci => ci.UserID);

            modelBuilder.Entity<CartItem>()
                .HasRequired(ci => ci.Book)
                .WithMany(b => b.CartItems)
                .HasForeignKey(ci => ci.BookID);
        }
    }
}
