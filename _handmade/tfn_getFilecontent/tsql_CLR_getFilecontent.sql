---- getFilecontent
use Tools_CLR
GO

-- check CLR-Status
SELECT *
FROM   sys.configurations
WHERE  name like '%clr%'


-->>  check Signature @ .dll File

-- Registrieren der Assembly 
-- DROP ASSEMBLY CLR_getFilecontent
CREATE ASSEMBLY CLR_getFilecontent
AUTHORIZATION   dbo
FROM 'C:\Projects\tsql_Tools_CLR\tfn_getFilecontent\getFilecontent.dll'
WITH Permission_Set = External_Access;

-- überprüfung
SELECT * FROM sys.assemblies
SELECT * FROM sys.assembly_files


---- Ausführung 
-- DROP FUNCTION tfn_readFile
CREATE FUNCTION tfn_readFile ( @filePath nvarchar(500) )                                
RETURNS TABLE 
 ( lineNumber int, lineText nvarchar(max) )
AS 
EXTERNAL NAME CLR_getFilecontent.UserDefinedFunctions.readFile;
----          DLL               .Class               .Function name
GO
       

Set Statistics TIME ON
Set Statistics IO   ON


SELECT *
FROM   dbo.tfn_readFile( 'C:\Projects\tsql_Tools_CLR\tfn_getFilecontent\tsql_CLR_getFilecontent.sql' )

----  