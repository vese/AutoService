using AutoService.Data.Models;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Runtime.Serialization.Formatters.Binary;

namespace AutoService.Data
{
    public class BinaryDataProvider : IAutoServiceDataProvider
    {
        [Serializable]
        class ClientOrder
        {
            public int ClientId { get; set; }
            public int OrderId { get; set; }
        }

        [Serializable]
        class ClientWithId : SharedModels.Client
        {
            public int Id { get; set; }
        }

        [Serializable]
        class AutoService
        {
            public List<SharedModels.Order> Orders { get; set; }
            public List<ClientOrder> ClientsOrders { get; set; }
            public List<ClientWithId> Clients { get; set; }
        }

        string dir;
        readonly string fileName = "AutoServiceData.dat";

        public BinaryDataProvider(string dir)
        {
            this.dir = dir;
        }

        public void SetOrders()
        {
            using (var context = new AutoServiceContext())
            {
                var serviceData = new AutoService
                {
                    Orders = context.Orders.Select(o => new SharedModels.Order
                    {
                        Id = o.Id,
                        Make = o.Car.Model.Make.Name,
                        Model = o.Car.Model.Name,
                        ManufacturingYear = o.Car.ManufacturingYear,
                        Transmission = o.Car.Transmission.Name,
                        EnginePower = o.Car.EnginePower,
                        WorkType = o.Work.Name,
                        StartDate = o.StartDate,
                        EndDate = o.EndDate,
                        Cost = o.Cost
                    }).ToList(),
                    ClientsOrders = context.Orders.Select(o => new ClientOrder
                    {
                        OrderId = o.Id,
                        ClientId = o.ClientId
                    }).ToList(),
                    Clients = context.Clients.Select(c => new ClientWithId()
                    {
                        Id = c.Id,
                        Surname = c.Surname,
                        Name = c.Name,
                        Patronymic = c.Patronymic,
                        BirthYear = c.BirthYear,
                        PhoneNumber = c.PhoneNumber.ToString()
                    }).ToList()
                };
                BinaryFormatter formatter = new BinaryFormatter();
                using (FileStream fs = new FileStream(dir + fileName, FileMode.CreateNew))
                {
                    formatter.Serialize(fs, serviceData);
                }
            };
        }

        public List<SharedModels.Order> GetOrders()
        {
            BinaryFormatter formatter = new BinaryFormatter();

            using (FileStream fs = new FileStream(dir + fileName, FileMode.OpenOrCreate))
            {
                var serviceData = (AutoService)formatter.Deserialize(fs);
                return serviceData.Orders;
            }
        }

        public SharedModels.Client GetClient(int orderId)
        {
            BinaryFormatter formatter = new BinaryFormatter();

            using (FileStream fs = new FileStream(dir + fileName, FileMode.OpenOrCreate))
            {
                var serviceData = (AutoService)formatter.Deserialize(fs);
                var clientId = serviceData.ClientsOrders.FirstOrDefault(o => o.OrderId == orderId)?.ClientId;
                return clientId == null ? null : serviceData.Clients.FirstOrDefault(c => c.Id == clientId);
            }
        }
    }
}
