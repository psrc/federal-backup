:: ----------------------------------------
::  WGET code to backup Census ACS tables
:: ----------------------------------------

::  Files follow pattern `https://www2.census.gov/programs-surveys/acs/summary_file/2005/data/Washington/all_wa.zip`
::                       `https://www2.census.gov/programs-surveys/acs/summary_file/2006/data/Washington/wa_all_2006.zip`
::                       `https://www2.census.gov/programs-surveys/acs/summary_file/2007/data/1_year/Washington/all_wa.zip`

::  Census site lacks standard website listings, so wget recursive option doesn't identify the .zipfiles
::  They can be specified like this. Folders to receive them must already exist.

@echo off

:: Define the base URL and target directory
set base_url=https://www2.census.gov/programs-surveys/acs/summary_file
set target_dir=\\ReadyNAS-RN4220\FederalData\Census\acs\summary_file

:: Define years and file types to download
set years=2009 2010 2011 2012 2013 2014 2015 2016 2017 2018
set file_types=1_year_by_state 5_year_by_state

:: Loop through years and file types
for %%y in (%years%) do (
    for %%f in (%file_types%) do (
        :: Define the target path
        set target_path=%target_dir%\%%y\data\%%f
        :: Create the directory if it doesn't exist
        if not exist "%target_path%" mkdir "%target_path%"

        :: Download the files
        wget -nc --no-check-certificate -P "%target_path%" %base_url%/%%y/data/%%f/Washington_All_Geographies.zip
        wget -nc --no-check-certificate -P "%target_path%" %base_url%/%%y/data/%%f/Washington_Tracts_Block_Groups_Only.zip
        wget -nc --no-check-certificate -P "%target_path%" %base_url%/%%y/data/%%f/Washington_All_Geographies_Not_Tracts_Block_Groups.zip
    )
)

echo Download complete.
