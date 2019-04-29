using System;

namespace AutoService.SharedModels
{
    [Serializable]
    public class Order
    {
        public int Id { get; set; }
        public string Make { get; set; }
        public string Model { get; set; }
        public short ManufacturingYear { get; set; }
        public string Transmission { get; set; }
        public short EnginePower { get; set; }
        public string WorkType { get; set; }
        public DateTime StartDate { get; set; }
        public DateTime? EndDate { get; set; }
        public decimal Cost { get; set; }
    }
}
