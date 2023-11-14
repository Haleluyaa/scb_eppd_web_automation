#!/bin/bash
args=("$@")

function goto
{
label=$1
cmd=$(sed -n "/$label:/{:a;n;p;ba};" $0 | grep -v ':$')
eval "$cmd"
exit
}

#@echo off
setlocal enableDelayedExpansion
for /f "usebackq skip=2 tokens=1" $i in (`curl http://beta-api-rbac.oneplanets.com/version`) do (
  export  aad=$i
  goto :ebd
  )

goto ebd
ebd:

for /f "usebackq skip=1 tokens=1" $i in (`curl http://beta-ebd-connect.oneplanets.com/version`) do (
  export  ebd=$i
  goto :invoice_api
  )

goto invoice_api
invoice_api:

for /f "usebackq skip=1 tokens=1" $i in (`curl http://beta-api-invoice.oneplanets.com/version`) do (
  export  invoice_api=$i
  goto invoice_web
  )

goto invoice_web
invoice_web:

for /f "usebackq skip=2 tokens=1" $i in (`curl http://beta-invoice-portal.oneplanets.com/version`) do (
  export  invoice_web=$i
  goto invoice_sap
  )

goto invoice_sap
invoice_sap:

for /f "usebackq skip=1 tokens=1" $i in (`curl http://beta-api-sap.oneplanets.com/version`) do (
  export  invoice_sap=$i
  goto invoice_search
  )

goto invoice_search
invoice_search:

for /f "usebackq skip=1 tokens=1" $i in (`curl http://beta-search-api.oneplanets.com/version`) do (
  export  invoice_search=$i
  goto done
  )

goto done
done:



export  CUR_YYYY=$date:~10,4
export  CUR_MM=$date:~4,2
export  CUR_DD=$date:~7,2
export  CUR_HH=$time:~0,2
if  $CUR_HH lss 10 (export  CUR_HH=0$time:~1,1)

export  CUR_NN=$time:~3,2
export  CUR_SS=$time:~6,2
export  CUR_MS=$time:~9,2

export  SUBFILENAME=$CUR_YYYY$CUR_MM$CUR_DD$_$CUR_HH$CUR_NNCUR_SS

export  asofversion= ./AsOfVersion
export  aad=$aad:~11
export  ebd=$ebd:~11
export  invoice_api=$invoice_api:~11
export  invoice_web=$invoice_web:~11
export  invoice_sap=$invoice_sap:~11
export  invoice_search=$invoice_search:~11
export  path=.\BETA
export  path_daysof=.\$path$\$CUR_YYYY$CUR_MMCUR_DD

if  not exist $path mkdir $path
if  not exist $path_daysof mkdir $path_daysof

@echo *** Invoice On Beta Version ***  >> .\$path_daysof$\SUBFILENAME.txt 
@echo *** As Of Version [$date$:time] *** >> .\$path_daysof$\SUBFILENAME.txt
@echo aad-version =$aad >> .\$path_daysof$\SUBFILENAME.txt
@echo ebd-connect-version =$ebd >> .\$path_daysof$\SUBFILENAME.txt
@echo invoice-api-version = $invoice_api >> .\$path_daysof$\SUBFILENAME.txt
@echo invoice-web-version= $invoice_web >> .\$path_daysof$\SUBFILENAME.txt
@echo invoice-sap-api-version = $invoice_sap >> .\$path_daysof$\SUBFILENAME.txt
@echo invoice-search-version = $invoice_search >> .\$path_daysof$\SUBFILENAME.txt
type .\$path_daysof$\SUBFILENAME.txt
endlocal
sleep 