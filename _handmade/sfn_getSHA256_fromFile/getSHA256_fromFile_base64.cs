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
        try
        {
            using (FileStream stream = File.OpenRead(PathFile))
            {
                SHA256Managed sha = new SHA256Managed();
                byte[] hash = sha.ComputeHash(stream);

                //return Result;  
                return Convert.ToBase64String(hash);
            }
        }

        catch (IOException ex)
        {            
            SqlContext.Pipe.Send(ex.Message);
            return ex.Message;  //  return null; ex.Message;
        }
        catch (Exception e)
        {
            SqlContext.Pipe.Send(e.Message);
            return null;  // e.Message;
        }
      
    }
};