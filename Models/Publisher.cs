using System;
using System.Collections.Generic;

namespace WebBanSach.Models
{
    public class Publisher
    {
        public int PublisherID { get; set; }
        public string PublisherName { get; set; }
        public string Address { get; set; }
        public string Phone { get; set; }
        public string Email { get; set; }
        public DateTime CreatedDate { get; set; }

        public virtual ICollection<Book> Books { get; set; }
    }
}
