namespace AutoService.Data.Models
{
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;

    [Table("Client")]
    public partial class Client
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Client()
        {
            Cars = new HashSet<Car>();
            Orders = new HashSet<Order>();
        }

        public int id { get; set; }

        [Required]
        [StringLength(30)]
        [Column(name: "name")]
        public string Name { get; set; }

        [StringLength(30)]
        [Column(name: "surname")]
        public string Surname { get; set; }

        [StringLength(30)]
        [Column(name: "patronymic")]
        public string Patronymic { get; set; }

        [Column(name: "birth_year")]
        public short BirthYear { get; set; }

        [Column(name: "phone_number")]
        public decimal PhoneNumber { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Car> Cars { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Order> Orders { get; set; }
    }
}
