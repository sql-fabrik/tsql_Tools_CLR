---- Levenshtein
use Tools_CLR
GO

-- check CLR-Status
SELECT *
FROM   sys.configurations
WHERE  name like '%clr%'


-->>  check Signature @ .dll File

-- Registrieren der Assembly 
-- DROP ASSEMBLY CLR_Levenshtein
CREATE ASSEMBLY CLR_Levenshtein
AUTHORIZATION   dbo
FROM 'C:\Projects\tsql_Tools_CLR\sfn_Levenshtein\Levenshtein.dll'
WITH Permission_Set = Safe

-- überprüfung
SELECT * FROM sys.assemblies
SELECT * FROM sys.assembly_files


-- Ausführung 
-- DROP FUNCTION sfn_Levenshtein
CREATE FUNCTION sfn_Levenshtein( @S1 nvarchar(4000) , @S2 nvarchar(4000))
RETURNS float 
AS
  EXTERNAL NAME CLR_Levenshtein.StoredFunctions.Levenshtein   
  --            DLL            .Class          .Function name 


Set Statistics TIME ON
Set Statistics IO   ON

SELECT 'SQL Server Internals  vs.  SQL Server Integration'                     as 'input'
     , dbo.sfn_Levenshtein( 'SQL Server Internals', 'SQL Server Integration' )  as 'percentDiff'
UNION
SELECT '6:0 vs. 1:1'
     , dbo.sfn_Levenshtein( '6:0' , '1:1' )
