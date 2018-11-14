namespace acidmax.Models.SystemStatistics {
    /// <summary>
    /// CPU Model
    /// </summary>
    public class CpuModel {
        /// <summary>
        /// Address Width
        /// </summary>
        public string AddressWidth { get; set; }
        /// <summary>
        /// Architecture
        /// </summary>
        public string Architecture { get; set; }
        /// <summary>
        /// Asset Tag
        /// </summary>
        public string AssetTag { get; set; }
        /// <summary>
        /// Availability
        /// </summary>
        public string Availability { get; set; }
        /// <summary>
        /// Caption
        /// </summary>
        public string Caption { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string Characteristics { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string ConfigManagerErrorCode { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string ConfigManagerUserConfig { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string CpuStatus { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string CreationClassName { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string CurrentClockSpeed { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string CurrentVoltage { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string DataWidth { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string Description { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string DeviceID { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string ErrorCleared { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string ErrorDescription { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string ExtClock { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string Family { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string InstallDate { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string L2CacheSize { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string L2CacheSpeed { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string L3CacheSize { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string L3CacheSpeed { get; set; }
        /// <summary>
        /// Last Error Code
        /// </summary>
        public string LastErrorCode { get; set; }
        /// <summary>
        /// Level
        /// </summary>
        public string Level { get; set; }
        /// <summary>
        /// Load Percentage
        /// </summary>
        public string LoadPercentage { get; set; }
        /// <summary>
        /// Manufacturer
        /// </summary>
        public string Manufacturer { get; set; }
        /// <summary>
        /// Max Cloc kSpeed
        /// </summary>
        public string MaxClockSpeed { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string Name { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string NumberOfCores { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string NumberOfEnabledCore { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string NumberOfLogicalProcessors { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string OtherFamilyDescription { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string PartNumber { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string PNPDeviceID { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string PowerManagementCapabilities { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string PowerManagementSupported { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string ProcessorId { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string ProcessorType { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string Revision { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string Revision { get; set; }

        /*
                    if(queryObj["PowerManagementCapabilities"] == null)
                        Console.WriteLine("PowerManagementCapabilities: {0}", queryObj["PowerManagementCapabilities"]);
                    else
                    {
                        UInt16[] arrPowerManagementCapabilities = (UInt16[])(queryObj["PowerManagementCapabilities"]);
                        foreach (UInt16 arrValue in arrPowerManagementCapabilities)
                        {
                            Console.WriteLine("PowerManagementCapabilities: {0}", arrValue);
                        }
}
                    Console.WriteLine("PowerManagementSupported: {0}", queryObj["PowerManagementSupported"]);
                    Console.WriteLine("ProcessorId: {0}", queryObj["ProcessorId"]);
                    Console.WriteLine("ProcessorType: {0}", queryObj["ProcessorType"]);
                    Console.WriteLine("Revision: {0}", queryObj["Revision"]);
                    Console.WriteLine("Role: {0}", queryObj["Role"]);
                    Console.WriteLine("SecondLevelAddressTranslationExtensions: {0}", queryObj["SecondLevelAddressTranslationExtensions"]);
                    Console.WriteLine("SerialNumber: {0}", queryObj["SerialNumber"]);
                    Console.WriteLine("SocketDesignation: {0}", queryObj["SocketDesignation"]);
                    Console.WriteLine("Status: {0}", queryObj["Status"]);
                    Console.WriteLine("StatusInfo: {0}", queryObj["StatusInfo"]);
                    Console.WriteLine("Stepping: {0}", queryObj["Stepping"]);
                    Console.WriteLine("SystemCreationClassName: {0}", queryObj["SystemCreationClassName"]);
                    Console.WriteLine("SystemName: {0}", queryObj["SystemName"]);
                    Console.WriteLine("ThreadCount: {0}", queryObj["ThreadCount"]);
                    Console.WriteLine("UniqueId: {0}", queryObj["UniqueId"]);
                    Console.WriteLine("UpgradeMethod: {0}", queryObj["UpgradeMethod"]);
                    Console.WriteLine("Version: {0}", queryObj["Version"]);
                    Console.WriteLine("VirtualizationFirmwareEnabled: {0}", queryObj["VirtualizationFirmwareEnabled"]);
                    Console.WriteLine("VMMonitorModeExtensions: {0}", queryObj["VMMonitorModeExtensions"]);
                    Console.WriteLine("VoltageCaps: {0}", queryObj["VoltageCaps"]);
                    */
    }
}