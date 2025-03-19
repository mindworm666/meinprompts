@echo off
setlocal

REM Initialize-DomainKnowledge.bat - Simple batch file alternative
REM This creates the basic domain knowledge repository structure

if "%1" == "" (
    echo ERROR: Please specify a target directory path.
    echo Usage: Initialize-DomainKnowledge.bat [PATH]
    exit /b 1
)

set TARGET_DIR=%1
echo Creating Domain Knowledge directory structure in %TARGET_DIR%...

REM Create main directory if it doesn't exist
if not exist "%TARGET_DIR%" mkdir "%TARGET_DIR%"

REM Create main subdirectories
mkdir "%TARGET_DIR%\SessionNotes" 2>nul
mkdir "%TARGET_DIR%\QualifyingResponses" 2>nul
mkdir "%TARGET_DIR%\QualifyingResponses\Terms" 2>nul
mkdir "%TARGET_DIR%\QualifyingResponses\Contexts" 2>nul
mkdir "%TARGET_DIR%\QualifyingResponses\Entities" 2>nul
mkdir "%TARGET_DIR%\Scripts" 2>nul

REM Create empty template files
echo # Domain Glossary> "%TARGET_DIR%\Glossary.md"
echo # Domain Contexts> "%TARGET_DIR%\Contexts.md"
echo # Domain Entity Map> "%TARGET_DIR%\EntityMap.md"

echo.
echo Domain knowledge repository initialized successfully!
echo.
echo IMPORTANT: This batch file creates only the basic structure.
echo Please refer to protocol.md for the required format of each file.
echo.

endlocal 