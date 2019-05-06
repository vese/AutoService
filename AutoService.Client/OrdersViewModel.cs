using Apex.MVVM;
using AutoService.SharedModels;
using System.Windows;
using System.Windows.Input;

namespace AutoService.Client
{
    class OrdersViewModel : Notifier
    {
        private SafeObservableCollection<Order> _orders = new SafeObservableCollection<Order>();
        public SafeObservableCollection<Order> Orders
        {
            get { return _orders; }
            set
            {
                _orders = value;
                OnPropertyChanged(nameof(Orders));
            }
        }

        public Order SelectedOrder
        {
            set
            {
                if ((SelectedClient = GetRequests.GetClient(value.Id, LoadedDataSource)) == null)
                {
                    MessageBox.Show("Произошла ошибка при запросе списка заказов.", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                }
            }
        }

        private SharedModels.Client _selectedClient;
        public SharedModels.Client SelectedClient
        {
            get { return _selectedClient; }
            set
            {
                _selectedClient = value;
                OnPropertyChanged(nameof(SelectedClient));
            }
        }

        public ICommand GetOrdersCommand { get; private set; }

        public OrdersViewModel()
        {
            GetOrdersCommand = new AsynchronousCommand(() =>
            {
                var orders = GetRequests.GetOrders(SelectedDataSource);
                if (orders == null)
                {
                    MessageBox.Show("Произошла ошибка при запросе списка заказов.", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                    return;
                }
                Orders.Clear();
                SelectedClient = null;
                orders.ForEach(o => Orders.Add(o));
                Loaded = Visibility.Visible;
                LoadedDataSource = SelectedDataSource;
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
                OnPropertyChanged(nameof(SelectedDataSource));
            }
        }

        private AutoServiceDataSource _loadedDataSource;
        public AutoServiceDataSource LoadedDataSource
        {
            get
            {
                return _loadedDataSource;
            }
            set
            {
                _loadedDataSource = value;
                OnPropertyChanged(nameof(LoadedDataSource));
            }
        }

        private Visibility _loaded = Visibility.Collapsed;
        public Visibility Loaded
        {
            get
            {
                return _loaded;
            }
            set
            {
                _loaded = value;
                OnPropertyChanged(nameof(Loaded));
            }
        }
    }
}
