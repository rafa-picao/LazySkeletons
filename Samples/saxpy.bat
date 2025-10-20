@echo off
set MSVC_PATH=C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.44.35207\bin\Hostx64\x64

nvcc -std=c++20 ^
    -O2 --maxrregcount=64 ^
    -arch=sm_86 ^
    -ccbin "%MSVC_PATH%" ^
    -o saxpy vec_norm.cu

