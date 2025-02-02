using System;
using System.IO;
using System.Text;
using System.Data.SqlTypes;
using System.Security.Cryptography;
using Microsoft.SqlServer.Server;

public partial class UserDefinedFunctions
{
    [Microsoft.SqlServer.Server.SqlFunction(IsDeterministic = true, IsPrecise = false)]
    public static string getSHA256_fromFile(string PathFile)
    {
        using (FileStream stream = File.OpenRead(PathFile))
        {
            SHA256Managed sha = new SHA256Managed();
            byte[] hash = sha.ComputeHash(stream);
            return BitConverter.ToString(hash).ToLower().Replace("-", String.Empty);
        }

        //return Result;        
    }
};