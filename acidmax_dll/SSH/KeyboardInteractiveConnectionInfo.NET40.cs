using System.Threading.Tasks;
using System;

namespace TCMSSH
{
    /// <summary>
    /// Provides connection information when keyboard interactive authentication method is used
    /// </summary>
    public partial class KeyboardInteractiveConnectionInfo
    {
        partial void ExecuteThread(Action action)
        {
            Task.Factory.StartNew(action);
        }
    }
}
