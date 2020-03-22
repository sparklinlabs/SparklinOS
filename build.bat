"C:\Program Files\NASM\nasm.exe" -o bin\boot.bin src\boot.asm
@if %errorlevel% neq 0 exit /b %errorlevel%

"C:\Program Files\NASM\nasm.exe" -o bin\kernel.bin src\kernel.asm
@if %errorlevel% neq 0 exit /b %errorlevel%

type bin\boot.bin bin\kernel.bin bin\logo.bin > bin\disk.bin
@if %errorlevel% neq 0 exit /b %errorlevel%
