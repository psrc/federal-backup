:: --------------------------------------------
:: WGET code to backup Census Pulse Excel files
:: --------------------------------------------

:: Files follow pattern `https://www2.census.gov/programs-surveys/demo/tables/hhp/2020/wk1/educ1_se_week1.xlsx`
::                      `https://www2.census.gov/programs-surveys/demo/technical-documentation/hhp/Household-Pulse-Survey-State-Level-Quality-Measures_Cycle01.xlsx`

@echo off
setlocal enabledelayedexpansion

:: Create necessary directories
set BASE_DIR=%CD%
set SUBPAGES_DIR=%BASE_DIR%\subpages
set XLSX_DIR=%BASE_DIR%\downloads
mkdir "%SUBPAGES_DIR%" 2>nul
mkdir "%XLSX_DIR%" 2>nul

:: Define URLs for main pages
set URL_LIST=
set URL_LIST=%URL_LIST% "https://www.census.gov/programs-surveys/household-pulse-survey/data/tables.2024.html"
set URL_LIST=%URL_LIST% "https://www.census.gov/programs-surveys/household-pulse-survey/data/tables.2023.html"
set URL_LIST=%URL_LIST% "https://www.census.gov/programs-surveys/household-pulse-survey/data/tables.2022.html"
set URL_LIST=%URL_LIST% "https://www.census.gov/programs-surveys/household-pulse-survey/data/tables.2021.html"
set URL_LIST=%URL_LIST% "https://www.census.gov/programs-surveys/household-pulse-survey/data/tables.2020.html"

:: Download main pages
for %%U in (%URL_LIST%) do (
    set "FILENAME=%%~nxU.html"
    wget --no-check-certificate -O "%BASE_DIR%\!FILENAME!" %%U
)

:: Extract subpage links using PowerShell
powershell -NoProfile -ExecutionPolicy Bypass -Command "
$mainPages = Get-ChildItem -Path '%BASE_DIR%' -Filter 'tables_*.html';
$subLinks = @();
foreach ($page in $mainPages) {
    $content = Get-Content $page.FullName -Raw;
    $matches = [regex]::Matches($content, 'https://www.census.gov/data/tables/\d+/demo/hhp/hhp\d+\.html');
    foreach ($match in $matches) { $subLinks += $match.Value; }
}
$subLinks | Sort-Object -Unique | Set-Content -Path '%BASE_DIR%\subpages.txt'"

:: Download subpages
for /f %%U in (%BASE_DIR%\subpages.txt) do wget --no-check-certificate -P "%SUBPAGES_DIR%" %%U

:: Extract .xlsx links using PowerShell
powershell -NoProfile -ExecutionPolicy Bypass -Command "
$subPages = Get-ChildItem -Path '%SUBPAGES_DIR%' -Filter '*.html';
$xlsxLinks = @();
foreach ($page in $subPages) {
    $content = Get-Content $page.FullName -Raw;
    $matches = [regex]::Matches($content, 'http://www2.census.gov/programs-surveys/demo/tables/hhp/(\d{4})/[^"']+\.xlsx');
    foreach ($match in $matches) { $xlsxLinks += $match.Value; }
}
$xlsxLinks | Sort-Object -Unique | Set-Content -Path '%BASE_DIR%\xlsx_links.txt'"

:: Download the extracted .xlsx files into year-specific folders
for /f "usebackq delims=" %%U in (%BASE_DIR%\xlsx_links.txt) do (
    for /f "tokens=6 delims=/" %%Y in ("%%U") do (
        set YEAR=%%Y
        set DEST_DIR=%BASE_DIR%\!YEAR!
        if not exist "!DEST_DIR!" mkdir "!DEST_DIR!"
        wget -nc --no-check-certificate -P "!DEST_DIR!" "%%U"
    )
)

endlocal
