using System;
using System.IO;
using System.Data.SqlTypes;
using System.Security.Cryptography;
using Microsoft.SqlServer.Server;

public partial class UserDefinedFunctions
{
    [Microsoft.SqlServer.Server.SqlFunction(IsDeterministic = true, IsPrecise = false)]
    public static string getSHA1_fromFile(string PathFile)
    {
        using(FileStream fs = new FileStream(PathFile, FileMode.Open, FileAccess.Read, FileShare.Read))
        using (SHA1Managed sha1 = new SHA1Managed())
        {
            return Convert.ToBase64String(sha1.ComputeHash(fs));
        }
     }
};