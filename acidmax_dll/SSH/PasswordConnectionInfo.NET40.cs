using System.Threading.Tasks;
using System;

namespace TCMSSH
{
    /// <summary>
    /// Provides connection information when password authentication method is used
    /// </summary>
    public partial class PasswordConnectionInfo 
    {
        partial void ExecuteThread(Action action)
        {
            Task.Factory.StartNew(action);
        }
    }
}
