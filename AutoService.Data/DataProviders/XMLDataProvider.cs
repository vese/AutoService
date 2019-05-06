using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Xml.Linq;

namespace AutoService.Data.DataProviders
{
    public class XMLDataProvider : IAutoServiceDataProvider
    {
        string dir;
        readonly string fileName = "AutoServiceData.xml";

        public XMLDataProvider(string dir)
        {
            this.dir = dir;
        }

        public List<SharedModels.Order> GetOrders()
        {
            try
            {
                return XDocument.Load(dir + fileName).Element("AutoService").Element("Orders").Elements("Order").Select(o =>
                {
                    DateTime end;
                    bool ended = !string.IsNullOrEmpty(o.Element("EndDate").Value);
                    if (int.TryParse(o.Element("Id").Value, out int id) &&
                    short.TryParse(o.Element("ManufacturingYear").Value, out short mYear) &&
                    short.TryParse(o.Element("EnginePower").Value, out short enPower) &&
                    DateTime.TryParse(o.Element("StartDate").Value, out DateTime start) &&
                    (DateTime.TryParse(o.Element("EndDate").Value, out end) || !ended) &&
                    decimal.TryParse(o.Element("Cost").Value, NumberStyles.Any, CultureInfo.InvariantCulture, out decimal cost))
                    {
                        return new SharedModels.Order
                        {
                            Id = id,
                            Make = o.Element("Make").Value,
                            Model = o.Element("Model").Value,
                            ManufacturingYear = mYear,
                            Transmission = o.Element("Transmission").Value,
                            EnginePower = enPower,
                            WorkType = o.Element("WorkType").Value,
                            StartDate = start,
                            EndDate = ended ? (DateTime?)end : null,
                            Cost = cost
                        };
                    }
                    return null;
                }).Where(o => o != null).ToList();
            }
            catch (Exception e)
            {
                ExceptionLogger.Instance(dir).LogException(e.ToString());
                return null;
            }
        }

        public SharedModels.Client GetClient(int orderId)
        {
            try
            {
                var clientId = XDocument.Load(dir + fileName).Element("AutoService").Element("ClientsOrders").Elements("ClientOrder").FirstOrDefault(c => c.Element("OrderId").Value == orderId.ToString())?.Element("ClientId").Value;
                if (clientId == null)
                {
                    return null;
                }
                var client = XDocument.Load(dir + fileName).Element("AutoService").Element("Clients").Elements("Client").FirstOrDefault(c => c.Element("Id").Value == clientId);
                return client == null ? null :
                    short.TryParse(client.Element("BirthYear").Value, out short bYear) ?
                    new SharedModels.Client
                    {
                        Name = client.Element("Name").Value,
                        Surname = client.Element("Surname").Value,
                        Patronymic = client.Element("Patronymic").Value,
                        BirthYear = bYear,
                        PhoneNumber = client.Element("PhoneNumber").Value,
                    } : null;
            }
            catch (Exception e)
            {
                ExceptionLogger.Instance(dir).LogException(e.ToString());
                return null;
            }
}
    }
}
