using TCMSSH.Security.Cryptography;

namespace TCMSSH.Security
{
    /// <summary>
    /// Represents "diffie-hellman-group-exchange-sha256" algorithm implementation.
    /// </summary>
    public class KeyExchangeDiffieHellmanGroupExchangeSha256 : KeyExchangeDiffieHellmanGroupExchangeShaBase
    {
        /// <summary>
        /// Gets algorithm name.
        /// </summary>
        public override string Name
        {
            get { return "diffie-hellman-group-exchange-sha256"; }
        }

        /// <summary>
        /// Hashes the specified data bytes.
        /// </summary>
        /// <param name="hashBytes">Data to hash.</param>
        /// <returns>
        /// Hashed bytes
        /// </returns>
        protected override byte[] Hash(byte[] hashBytes)
        {
            using (var md = new SHA256Hash())
            {
                return md.ComputeHash(hashBytes);
            }
        }
    }
}
