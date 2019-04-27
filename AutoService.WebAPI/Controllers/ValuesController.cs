using AutoService.Data;
using System.Collections.Generic;
using System.Web.Http;

namespace AutoService.WebAPI.Controllers
{
    public class ValuesController : ApiController
    {
        // GET api/values
        public List<SharedModels.Order> Get()
        {
            return new DBDataProvider().GetOrders();
        }

        // GET api/values/5
        public SharedModels.Client Get(int id)
        {
            return new DBDataProvider().GetClient(id);
        }
    }
}
