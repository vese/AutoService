namespace AutoService.Data.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Order")]
    public partial class Order
    {
        public int id { get; set; }

        public int client_id { get; set; }

        public int car_id { get; set; }

        public int work_type_id { get; set; }

        public DateTime start_date { get; set; }

        public DateTime? end_date { get; set; }

        [Column(TypeName = "money")]
        public decimal cost { get; set; }

        public virtual Car Car { get; set; }

        public virtual Client Client { get; set; }

        public virtual Work Work { get; set; }
    }
}
