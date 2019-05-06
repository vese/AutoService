using AutoService.Data.Models;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
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

        public void SetOrders()
        {
            using (var context = new AutoServiceContext())
            {
                var orders = new XElement("Orders");
                context.Orders.ToList().ForEach(o =>
                {
                    orders.Add(new XElement("Order",
                        new XElement("Id", o.Id),
                        new XElement("Make", o.Car.Model.Make.Name),
                        new XElement("Model", o.Car.Model.Name),
                        new XElement("ManufacturingYear", o.Car.ManufacturingYear),
                        new XElement("Transmission", o.Car.Transmission.Name),
                        new XElement("EnginePower", o.Car.EnginePower),
                        new XElement("WorkType", o.Work.Name),
                        new XElement("StartDate", o.StartDate),
                        new XElement("EndDate", o.EndDate),
                        new XElement("Cost", o.Cost)));
                });

                var clients = new XElement("Clients");
                context.Clients.ToList().ForEach(c =>
                {
                    clients.Add(new XElement("Client",
                        new XElement("Id", c.Id),
                        new XElement("Surname", c.Surname),
                        new XElement("Name", c.Name),
                        new XElement("Patronymic", c.Patronymic),
                        new XElement("BirthYear", c.BirthYear),
                        new XElement("PhoneNumber", c.PhoneNumber)));
                });

                var clientsOrders = new XElement("ClientsOrders");
                context.Orders.ToList().ForEach(o =>
                {
                    clientsOrders.Add(new XElement("ClientOrder",
                        new XElement("OrderId", o.Id),
                        new XElement("ClientId", o.ClientId)));
                });
                if (!Directory.Exists(dir))
                {
                    Directory.CreateDirectory(dir);
                }
                new XDocument(new XElement("AutoService", orders, clients, clientsOrders)).Save(dir + fileName);
            }
        }

        public List<SharedModels.Order> GetOrders()
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

        public SharedModels.Client GetClient(int orderId)
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
    }
}
