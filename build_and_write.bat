call build.bat
@if %errorlevel% neq 0 exit /b %errorlevel%

"D:\Projects\SparklinOS\tools\dd.exe" if=D:\Projects\SparklinOS\bin\disk.bin od=E: bs=512 count=1
@if %errorlevel% neq 0 exit /b %errorlevel%
