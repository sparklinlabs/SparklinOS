@call build.bat
@if %errorlevel% neq 0 exit /b %errorlevel%

"C:\Program Files\qemu\qemu-system-x86_64.exe" bin\disk.bin
@if %errorlevel% neq 0 exit /b %errorlevel%
