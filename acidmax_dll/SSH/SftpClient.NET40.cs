using System;
using System.Threading;

namespace TCMSSH
{
    /// <summary>
    /// 
    /// </summary>
    public partial class SftpClient
    {
        /// <summary>
        /// Executes the specified action in a separate thread.
        /// </summary>
        /// <param name="action">The action to execute.</param>
        partial void ExecuteThread(Action action)
        {
            ThreadPool.QueueUserWorkItem(o => action());
        }
    }
}