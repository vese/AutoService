using AutoService.SharedModels;
using System;
using System.Collections.Generic;
using System.Net.Http;

namespace AutoService.Client
{
    public static class GetRequests
    {
        static readonly string baseAdress = "http://localhost:56598/";
        static readonly string controllerName = "api/AutoService/";

        public static List<Order> GetOrders(AutoServiceDataSource dataSource)
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(baseAdress);
                HttpResponseMessage response = client.GetAsync(controllerName + $"?dataSource={dataSource}").Result;
                if (response.IsSuccessStatusCode)
                {
                    return response.Content.ReadAsAsync<List<Order>>().Result;
                }
                else
                {
                    return null;
                }
            }
        }

        public static SharedModels.Client GetClient(int orderId, AutoServiceDataSource dataSource)
        {

            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(baseAdress);
                HttpResponseMessage response = client.GetAsync(controllerName + $"?dataSource={dataSource}&id={orderId}").Result;
                if (response.IsSuccessStatusCode)
                {
                    return response.Content.ReadAsAsync<SharedModels.Client>().Result;
                }
                else
                {
                    return null;
                }
            }
        }
    }
}
