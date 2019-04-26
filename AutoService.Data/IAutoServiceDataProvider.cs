using AutoService.Data.ViewModels;
using System.Collections.Generic;

namespace AutoService.Data
{
    interface IAutoServiceDataProvider
    {
        List<Order> GetOrders();
        Client GetClient(int orderId);
    }
}
