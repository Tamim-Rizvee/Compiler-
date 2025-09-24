@echo off
echo Generating parser...
bison -d practice.y
if errorlevel 1 (
    echo Error generating parser
    pause
    exit /b 1
)

echo Generating lexer...
flex prac.l
if errorlevel 1 (
    echo Error generating lexer
    pause
    exit /b 1
)

echo Compiling...
g++ -std=c++11 -w -o parser.exe practice.tab.c lex.yy.c
if errorlevel 1 (
    echo Error compiling
    pause
    exit /b 1
)

echo Compilation successful!
echo Running parser...
parser.exe
pause