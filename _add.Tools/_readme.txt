## ---------------------

-------------------------------------------------------------

makecert -r -pe -n "CN=test-fabrik SQL-Server CLR" 
         -a sha256 -len 2048 -sky signature -cy authority 
         -sv C:\Projects\sql_Tools_CLR\test-fabrik_SQLCLR_CodeSign_2025.pvk 
             C:\Projects\sql_Tools_CLR\test-fabrik_SQLCLR_CodeSign_2025.cer 
         -b 01/01/2025 
         -e 03/30/2033 


oneLiner
makecert -r -pe -n "CN=test-fabrik SQL-Server CLR" -a sha256 -len 2048 -sky signature -cy authority -sv C:\Projects	sql_Tools_CLR\test-fabrik_SQLCLR_CodeSign_2025.pvk C:\Projects	sql_Tools_CLR\test-fabrik_SQLCLR_CodeSign_2025.cer -b 01/01/2025 -e 03/30/2033 
----
PVK2PFX -pvk C:\Projects\sql_Tools_CLR\test-fabrik_SQLCLR_CodeSign_2025.pvk 
        -spc C:\Projects\sql_Tools_CLR\test-fabrik_SQLCLR_CodeSign_2025.cer 
        -pfx C:\Projects\sql_Tools_CLR\test-fabrik_SQLCLR_CodeSign_2025.pfx
        -pi extraG3h13mesPa$$w0rd_from_t3st-fabr1k
        -po extraG3h13mesPa$$w0rd_from_t3st-fabr1k

oneLiner
PVK2PFX -pvk C:\Projects\sql_Tools_CLR\test-fabrik_SQLCLR_CodeSign_2025.pvk -spc C:\Projects	sql_Tools_CLR\test-fabrik_SQLCLR_CodeSign_2025.cer -pfx C:\Projects	sql_Tools_CLR\test-fabrik_SQLCLR_CodeSign_2025.pfx -pi extraG3h13mesPa$$w0rd_from_t3st-fabr1k -po extraG3h13mesPa$$w0rd_from_t3st-fabr1k
----

signtool sign /fd SHA256 
        /f C:\Projects\sql_Tools_CLR\test-fabrik_SQLCLR_CodeSign_2025.pfx 
        /p extraG3h13mesPa$$w0rd_from_t3st-fabr1k  
        C:\Projects\tsql_Tools_CLR\sfn_RegEx_Validation\RegexMatch.dll

oneLiner
signtool sign /fd SHA256  /f C:\Projects\sql_Tools_CLR\test-fabrik_SQLCLR_CodeSign_2025.pfx  /p extraG3h13mesPa$$w0rd_from_t3st-fabr1k  C:\Projects\tsql_Tools_CLR\sfn_RegEx_Validation\RegexMatch.dll


signtool sign /fd SHA256  /f C:\Projects\sql_Tools_CLR\test-fabrik_SQLCLR_CodeSign_2025.pfx  /p extraG3h13mesPa$$w0rd_from_t3st-fabr1k  C:\Projects\tsql_Tools_CLR\tFN_getDirectory\getDirectory.dll


signtool sign /fd SHA256  /f C:\Projects\sql_Tools_CLR\test-fabrik_SQLCLR_CodeSign_2025.pfx  /p extraG3h13mesPa$$w0rd_from_t3st-fabr1k  C:\Projects\tsql_Tools_CLR\sfn_Levenshtein\Levenshtein.dll


signtool sign /fd SHA256  /f C:\Projects\sql_Tools_CLR\test-fabrik_SQLCLR_CodeSign_2025.pfx  /p extraG3h13mesPa$$w0rd_from_t3st-fabr1k  C:\Projects\tsql_Tools_CLR\tfn_getFilecontent\getFilecontent.dll

signtool sign /fd SHA256  /f C:\Projects\sql_Tools_CLR\test-fabrik_SQLCLR_CodeSign_2025.pfx  /p extraG3h13mesPa$$w0rd_from_t3st-fabr1k  C:\Projects\tsql_Tools_CLR\tfn_getFilecontent\getFilecontent_UTF8.dll


signtool sign /fd SHA256  /f C:\Projects\sql_Tools_CLR\test-fabrik_SQLCLR_CodeSign_2025.pfx  /p extraG3h13mesPa$$w0rd_from_t3st-fabr1k  C:\Projects\tsql_Tools_CLR\sfn_getSHA1_fromFile\getSHA1_fromFile.dll

signtool sign /fd SHA256  /f C:\Projects\sql_Tools_CLR\test-fabrik_SQLCLR_CodeSign_2025.pfx  /p extraG3h13mesPa$$w0rd_from_t3st-fabr1k  C:\Projects\tsql_Tools_CLR\sfn_getSHA1_fromFile\getSHA1_fromFile_base64.dll


signtool sign /fd SHA256  /f C:\Projects\sql_Tools_CLR\test-fabrik_SQLCLR_CodeSign_2025.pfx  /p extraG3h13mesPa$$w0rd_from_t3st-fabr1k  C:\Projects\tsql_Tools_CLR\sfn_getSHA256_fromFile\getSHA256_fromFile.dll

signtool sign /fd SHA256  /f C:\Projects\sql_Tools_CLR\test-fabrik_SQLCLR_CodeSign_2025.pfx  /p extraG3h13mesPa$$w0rd_from_t3st-fabr1k  C:\Projects\tsql_Tools_CLR\sfn_getSHA256_fromFile\getSHA256_fromFile_base64.dll




----  end  ----