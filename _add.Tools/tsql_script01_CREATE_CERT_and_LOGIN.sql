----  Tools_CLR
----  Certificate
SELECT @@servername
--     SQLserver\BI  ??


use master
GO

CREATE CERTIFICATE test-fabrik_SQLCLR_CodeSign_2025
FROM FILE = 'C:\Projects\tsql_Tools_CLR\test-fabrik_SQLCLR_CodeSign_2025.cer'
GO

CREATE LOGIN test-fabrik_SQLCLR_Login_4CodeSign_2025
FROM CERTIFICATE test-fabrik_SQLCLR_CodeSign_2025
GO

GRANT UNSAFE ASSEMBLY
TO test-fabrik_SQLCLR_Login_4CodeSign_2025
GO

----  end  ----

