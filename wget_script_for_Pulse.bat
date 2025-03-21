:: --------------------------------------------
:: WGET code to backup Census Pulse Excel files
:: --------------------------------------------

:: Files follow pattern `https://www2.census.gov/programs-surveys/demo/tables/hhp/2020/wk1/educ1_se_week1.xlsx`
::                      `https://www2.census.gov/programs-surveys/demo/technical-documentation/hhp/Household-Pulse-Survey-State-Level-Quality-Measures_Cycle01.xlsx`

@echo off
setlocal enabledelayedexpansion

:: Base directory for downloads
set BASE_DIR=\\ReadyNAS-RN4220\FederalData\Census\pulse\
set BASE_URL=https://www2.census.gov/programs-surveys/demo/tables/hhp/

:: Read URLs from a separate file
set URL_FILE=urls.txt

:: Loop through URLs from file
for /f "usebackq delims=" %%U in (%URL_FILE%) do (
    for /f "tokens=1 delims=/" %%Y in ("%%U") do (
        set YEAR=%%Y
        set DEST_DIR=%BASE_DIR%\!YEAR!
        if not exist "!DEST_DIR!" mkdir "!DEST_DIR!"
        wget -nc --no-check-certificate -P "!DEST_DIR!" "%BASE_URL%%%U"
    )
)

endlocal
