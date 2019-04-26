namespace AutoService.Data.Models
{
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations.Schema;

    [Table("Car")]
    public partial class Car
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Car()
        {
            Orders = new HashSet<Order>();
        }

        [Column(name: "id")]
        public int Id { get; set; }

        [Column(name: "model_id")]
        public int ModelId { get; set; }

        [Column(name: "owner_id")]
        public int OwnerId { get; set; }

        [Column(name: "manufacturing_year")]
        public short ManufacturingYear { get; set; }

        [Column(name: "transmission_id")]
        public int TransmissionId { get; set; }

        [Column(name: "engine_power")]
        public short EnginePower { get; set; }

        public virtual Model Model { get; set; }

        public virtual Client Client { get; set; }

        public virtual Transmission Transmission { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Order> Orders { get; set; }
    }
}
