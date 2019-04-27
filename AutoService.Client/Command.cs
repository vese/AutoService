using System;
using System.Windows.Input;

namespace AutoService.Client
{
    class Command : ICommand
    {
        protected Action action = null;
        private bool canExecute = false;

        public Command(Action action, bool canExecute = true)
        {
            //  Set the action.
            this.action = action;
            this.canExecute = canExecute;
        }

        public bool CanExecute
        {
            get { return canExecute; }
            set
            {
                if (canExecute != value)
                {
                    canExecute = value;
                    EventHandler canExecuteChanged = CanExecuteChanged;
                    if (canExecuteChanged != null)
                        canExecuteChanged(this, EventArgs.Empty);
                }
            }
        }

        bool ICommand.CanExecute(object parameter)
        {
            return canExecute;
        }

        void ICommand.Execute(object parameter)
        {
            this.DoExecute();
        }

        public event EventHandler CanExecuteChanged;

        protected void InvokeAction()
        {
            Action theAction = action;
            if (theAction != null)
            {
                theAction();
            }
        }

        public virtual void DoExecute()
        {
            InvokeAction();
        }
    }
}
