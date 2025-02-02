---- getSHA1_fromFile_base64
use Tools_CLR
GO

-- check CLR-Status
SELECT *
FROM   sys.configurations
WHERE  name like '%clr%'


-->>  check Signature @ .dll File

-- Registrieren der Assembly 
-- DROP ASSEMBLY CLR_getSHA1_fromFile_base64
CREATE ASSEMBLY CLR_getSHA1_fromFile_base64
AUTHORIZATION   dbo
FROM 'C:\Projects\tsql_Tools_CLR\sfn_getSHA1_fromFile\getSHA1_fromFile_base64.dll'      
WITH Permission_Set = EXTERNAL_ACCESS;

-- überprüfung
SELECT * FROM sys.assemblies
SELECT * FROM sys.assembly_files


-- Ausführung 
-- DROP FUNCTION sfn_getSHA1_fromFile_base64
CREATE FUNCTION sfn_getSHA1_fromFile_base64( @PathFile nvarchar(255) )                                 
RETURNS nvarchar(100)
AS 
EXTERNAL NAME CLR_getSHA1_fromFile_base64.UserDefinedFunctions.getSHA1_fromFile;
----          DLL                        .Class               .Function name  
GO

Set Statistics TIME ON
Set Statistics IO   ON


SELECT dbo.sfn_getSHA1_fromFile_base64(N'C:\Projects\tsql_Tools_CLR\sfn_getSHA1_fromFile\getSHA1_fromFile_base64.cs')



------------------------------------	