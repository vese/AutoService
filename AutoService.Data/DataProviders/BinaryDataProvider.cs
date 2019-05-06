using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Runtime.Serialization.Formatters.Binary;

namespace AutoService.Data.DataProviders
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

        public List<SharedModels.Order> GetOrders()
        {
            BinaryFormatter formatter = new BinaryFormatter();

            try
            {
                using (FileStream fs = new FileStream(dir + fileName, FileMode.OpenOrCreate))
                {
                    var serviceData = (AutoService)formatter.Deserialize(fs);
                    return serviceData.Orders;
                }
            }
            catch (Exception e)
            {
                ExceptionLogger.Instance(dir).LogException(e.ToString());
                return null;
            }
        }

        public SharedModels.Client GetClient(int orderId)
        {
            BinaryFormatter formatter = new BinaryFormatter();

            try
            {
                using (FileStream fs = new FileStream(dir + fileName, FileMode.OpenOrCreate))
                {
                    var serviceData = (AutoService)formatter.Deserialize(fs);
                    var clientId = serviceData.ClientsOrders.FirstOrDefault(o => o.OrderId == orderId)?.ClientId;
                    return clientId == null ? null : serviceData.Clients.FirstOrDefault(c => c.Id == clientId);
                }
            }
            catch (Exception e)
            {
                ExceptionLogger.Instance(dir).LogException(e.ToString());
                return null;
            }
        }
    }
}
