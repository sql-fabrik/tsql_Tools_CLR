using System;
using System.IO;
using System.Data;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using System.Collections;
using Microsoft.SqlServer.Server;


public partial class UserDefinedFunctions
{
    public class FileReader : IEnumerable
    {
        string filePath;

        public FileReader(SqlString filePath)
        {
            this.filePath = filePath.Value;
        }

        public IEnumerator GetEnumerator()
        {
            return new FileEnumerator(this);
        }

        private class FileEnumerator : IEnumerator
        {
            FileReader reader;
            StreamReader sr;
            String line;
            Int32 lineNo = 0;

            public FileEnumerator(FileReader reader)
            {
                this.reader = reader;
                Reset();
            }

            // Return the current line. 
            public object Current
            {
                get { return line; }
            }

            public bool MoveNext()
            {
                line = sr.ReadLine();
                if (line != null)
                {
                    lineNo++;
                    line = lineNo.ToString("0000000") + "_" + line;
                }

                if (line != null)
                    return true;
                else
                {
                    sr.Close();
                    return false;
                }
            }

            // Initialize the reader and open the stream
            public void Reset()
            {
                if (File.Exists(this.reader.filePath))
                    sr = new StreamReader(this.reader.filePath, System.Text.Encoding.UTF8);
                else
                    throw new Exception(String.Format("File {0} Does not exist", this.reader.filePath));
            }
        }
    }

    [Microsoft.SqlServer.Server.SqlFunction(FillRowMethodName = "readRow",
                                             TableDefinition = "lineNo int, resultLine nvarchar(MAX)")]
    public static IEnumerable readFile(SqlString filePath)
    {
        return new FileReader(filePath);
    }

    public static void readRow(object fileLine, out SqlInt32 lineNo, out SqlString resultLine)
    {
        string line = (string)fileLine;
        lineNo = Int32.Parse(line.Substring(0,7));
        resultLine = line.Substring(8);
    }
};
