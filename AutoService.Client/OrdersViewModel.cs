﻿using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Runtime.CompilerServices;
using System.Windows.Input;

namespace AutoService.Client
{
    class OrdersViewModel : INotifyPropertyChanged
    {
        private ObservableCollection<SharedModels.Order> _orders = new ObservableCollection<SharedModels.Order>();
        public ObservableCollection<SharedModels.Order> Orders
        {
            get { return _orders; }
            set
            {
                _orders = value;
                OnPropertyChanged("Orders");
            }
        }

        public SharedModels.Order SelectedOrder
        {
            set
            {
                SelectedClient = GetRequests.GetClient(value.Id);
            }
        }

        private SharedModels.Client _selectedClient;
        public SharedModels.Client SelectedClient
        {
            get { return _selectedClient; }
            set
            {
                _selectedClient = value;
                OnPropertyChanged("SelectedClient");
            }
        }
        public ICommand GetOrdersCommand { get; private set; }

        public OrdersViewModel()
        {
            GetOrdersCommand = new Command(() =>
            {
                Orders.Clear();
                GetRequests.GetOrders().ForEach(o => Orders.Add(o));
            });
        }

        public event PropertyChangedEventHandler PropertyChanged;

        public void OnPropertyChanged([CallerMemberName]string prop = "")
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(prop));
        }
    }
}