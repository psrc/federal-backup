:: -------------------------------------------
:: WGET code to backup Census LODES microdata
:: -------------------------------------------

:: Files follow pattern `https://lehd.ces.census.gov/data/lodes/LODES8/wa/od/wa_od_aux_JT00_2002.csv.gz`
::                      `https://lehd.ces.census.gov/data/lodes/LODES8/wa/wac/wa_wac_S000_JT00_2002.csv.gz`
::                      `https://lehd.ces.census.gov/data/lodes/LODES8/wa/rac/wa_rac_S000_JT00_2002.csv.gz`

wget -r -A .csv.gz --no-parent https://lehd.ces.census.gov/data/lodes/LODES8/wa/ -P \\ReadyNAS-RN4220\FederalData\LODES -nc --no-check-certificate
