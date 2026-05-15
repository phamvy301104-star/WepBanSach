using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace WebBanSach.Models
{
    [Table("CHUDE")]
    public class Category
    {
        [Key]
        [Column("MaCD")]
        public int CategoryID { get; set; }

        [Column("TenChuDe")]
        public string CategoryName { get; set; }

        [NotMapped]
        public string Description { get; set; }

        [NotMapped]
        public DateTime CreatedDate { get; set; }

        public virtual ICollection<Book> Books { get; set; }
    }
}
