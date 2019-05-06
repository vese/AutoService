using System.Collections.Generic;

namespace AutoService.Data.DataProviders
{
    public interface IAutoServiceDataProvider
    {
        List<SharedModels.Order> GetOrders();
        SharedModels.Client GetClient(int orderId);
    }
}
