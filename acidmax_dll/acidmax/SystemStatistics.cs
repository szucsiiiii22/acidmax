//using System.Runtime.InteropServices;
using acidmax.Models.SystemStatistics;
using System.Management;
namespace acidmax {
    /// <summary>
    /// System Statistics
    /// </summary>
    //[Guid("")]
    public interface ISystemStatistics {

    }
    /// <summary>
    /// Program Events
    /// </summary>
    //[Guid(""), InterfaceType(ComInterfaceType.InterfaceIsIDispatch)]
    public interface ISystemStatisticsProgramEvents {

    }
    /// <summary>
    /// System Statistics
    /// </summary>
    //[Guid(""), ClassInterface(ClassInterfaceType.None), ComSourceInterfaces(typeof(ISystemStatisticsProgramEvents))]
    public class SystemStatistics : ISystemStatistics {
        /// <summary>
        /// CPU
        /// </summary>
        /// <returns></returns>
        public CpuModel CPU() {
            var result = new CpuModel();
            ManagementObjectSearcher searcher =
                new ManagementObjectSearcher("root\\CIMV2",
                "SELECT * FROM Win32_Processor");
            foreach (ManagementObject queryObj in searcher.Get()) {
                result.AddressWidth = queryObj["AddressWidth"].ToString();
                result.Caption = queryObj["Caption"].ToString();
            }
            return result;
        }
    }
}