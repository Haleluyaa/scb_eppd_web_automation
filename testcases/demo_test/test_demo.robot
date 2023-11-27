*** Settings ***
Resource    ../../resources/global_keyword.resource
*** Variables ***
${slash}                  /
${chrome_testing_path}    ${CURDIR}..${slash}..${slash}..${slash}drivers${slash}chrome-mac-arm64_for_testing${slash}Google_Chrome_for_Testing.app
*** Test Cases ***
Test go to eppd with chrome
    Go to eppd by chrome browser    TTCUSEROP1@TTC   TTC
    Wait Until Element Is Visible    //body/div[@id='root']/div[1]/div[1]/div[3]/div[1]/div[1]/div[2]/div[1]/div[1]/div[1]/button[1]    10s
    Close Browser
