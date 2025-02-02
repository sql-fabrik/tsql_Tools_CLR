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
        SHA1CryptoServiceProvider SHA1 = new SHA1CryptoServiceProvider();
        byte[] Hash;
        string Result = string.Empty;
        string Tmp = string.Empty;

        FileStream FS = new FileStream(PathFile, FileMode.Open, FileAccess.Read, FileShare.Read, 8192);
        SHA1.ComputeHash(FS);
        FS.Close();

        Hash = SHA1.Hash;
        for (int i = 0; i < Hash.Length; i++)
        {
            Tmp = Convert.ToString(Hash[i], 16);
            if (Tmp.Length == 1)
                Tmp = "0" + Tmp;
            Result += Tmp;
        }
        return Result; 

     }
};