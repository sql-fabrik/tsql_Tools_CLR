---- getDirectory
use Tools_CLR
GO

-- check CLR-Status
SELECT *
FROM   sys.configurations
WHERE  name like '%clr%'


-->>  check Signature @ .dll File

-- Registrieren der Assembly 
-- DROP ASSEMBLY CLR_getDirectory
CREATE ASSEMBLY CLR_getDirectory
AUTHORIZATION   dbo
FROM 'C:\Projects\tsql_Tools_CLR\tFN_getDirectory\getDirectory.dll'
WITH Permission_Set = External_Access;

-- überprüfung
SELECT * FROM sys.assemblies
SELECT * FROM sys.assembly_files


-- Ausführung 
-- DROP FUNCTION tfn_DirectoryList
CREATE FUNCTION tfn_DirectoryList ( @root_directory  nvarchar(max)
                                  , @wildcard        nvarchar(max)
                                  , @subdirectories  bit )        
RETURNS TABLE 
 ( fileFullname   nvarchar(500)
 , directoryName  nvarchar(500)
 , fileName       nvarchar(500)
 , fileExtension  nvarchar(100)
 , fileLength     bigInt       
 , CreationTime   datetime     
 , LastWriteTime  datetime     
 , LastAccessTime datetime     
 , ReadOnly       nvarchar(100)
 , Attributes     nvarchar(100)
 )
AS 
EXTERNAL NAME CLR_getDirectory.UserDefinedFunctions.DirectoryList;
----          DLL             .Class               .Function name
GO
       

Set Statistics TIME ON
Set Statistics IO   ON

SELECT @@servername as 'ServerName'
     , *
FROM   dbo.tfn_DirectoryList( 'D:\software', '*.*', 1 )


----  end  ----
---------------
