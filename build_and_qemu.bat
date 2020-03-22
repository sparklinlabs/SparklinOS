@call build.bat
@if %errorlevel% neq 0 exit /b %errorlevel%

"C:\Program Files\qemu\qemu-system-x86_64.exe" -drive format=raw,file=bin\disk.bin
@if %errorlevel% neq 0 exit /b %errorlevel%
