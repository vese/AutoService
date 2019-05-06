using AutoService.Data.Models;
using System.Collections.Generic;
using System.Linq;

namespace AutoService.Data.DataProviders
{
    public class DBDataProvider : IAutoServiceDataProvider
    {
        public List<SharedModels.Order> GetOrders()
        {
            using (var context = new AutoServiceContext())
            {
                return context.Orders.Select(o => new SharedModels.Order
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
                }).ToList();
            }
        }

        public SharedModels.Client GetClient(int orderId)
        {
            using (var context = new AutoServiceContext())
            {
                if (context.Orders.Any(o => o.Id == orderId))
                {
                    var client = context.Orders.Find(orderId).Client;
                    return new SharedModels.Client()
                    {
                        Surname = client.Surname,
                        Name = client.Name,
                        Patronymic = client.Patronymic,
                        BirthYear = client.BirthYear,
                        PhoneNumber = client.PhoneNumber.ToString()
                    };
                }
                return null;
            }
        }
    }
}
