namespace AutoService.Data.Models
{
    using System;
    using System.ComponentModel.DataAnnotations.Schema;

    [Table("Order")]
    public partial class Order
    {
        [Column(name: "id")]
        public int Id { get; set; }

        [Column(name: "client_id")]
        public int ClientId { get; set; }

        [Column(name: "car_id")]
        public int CarId { get; set; }

        [Column(name: "work_type_id")]
        public int WorkTypeId { get; set; }

        [Column(name: "start_date")]
        public DateTime StartDate { get; set; }

        [Column(name: "end_date")]
        public DateTime? EndDate { get; set; }

        [Column(name: "", TypeName = "money")]
        public decimal Cost { get; set; }

        public virtual Car Car { get; set; }

        public virtual Client Client { get; set; }

        public virtual Work Work { get; set; }
    }
}
