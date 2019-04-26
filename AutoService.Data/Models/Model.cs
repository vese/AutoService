namespace AutoService.Data.Models
{
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;

    [Table("Model")]
    public partial class Model
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Model()
        {
            Cars = new HashSet<Car>();
        }

        [Column(name: "id")]
        public int Id { get; set; }

        [Required]
        [StringLength(30)]
        [Column(name: "name")]
        public string Name { get; set; }

        [Column(name: "make_id")]
        public int MakeId { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Car> Cars { get; set; }

        public virtual Make Make { get; set; }
    }
}
