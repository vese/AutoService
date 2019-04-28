using AutoService.Data;
using AutoService.SharedModels;
using System.Collections.Generic;
using System.Web;
using System.Web.Http;

namespace AutoService.WebAPI.Controllers
{
    public class AutoServiceController : ApiController
    {
        // GET api/AutoService
        public List<Order> Get(AutoServiceDataSource dataSource = AutoServiceDataSource.DB)
        {
            switch (dataSource)
            {
                case AutoServiceDataSource.XML:
                    return new XMLDataProvider(DataDirectory()).GetOrders();
                //case AutoServiceDataSource.Binary:
                //    return new BinaryDataProvider(DataDirectory()).GetOrders();
                default:
                    return new DBDataProvider().GetOrders();
            }
        }

        // GET api/AutoService/5
        public Client Get(int id, AutoServiceDataSource dataSource = AutoServiceDataSource.DB)
        {
            switch (dataSource)
            {
                case AutoServiceDataSource.XML:
                    return new XMLDataProvider(DataDirectory()).GetClient(id);
                //case AutoServiceDataSource.Binary:
                //return new DBDataProvider(DataDirectory()).GetClient(id);
                default:
                    return new DBDataProvider().GetClient(id);
            }
        }

        private string DataDirectory()
        {
            return HttpContext.Current.Server.MapPath("/data/");
        }
    }
}
