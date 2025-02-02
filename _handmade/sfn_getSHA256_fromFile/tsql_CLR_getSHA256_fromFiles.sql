---- getSHA256_fromFile_ (hex)
use Tools_CLR
GO

-- check CLR-Status
SELECT *
FROM   sys.configurations
WHERE  name like '%clr%'


-->>  check Signature @ .dll File

-- Registrieren der Assembly 
-- DROP ASSEMBLY CLR_getSHA256_fromFile 
CREATE ASSEMBLY CLR_getSHA256_fromFile 
AUTHORIZATION   dbo
FROM 'C:\Projects\tsql_Tools_CLR\sfn_getSHA256_fromFile\getSHA256_fromFile.dll'      
WITH Permission_Set = EXTERNAL_ACCESS;

-- überprüfung
SELECT * FROM sys.assemblies
SELECT * FROM sys.assembly_files


-- Ausführung 
-- DROP FUNCTION sfn_getSHA256_fromFile
CREATE FUNCTION sfn_getSHA256_fromFile( @PathFile nvarchar(255) )                                 
RETURNS nvarchar(100)
AS 
EXTERNAL NAME CLR_getSHA256_fromFile.UserDefinedFunctions.getSHA256_fromFile;
----          DLL                   .Class               .Function name  
GO

Set Statistics TIME ON
Set Statistics IO   ON


SELECT dbo.sfn_getSHA256_fromFile(N'C:\Projects\tsql_Tools_CLR\sfn_getSHA256_fromFile\getSHA256_fromFile_base64.cs')



------------------------------------	