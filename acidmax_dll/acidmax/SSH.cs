// C:\Windows\Microsoft.NET\Framework\v4.0.30319\RegAsm.exe /codebase C:\dev\team-nexgen\acidmax\acidmax\com\acidmax.dll
using System.Runtime.InteropServices;
using TCMSSH;
using System;
using System.Net.Sockets;
namespace acidmax {
    /// <summary>
    /// IProgram
    /// </summary>
    [Guid("EAA4976A-45C3-4BC5-BC0B-E474F4C3C83F")]
    public interface ISSH {
        /// <summary>
        /// Last Error
        /// </summary>
        /// <returns></returns>
        [DispId(1)]
        string LastError();
        /// <summary>
        /// Connected
        /// </summary>
        /// <returns></returns>
        [DispId(2)]
        bool Connected();
        /// <summary>
        /// Set Connect Info
        /// </summary>
        /// <param name="remoteFtp"></param>
        /// <param name="remotePort"></param>
        /// <param name="username"></param>
        /// <param name="password"></param>
        [DispId(3)]
        void SetConnectInfo(string remoteFtp, int remotePort, string username, string password);
        /// <summary>
        /// Disconnect
        /// </summary>
        [DispId(4)]
        void Disconnect();
        /// <summary>
        /// Connect
        /// </summary>
        [DispId(5)]
        void Connect();
        /// <summary>
        /// List Directory
        /// </summary>
        /// <param name="path"></param>
        /// <returns></returns>
        [DispId(6)]
        string ListDirectory(string path);
        /// <summary>
        /// Download File
        /// </summary>
        /// <param name="remotePath"></param>
        /// <param name="localPath"></param>
        /// <returns></returns>
        [DispId(7)]
        bool DownloadFile(string remotePath, string localPath);
        /// <summary>
        /// Upload File
        /// </summary>
        /// <param name="localPath"></param>
        /// <param name="remotePath"></param>
        /// <returns></returns>
        [DispId(8)]
        bool UploadFile(string localPath, string remotePath);
        /// <summary>
        /// Test Message
        /// </summary>
        /// <returns></returns>
        [DispId(9)]
        string TestMessage();
    }
    /// <summary>
    /// Program Events
    /// </summary>
    [Guid("7BD20046-DF8C-44A6-8F6B-687FAA26FA71"), InterfaceType(ComInterfaceType.InterfaceIsIDispatch)]
    public interface IProgramEvents {
    }
    /// <summary>
    /// Program
    /// </summary>
    [Guid("0D53A3E8-E51A-49C7-944E-E72A2064F938"), ClassInterface(ClassInterfaceType.None), ComSourceInterfaces(typeof(IProgramEvents))]
    public class SSH : ISSH {
        /// <summary>
        /// Connection Info
        /// </summary>
        private ConnectionInfo connectionInfo;
        /// <summary>
        /// Client
        /// </summary>
        private SftpClient client;
        /// <summary>
        /// Last Error
        /// </summary>
        private string _lastError;
        /// <summary>
        /// Last Error
        /// </summary>
        public string LastError() {
            return _lastError;
        }
        /// <summary>
        /// Test Message
        /// </summary>
        /// <returns></returns>
        public string TestMessage() {
            return "Testing,";
        }
        /// <summary>
        /// Connected
        /// </summary>
        /// <returns></returns>
        public bool Connected() {
            return client.IsConnected;
        }
        /// <summary>
        /// Set Connect Info
        /// </summary>
        /// <param name="remoteFtp"></param>
        /// <param name="remotePort"></param>
        /// <param name="username"></param>
        /// <param name="password"></param>
        public void SetConnectInfo(string remoteFtp, int remotePort, string username, string password) {
            if (!client.IsConnected) {
                connectionInfo = new ConnectionInfo(host: remoteFtp, port: remotePort, username: username, authenticationMethods: new AuthenticationMethod[] { new PasswordAuthenticationMethod(username, password) });
            }
        }
        /// <summary>
        /// Disconnect
        /// </summary>
        public void Disconnect() {
            client.Disconnect();
        }
        /// <summary>
        /// Connect
        /// </summary>
        public void Connect() {
            try {
                client = new SftpClient(connectionInfo);
                if (connectionInfo != null) {
                    client = new SftpClient(connectionInfo);
                    client.Connect();
                } else {
                    _lastError = "Connection Info Not Initialised";
                }
            } catch (Exception ex) {
                _lastError = ex.Message;
            }
        }
        /// <summary>
        /// Execute Command
        /// </summary>
        /// <param name="command"></param>
        /// <returns></returns>
        public string ListDirectory(string path) {
            try {
                var obj = client.ListDirectory(path);
                var msg = "";
                foreach (var o in obj) {
                    msg += o.Name + Environment.NewLine;
                }
                return msg.Trim();
            } catch (Exception ex) {
                _lastError = ex.Message;
                return "";
            }
        }
        /// <summary>
        /// Download File
        /// </summary>
        /// <param name="remotePath"></param>
        /// <param name="localPath"></param>
        /// <returns></returns>
        public bool DownloadFile(string remotePath, string localPath) {
            try {
                using (var stream = System.IO.File.OpenRead(localPath)) {
                    client.DownloadFile(remotePath, stream);
                }
                return true;
            } catch (Exception ex) {
                _lastError = ex.Message;
                return false;
            }
        }
        /// <summary>
        /// Upload File
        /// </summary>
        /// <param name="remotePath"></param>
        /// <param name="localPath"></param>
        /// <returns></returns>
        public bool UploadFile(string localPath, string remotePath) {
            try {
                using (var stream = System.IO.File.OpenRead(localPath)) {
                    client.UploadFile(stream, remotePath);
                }
                return true;
            } catch (Exception ex) {
                _lastError = ex.Message;
                return false;
            }
        }
    }
}