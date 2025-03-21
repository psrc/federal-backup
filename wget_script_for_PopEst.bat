:: ----------------------------------------
:: WGET code to backup Census PopEst files
:: ----------------------------------------

@echo off

:: City Datasets
set BASE_DIR=https://www2.census.gov/programs-surveys/popest/datasets/
set DEST_DIR=\\ReadyNAS-RN4220\FederalData\Census\Popest\Cities\datasets

if not exist "%DEST_DIR%" mkdir "%DEST_DIR%"

set URL_LIST=
set URL_LIST=%URL_LIST% 2020-2023/cities/totals/sub-est2023_53.csv
set URL_LIST=%URL_LIST% 2010-2020/intercensal/cities/sub-est2020int.csv
set URL_LIST=%URL_LIST% 2000-2010/intercensal/cities/sub-est00int.csv

for %%U in (%URL_LIST%) do wget -nc --no-check-certificate -P "%DEST_DIR%" "%BASE_DIR%%%U"

:: City Tables
set BASE_DIR=https://www2.census.gov/programs-surveys/popest/tables/
set DEST_DIR=\\ReadyNAS-RN4220\FederalData\Census\Popest\Cities\tables

if not exist "%DEST_DIR%" mkdir "%DEST_DIR%"

set URL_LIST=
set URL_LIST=%URL_LIST% 2020-2023/cities/totals/SUB-IP-EST2023-POP-53.xlsx
set URL_LIST=%URL_LIST% 2010-2020/intercensal/cities/sub-ip-est2020int-pop-53.xlsx
set URL_LIST=%URL_LIST% 1990-2000/2000-subcounties-evaluation-estimates/sc2000f_wa.txt
set URL_LIST=%URL_LIST% 1990-2000/cities/totals/su-99-10_wa.txt

for %%U in (%URL_LIST%) do wget -nc --no-check-certificate -P "%DEST_DIR%" "%BASE_DIR%%%U"

:: County Datasets
set BASE_DIR=https://www2.census.gov/programs-surveys/popest/datasets/
set DEST_DIR=\\ReadyNAS-RN4220\FederalData\Census\Popest\Counties\datasets

if not exist "%DEST_DIR%" mkdir "%DEST_DIR%"

set URL_LIST=
set URL_LIST=%URL_LIST% 2020-2024/counties/totals/co-est2024-alldata.csv
set URL_LIST=%URL_LIST% 2010-2020/counties/totals/co-est2020-alldata.csv
set URL_LIST=%URL_LIST% 2000-2010/intercensal/county/co-est00int-alldata-53.csv
set URL_LIST=%URL_LIST% 2000-2009/counties/totals/co-est2009-popchg2000_2009-53.csv

for %%U in (%URL_LIST%) do wget -nc --no-check-certificate -P "%DEST_DIR%" "%BASE_DIR%%%U"

:: County ASRH Datasets
set DEST_DIR=\\ReadyNAS-RN4220\FederalData\Census\Popest\Counties\datasets\asrh

if not exist "%DEST_DIR%" mkdir "%DEST_DIR%"

set URL_LIST=
set URL_LIST=%URL_LIST% 2010-2019/counties/asrh/cc-est2019-agesex-53.csv
set URL_LIST=%URL_LIST% 2000-2009/counties/asrh/cc-est2009-agesex-53.csv
set URL_LIST=%URL_LIST% 2000-2009/counties/asrh/cc-est2009-6race-53.csv
set URL_LIST=%URL_LIST% 2010-2019/counties/asrh/cc-est2019-alldata-53.csv
set URL_LIST=%URL_LIST% 2000-2009/counties/asrh/cc-est2009-alldata-53.csv
set URL_LIST=%URL_LIST% 1990-2000/counties/asrh/co-99-10.txt

for %%U in (%URL_LIST%) do wget -nc --no-check-certificate -P "%DEST_DIR%" "%BASE_DIR%%%U"

:: County Estimates Tables
set BASE_DIR=https://www2.census.gov/programs-surveys/popest/tables/
set DEST_DIR=\\ReadyNAS-RN4220\FederalData\Census\Popest\Counties\tables

if not exist "%DEST_DIR%" mkdir "%DEST_DIR%"

set URL_LIST=
set URL_LIST=%URL_LIST% 2020-2024/counties/totals/co-est2024-pop-53.xlsx
set URL_LIST=%URL_LIST% 2020-2024/counties/totals/co-est2024-comp-53.xlsx
set URL_LIST=%URL_LIST% 2010-2020/intercensal/county/co-est2020int-pop-53.xlsx
set URL_LIST=%URL_LIST% 2000-2010/intercensal/county/co-est00int-01-53.xls

for %%U in (%URL_LIST%) do wget -nc --no-check-certificate -P "%DEST_DIR%" "%BASE_DIR%%%U"
