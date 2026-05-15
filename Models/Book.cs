using System;
using System.Collections.Generic;

namespace WebBanSach.Models
{
    public class Book
    {
        public int BookID { get; set; }
        public string BookTitle { get; set; }
        public string Author { get; set; }
        public string Description { get; set; }
        public decimal Price { get; set; }
        public int Quantity { get; set; }
        public string ImagePath { get; set; }
        public int CategoryID { get; set; }
        public int PublisherID { get; set; }
        public DateTime PublishedDate { get; set; }
        public DateTime CreatedDate { get; set; }
        public bool IsActive { get; set; }

        public virtual Category Category { get; set; }
        public virtual Publisher Publisher { get; set; }
        public virtual ICollection<OrderDetail> OrderDetails { get; set; }
        public virtual ICollection<CartItem> CartItems { get; set; }
    }
}
