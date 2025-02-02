---- RegexMatch
use Tools_CLR
GO

-- check CLR-Status
SELECT *
FROM   sys.configurations
WHERE  name like '%clr%'


-->>  check Signature @ .dll File

-- Registrieren der Assembly 
-- DROP ASSEMBLY CLR_RegexMatch
CREATE ASSEMBLY CLR_RegexMatch
FROM 'C:\Projects\tsql_Tools_CLR\sfn_RegEx_Validation\RegexMatch.dll'
WITH Permission_Set = Safe  --


-- überprüfung
SELECT * FROM sys.assemblies
SELECT * FROM sys.assembly_files


-- Ausführung 
-- DROP Function sfn_RegexMatch
CREATE Function sfn_RegexMatch( @InputString nvarchar(4000) , @RegexPattern nvarchar(4000))
RETURNS bit
AS
  EXTERNAL NAME CLR_RegexMatch.UserDefinedFunctions.RegexMatch
  --            DLL           .Class               .Function name                       

SELECT dbo.sfn_RegexMatch( 'hallo Welt', '\w' )          -- Word Charakter (=Buchstaben UND Ziffern)
     , dbo.sfn_RegexMatch( 'hallo Welt', '^[a-zA-Z]' )   -- Word Charakter (=Buchstaben UND Ziffern)     
     , dbo.sfn_RegexMatch( '7hallo Welt', '^[a-zA-Z]' )  -- Word Charakter (=Buchstaben UND Ziffern)     
     , dbo.sfn_RegexMatch( 'hallo Welt', '\s' )          -- Leerzeichen 
     , dbo.sfn_RegexMatch( 'halloWelt', '\s' )           -- Leerzeichen   
     , dbo.sfn_RegexMatch( 'hallo Welt', '\d' )          -- Zahlzeichen  
     , dbo.sfn_RegexMatch( '60300', '\d' )               -- Zahlzeichen                


SELECT dbo.sfn_RegexMatch( N'hallo Welt' , '\P{IsBasicLatin}' )  -- großes P negiert--> wenn 0 dann kein "Sonderzeichen" enthalten
   --  , dbo.sfn_RegexMatch( N'ø' , '\P{IsBasicLatin}' )
     , dbo.sfn_RegexMatch( N'Jürgen Ölmüller macht Ärger'       , '\P{IsBasicLatin}' )
     , dbo.sfn_RegexMatch( N'Q8  Nørre Allé 77, 2100 København' , '\P{IsBasicLatin}' )
     , dbo.sfn_RegexMatch( N'AVIA  54 Avenue de la République, 75011 Paris'  , '\P{IsBasicLatin}' )
     , dbo.sfn_RegexMatch( N'BP  Górczewska 159, 00-001 Warszawa'            , '\P{IsBasicLatin}' )
     , dbo.sfn_RegexMatch( N'Čerpací stanice OMV  Chodovská, 141 00 Praha 4' , '\P{IsBasicLatin}' )

SELECT dbo.sfn_RegexMatch( N'™', '\u2122' )  -- übereinstimmung mit dem Unicode-Zeichen
     , dbo.sfn_RegexMatch( N'®', '\u00ae' )  -- übereinstimmung mit dem Unicode-Zeichen

 --	 , dbo.sfn_RegexMatch( N'hallo Welt' , '\p{Common}' )  -- !! Common  bringt Exception

SELECT dbo.sfn_RegexMatch( N'hallo Welt', '[:alpha:]' ) 
     , dbo.sfn_RegexMatch( N'HALLO'     , '[:lowwer:]' )
     , dbo.sfn_RegexMatch( N'hallo'     , '[:lowwer:]' )

