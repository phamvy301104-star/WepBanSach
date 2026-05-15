using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace WebBanSach.Models
{
    [Table("SACH")]
    public class Book
    {
        [Key]
        [Column("Masach")]
        public int BookID { get; set; }

        [Column("Tensach")]
        public string BookTitle { get; set; }

        [NotMapped]
        public string Author { get; set; }

        [Column("Mota")]
        public string Description { get; set; }

        [Column("Giaban")]
        public decimal Price { get; set; }

        [Column("Soluongton")]
        public int Quantity { get; set; }

        [Column("Anhbia")]
        public string ImagePath { get; set; }

        [Column("MaCD")]
        public int CategoryID { get; set; }

        [Column("MaNXB")]
        public int PublisherID { get; set; }

        [NotMapped]
        public DateTime PublishedDate { get; set; }

        [Column("Ngaycapnhat")]
        public DateTime CreatedDate { get; set; }

        [Column("IsActive")]
        public bool IsActive { get; set; }

        public virtual Category Category { get; set; }
        public virtual Publisher Publisher { get; set; }
        public virtual ICollection<OrderDetail> OrderDetails { get; set; }
        public virtual ICollection<CartItem> CartItems { get; set; }
    }
}
