using Apex.MVVM;
using AutoService.SharedModels;
using System.ComponentModel;
using System.Runtime.CompilerServices;
using System.Windows.Input;

namespace AutoService.Client
{
    class OrdersViewModel : INotifyPropertyChanged
    {
        private SafeObservableCollection<Order> _orders = new SafeObservableCollection<Order>();
        public SafeObservableCollection<Order> Orders
        {
            get { return _orders; }
            set
            {
                _orders = value;
                OnPropertyChanged("Orders");
            }
        }

        public Order SelectedOrder
        {
            set
            {
                SelectedClient = GetRequests.GetClient(value.Id, SelectedDataSource);
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
            GetOrdersCommand = new AsynchronousCommand(() =>
            {
                Orders.Clear();
                SelectedClient = null;
                GetRequests.GetOrders(SelectedDataSource).ForEach(o => Orders.Add(o));
            });
        }

        private AutoServiceDataSource _selectedDataSource = AutoServiceDataSource.DB;
        public AutoServiceDataSource SelectedDataSource
        {
            get
            {
                return _selectedDataSource;
            }
            set
            {
                _selectedDataSource = value;
                OnPropertyChanged("SelectedDataSource");
            }
        }

        public event PropertyChangedEventHandler PropertyChanged;
        public void OnPropertyChanged([CallerMemberName]string prop = "")
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(prop));
        }
    }
}
