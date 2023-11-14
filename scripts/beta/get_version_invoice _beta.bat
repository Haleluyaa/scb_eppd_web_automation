@echo off
setlocal enableDelayedExpansion
for /f "usebackq skip=2 tokens=1" %%i in (`curl http://beta-api-rbac.oneplanets.com/version`) do (
  set aad=%%i%
  goto :ebd
  )
:ebd  
for /f "usebackq skip=1 tokens=1" %%i in (`curl http://beta-ebd-connect.oneplanets.com/version`) do (
  set ebd=%%i%
  goto :invoice_api
  )
:invoice_api
for /f "usebackq skip=1 tokens=1" %%i in (`curl http://beta-api-invoice.oneplanets.com/version`) do (
  set invoice_api=%%i%
  goto invoice_web
  )
:invoice_web
for /f "usebackq skip=2 tokens=1" %%i in (`curl http://beta-invoice-portal.oneplanets.com/version`) do (
  set invoice_web=%%i%
  goto invoice_sap
  )
:invoice_sap
for /f "usebackq skip=1 tokens=1" %%i in (`curl http://beta-api-sap.oneplanets.com/version`) do (
  set invoice_sap=%%i%
  goto invoice_search
  )
:invoice_search
for /f "usebackq skip=1 tokens=1" %%i in (`curl http://beta-search-api.oneplanets.com/version`) do (
  set invoice_search=%%i%
  goto done
  )
:done


set CUR_YYYY=%date:~10,4%
set CUR_MM=%date:~4,2%
set CUR_DD=%date:~7,2%
set CUR_HH=%time:~0,2%
if %CUR_HH% lss 10 (set CUR_HH=0%time:~1,1%)

set CUR_NN=%time:~3,2%
set CUR_SS=%time:~6,2%
set CUR_MS=%time:~9,2%

set SUBFILENAME=%CUR_YYYY%%CUR_MM%%CUR_DD%_%CUR_HH%%CUR_NN%%CUR_SS%

set asofversion= ./AsOfVersion
set aad=%aad:~11%
set ebd=%ebd:~11%
set invoice_api=%invoice_api:~11%
set invoice_web=%invoice_web:~11%
set invoice_sap=%invoice_sap:~11%
set invoice_search=%invoice_search:~11%
set path=.\BETA
set path_daysof=.\%path%\%CUR_YYYY%%CUR_MM%%CUR_DD%

if not exist %path% mkdir %path%
if not exist %path_daysof% mkdir %path_daysof%

@echo *** Invoice On Beta Version ***  >> .\%path_daysof%\%SUBFILENAME%.txt 
@echo *** As Of Version [%date%:%time%] *** >> .\%path_daysof%\%SUBFILENAME%.txt
@echo aad-version =%aad% >> .\%path_daysof%\%SUBFILENAME%.txt
@echo ebd-connect-version =%ebd% >> .\%path_daysof%\%SUBFILENAME%.txt
@echo invoice-api-version = %invoice_api% >> .\%path_daysof%\%SUBFILENAME%.txt
@echo invoice-web-version= %invoice_web% >> .\%path_daysof%\%SUBFILENAME%.txt
@echo invoice-sap-api-version = %invoice_sap% >> .\%path_daysof%\%SUBFILENAME%.txt
@echo invoice-search-version = %invoice_search% >> .\%path_daysof%\%SUBFILENAME%.txt
type .\%path_daysof%\%SUBFILENAME%.txt
endlocal
PAUSE

