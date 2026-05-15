using System;
using System.Collections.Generic;

namespace WebBanSach.Models
{
    public class User
    {
        public int UserID { get; set; }
        public string FullName { get; set; }
        public string Email { get; set; }
        public string Password { get; set; }
        public string Phone { get; set; }
        public DateTime DateOfBirth { get; set; }
        public string Address { get; set; }
        public int Role { get; set; } // 0: User, 1: Admin
        public bool IsActive { get; set; }
        public DateTime CreatedDate { get; set; }

        public virtual ICollection<Order> Orders { get; set; }
        public virtual ICollection<CartItem> CartItems { get; set; }
    }
}
