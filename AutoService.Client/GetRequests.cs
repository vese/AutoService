using System;
using System.Collections.Generic;
using System.Net.Http;

namespace AutoService.Client
{
    public static class GetRequests
    {
        static readonly string baseAdress = "http://localhost:56598/";
        static readonly string controllerName = "api/values/";

        public static List<SharedModels.Order> GetOrders()
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(baseAdress);
                HttpResponseMessage response = client.GetAsync(controllerName).Result;
                if (response.IsSuccessStatusCode)
                {
                    return response.Content.ReadAsAsync<List<SharedModels.Order>>().Result;
                }
                else
                {
                    return null;
                }
            }
        }

        public static SharedModels.Client GetClient(int orderId)
        {

            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(baseAdress);
                HttpResponseMessage response = client.GetAsync(controllerName + orderId).Result;
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
