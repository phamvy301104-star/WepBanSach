using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace WebBanSach.Models
{
    [Table("NHAXUATBAN")]
    public class Publisher
    {
        [Key]
        [Column("MaNXB")]
        public int PublisherID { get; set; }

        [Column("TenNXB")]
        public string PublisherName { get; set; }

        [Column("Diachi")]
        public string Address { get; set; }

        [Column("DienThoai")]
        public string Phone { get; set; }

        [NotMapped]
        public string Email { get; set; }

        [NotMapped]
        public DateTime CreatedDate { get; set; }

        public virtual ICollection<Book> Books { get; set; }
    }
}
