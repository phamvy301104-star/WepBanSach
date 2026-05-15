using System;
using System.Collections.Generic;

namespace WebBanSach.Models
{
    public class Order
    {
        public int OrderID { get; set; }
        public int UserID { get; set; }
        public DateTime OrderDate { get; set; }
        public decimal TotalAmount { get; set; }
        public int Status { get; set; } // 0: Pending, 1: Confirmed, 2: Shipped, 3: Delivered, 4: Cancelled
        public string ShippingAddress { get; set; }
        public string Note { get; set; }
        public DateTime UpdatedDate { get; set; }

        public virtual User User { get; set; }
        public virtual ICollection<OrderDetail> OrderDetails { get; set; }
    }
}
