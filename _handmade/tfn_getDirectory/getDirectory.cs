using System;
using System.IO;
using System.Collections;
using Microsoft.SqlServer.Server;

public partial class UserDefinedFunctions
{
      [SqlFunction(FillRowMethodName = "FillRow")]
            public static IEnumerable DirectoryList(string rootDir, string wildCard, bool subDirectories)
            {
                  ArrayList rowsArray = new ArrayList(); //  
                  DirectorySearch(rootDir, wildCard, subDirectories, rowsArray);
                  return rowsArray;
            }

            private static void DirectorySearch(string directory, string wildCard, bool subDirectories, ArrayList rowsArray)
            {
                try
                {
                    GetFiles(directory, wildCard, rowsArray);
                    if (subDirectories)
                    {
                        foreach (string d in Directory.GetDirectories(directory))
                        {
                            DirectorySearch(d, wildCard, subDirectories, rowsArray);
                        }
                    }
                }
                catch (System.IO.DirectoryNotFoundException  ex)
                {
                    SqlContext.Pipe.Send(ex.Message);
                }
            }
            
            private static void GetFiles(string d, string wildCard, ArrayList rowsArray)
            {
                foreach (string f in Directory.GetFiles(d, wildCard))
                    {
                        FileInfo fi = new FileInfo(f);
                        
                        //----
                        string ReadOnly = "";
                        if (fi.IsReadOnly)
                        {
                            ReadOnly = "ReadOnly";
                        }
                        else
                        {
                            ReadOnly = "ReadWrite";
                        }

                        FileAttributes Attributes = fi.Attributes;                        
                        //----

                        object[] column = new object[10];
                        column[0] = fi.FullName;
                        column[1] = fi.DirectoryName;
                        column[2] = fi.Name;
                        column[3] = fi.Extension;
                        column[4] = fi.Length;
                        column[5] = fi.CreationTime;
                        column[6] = fi.LastWriteTime;
                        column[7] = fi.LastAccessTime;
                        column[8] = ReadOnly;
                        column[9] = Attributes.ToString();
                        rowsArray.Add(column);
                    }
           }

            private static void FillRow(Object obj, out string fileFullName, out string directoryName, out string fileName, out string fileExtension, out Int64 fileLength, out DateTime CreationTime, out DateTime LastWriteTime, out DateTime LastAccessTime, out string ReadOnly, out string Attributes)
           {
               object[] row   = (object[])obj; 
               fileFullName   = (string)row[0];
               directoryName  = (string)row[1];
               fileName       = (string)row[2];
               fileExtension  = (string)row[3];
               fileLength     = (Int64)row[4];   
               CreationTime   = (DateTime)row[5];
               LastWriteTime  = (DateTime)row[6];
               LastAccessTime = (DateTime)row[7];
               ReadOnly       = (string)row[8];
               Attributes     = (string)row[9];
           }
};
//''-----------------------------------