---- getFilecontent
use Tools_CLR
GO

-- check CLR-Status
SELECT *
FROM   sys.configurations
WHERE  name like '%clr%'


-->>  check Signature @ .dll File

-- Registrieren der Assembly 
-- DROP ASSEMBLY CLR_getFilecontent_UTF8
CREATE ASSEMBLY CLR_getFilecontent_UTF8
AUTHORIZATION   dbo
FROM 'C:\Projects\tsql_Tools_CLR\tfn_getFilecontent\getFilecontent_UTF8.dll'
WITH Permission_Set = External_Access;

-- überprüfung
SELECT * FROM sys.assemblies
SELECT * FROM sys.assembly_files


---- Ausführung 
-- DROP FUNCTION tfn_readFile_UTF8
CREATE FUNCTION tfn_readFile_UTF8 ( @filePath nvarchar(500) )                                
RETURNS TABLE 
 ( lineNumber int, lineText nvarchar(max) )
AS 
EXTERNAL NAME CLR_getFilecontent_UTF8.UserDefinedFunctions.readFile;
----          DLL                    .Class               .Function name
GO
       

Set Statistics TIME ON
Set Statistics IO   ON


SELECT *
FROM   dbo.tfn_readFile_UTF8( 'C:\Projects\tsql_Tools_CLR\tfn_getFilecontent\tsql_CLR_getFilecontent.sql' )

----  