namespace AutoService.SharedModels
{
    public class Client
    {
        public string Surname { get; set; }
        public string Name { get; set; }
        public string Patronymic { get; set; }
        public short BirthYear { get; set; }
        public string PhoneNumber { get; set; }

        public override string ToString()
        {
            return $"{Surname} {Name} {Patronymic} {BirthYear} {PhoneNumber}";
        }
    }
}
