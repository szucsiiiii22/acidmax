namespace TCMSSH.Common
{
    /// <summary>
    /// Provides data for <see cref="TCMSSH.PasswordConnectionInfo.PasswordExpired"/> event.
    /// </summary>
    public class AuthenticationPasswordChangeEventArgs : AuthenticationEventArgs
    {
        /// <summary>
        /// Gets or sets the new password.
        /// </summary>
        /// <value>
        /// The new password.
        /// </value>
        public byte[] NewPassword { get; set; }

        /// <summary>
        /// Initializes a new instance of the <see cref="AuthenticationPasswordChangeEventArgs"/> class.
        /// </summary>
        /// <param name="username">The username.</param>
        public AuthenticationPasswordChangeEventArgs(string username)
            : base(username)
        {
        }
    }
}
