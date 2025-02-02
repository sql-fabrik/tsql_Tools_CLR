using System;
using System.Data;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using System.Text.RegularExpressions;
using Microsoft.SqlServer.Server;

public partial class UserDefinedFunctions
{
    [Microsoft.SqlServer.Server.SqlFunction]
    public static SqlBoolean RegexMatch(SqlChars InputString, SqlString RegExPattern)
    {
        Regex rgx = new Regex(RegExPattern.Value); 
        return rgx.IsMatch(new string(InputString.Value));
    }
};
