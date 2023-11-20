*** Settings ***
Resource    ../../resources/global_keyword.resource

*** Test Cases ***
Test go to eppd with chrome
    Go to eppd by chrome browser    TTCUSEROP1@TTC   TTC
    Wait Until Element Is Visible    //body/div[@id='root']/div[1]/div[1]/div[3]/div[1]/div[1]/div[2]/div[1]/div[1]/div[1]/button[1]    10s
    Close Browser