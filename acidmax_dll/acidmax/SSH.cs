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
        /// Remote Path
        /// </summary>
        /// <param name="localPath"></param>
        /// <returns></returns>
        [DispId(14)]
        string RemotePath(string remotePath);
        /// <summary>
        /// Connected
        /// </summary>
        /// <returns></returns>
        [DispId(2)]
        string Connected();
        /// <summary>
        /// Set Connect Info
        /// </summary>
        /// Disconnect
        /// </summary>
        [DispId(3)]
        void Disconnect();
        /// <summary>
        /// Connect
        /// </summary>
        /// <returns></returns>
        [DispId(4)]
        string Connect();
        /// <summary>
        /// List Directory
        /// </summary>
        /// <param name="path"></param>
        /// <returns></returns>
        [DispId(5)]
        string List();
        /// <summary>
        /// Download File
        /// </summary>
        /// <returns></returns>
        [DispId(6)]
        string DownloadFile();
        /// <summary>
        /// Upload File
        /// </summary>
        /// <param name="localPath"></param>
        /// <param name="remotePath"></param>
        /// <returns></returns>
        [DispId(7)]
        string UploadFile();
        /// <summary>
        /// Set Host
        /// </summary>
        /// <param name="host"></param>
        /// <returns></returns>
        [DispId(8)]
        string Host(string host);
        /// <summary>
        /// Port
        /// </summary>
        /// <param name="port"></param>
        /// <returns></returns>
        [DispId(9)]
        string Port(string port);
        /// <summary>
        /// User
        /// </summary>
        /// <param name="user"></param>
        /// <returns></returns>
        [DispId(10)]
        string User(string user);
        /// <summary>
        /// Password
        /// </summary>
        /// <param name="password"></param>
        /// <returns></returns>
        [DispId(11)]
        string Password(string password);
        /// <summary>
        /// Local Path
        /// </summary>
        /// <param name="localPath"></param>
        /// <returns></returns>
        [DispId(12)]
        string LocalPath(string localPath);
        /// <summary>
        /// Info
        /// </summary>
        /// <returns></returns>
        [DispId(13)]
        string Info();
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
        private string _remotePath;
        /// <summary>
        /// Host
        /// </summary>
        private string _host;
        /// <summary>
        /// Port
        /// </summary>
        private int _port;
        /// <summary>
        /// User
        /// </summary>
        private string _user;
        /// <summary>
        /// Password
        /// </summary>
        private string _password;
        /// <summary>
        /// Connection Info
        /// </summary>
        private ConnectionInfo _connectionInfo;
        /// <summary>
        /// Client
        /// </summary>
        private SftpClient _client;
        /// <summary>
        /// Local Path
        /// </summary>
        private string _localPath;
        /// <summary>
        /// Set Host
        /// </summary>
        /// <param name="host"></param>
        /// <returns></returns>
        public string Host(string host) {
            _host = host;
            return host;
        }
        /// <summary>
        /// Local Path
        /// </summary>
        /// <param name="localPath"></param>
        /// <returns></returns>
        public string LocalPath(string localPath) {
            _localPath = localPath;
            return localPath;
        }
        /// <summary>
        /// Info
        /// </summary>
        /// <returns></returns>
        public string Info() {
            return _host + ":" + _port + "@" + _user;
        }
        /// <summary>
        /// Port
        /// </summary>
        /// <param name="port"></param>
        /// <returns></returns>
        public string Port(string port) {
            var n = 0;
            if (int.TryParse(port, out n)) {
                _port = n;
            }
            return port;
        }
        /// <summary>
        /// User
        /// </summary>
        /// <param name="user"></param>
        /// <returns></returns>
        public string User(string user) {
            _user = user;
            return user;
        }
        /// <summary>
        /// Password
        /// </summary>
        /// <param name="password"></param>
        /// <returns></returns>
        public string Password(string password) {
            _password = password;
            return password;
        }
        /// <summary>
        /// Connected
        /// </summary>
        /// <returns></returns>
        public string Connected() {
            if (_client != null) {
                return _client.IsConnected.ToString();
            } else {
                return "false";
            }
        }
        /// <summary>
        /// Disconnect
        /// </summary>
        public void Disconnect() {
            if (_client != null) {
                _client.Disconnect();
            }
        }
        /// <summary>
        /// Connect
        /// </summary>
        public string Connect() {
            try {
                _connectionInfo = new ConnectionInfo(host: _host, port: _port, username: _user, authenticationMethods: new AuthenticationMethod[] { new PasswordAuthenticationMethod(_user, _password) });
                _client = new SftpClient(_connectionInfo);
                if (_connectionInfo != null) {
                    _client = new SftpClient(_connectionInfo);
                    _client.Connect();
                }
                return "Connected";
            } catch (Exception ex) {
                return "Error: " + ex.Message;
            }
        }
        /// <summary>
        /// Execute Command
        /// </summary>
        /// <param name="command"></param>
        /// <returns></returns>
        public string List() {
            try {
                var obj = _client.ListDirectory(_remotePath);
                var msg = "";
                foreach (var o in obj) {
                    msg += o.Name + Environment.NewLine;
                }
                return msg.Trim();
            } catch (Exception ex) {
                return ex.Message;
            }
        }
        /// <summary>
        /// Download File
        /// </summary>
        /// <returns></returns>
        public string DownloadFile() {
            try {
                using (var stream = System.IO.File.OpenRead(_localPath)) {
                    _client.DownloadFile(_remotePath, stream);
                }
                return "true";
            } catch (Exception ex) {
                return ex.Message;
            }
        }
        /// <summary>
        /// Upload File
        /// </summary>
        /// <returns></returns>
        public string UploadFile() {
            try {
                using (var stream = System.IO.File.OpenRead(_localPath)) {
                    _client.UploadFile(stream, _remotePath);
                }
                return "true";
            } catch (Exception ex) {
                return ex.Message;
            }
        }
        /// <summary>
        /// Remote Path
        /// </summary>
        /// <param name="remotePath"></param>
        /// <returns></returns>
        public string RemotePath(string remotePath) {
            _remotePath = remotePath;
            return remotePath;
        }
    }
}