using AutoService.Data.DataProviders;
using AutoService.SharedModels;
using System.Collections.Generic;
using System.Web;
using System.Web.Http;
using Unity;
using Unity.Lifetime;
using Unity.Resolution;

namespace AutoService.WebAPI.Controllers
{
    public class AutoServiceController : ApiController
    {
        private IUnityContainer _container;

        public AutoServiceController(IUnityContainer container)
        {
            _container = container;
        }

        // GET api/AutoService
        public List<Order> Get(AutoServiceDataSource dataSource = AutoServiceDataSource.DB)
        {
            switch (dataSource)
            {
                case AutoServiceDataSource.XML:
                    _container.RegisterType<IAutoServiceDataProvider, XMLDataProvider>(new ContainerControlledLifetimeManager());
                    break;
                case AutoServiceDataSource.Binary:
                    _container.RegisterType<IAutoServiceDataProvider, BinaryDataProvider>(new ContainerControlledLifetimeManager());
                    break;
                default:
                    _container.RegisterType<IAutoServiceDataProvider, DBDataProvider>(new ContainerControlledLifetimeManager());
                    break;
            }
            return _container.Resolve<IAutoServiceDataProvider>(new ParameterOverride("dir", DataDirectory())).GetOrders();
        }

        // GET api/AutoService/5
        public Client Get(int id, AutoServiceDataSource dataSource = AutoServiceDataSource.DB)
        {
            switch (dataSource)
            {
                case AutoServiceDataSource.XML:
                    _container.RegisterType<IAutoServiceDataProvider, XMLDataProvider>(new ContainerControlledLifetimeManager());
                    break;
                case AutoServiceDataSource.Binary:
                    _container.RegisterType<IAutoServiceDataProvider, BinaryDataProvider>(new ContainerControlledLifetimeManager());
                    break;
                default:
                    _container.RegisterType<IAutoServiceDataProvider, DBDataProvider>(new ContainerControlledLifetimeManager());
                    break;
            }
            return _container.Resolve<IAutoServiceDataProvider>(new ParameterOverride("dir", DataDirectory())).GetClient(id);
        }

        private string DataDirectory()
        {
            return HttpContext.Current.Server.MapPath("/data/");
        }
    }
}
