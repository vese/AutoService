using System.Collections.Generic;

namespace AutoService.Data
{
    interface IAutoServiceDataProvider
    {
        List<SharedModels.Order> GetOrders();
        SharedModels.Client GetClient(int orderId);
    }
}
