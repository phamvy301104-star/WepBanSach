using System;

namespace WebBanSach.Models
{
    public class CartItem
    {
        public int CartItemID { get; set; }
        public int UserID { get; set; }
        public int BookID { get; set; }
        public int Quantity { get; set; }
        public DateTime AddedDate { get; set; }

        public virtual User User { get; set; }
        public virtual Book Book { get; set; }
    }
}
