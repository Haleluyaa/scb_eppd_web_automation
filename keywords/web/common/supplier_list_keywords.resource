*** Settings ***
Variables    ../../../resources/locators/common/common_locators.yaml

*** Keywords ***
########## Combine keyword ###############
Go to create credit note debit note modal
    [Documentation]    go to create credit note debit note modal from invoice list
    Click create creditnote debitnote button
    Click select invoice option from drop down list     

############## By keyword ##############
Click create creditnote debitnote button
    [Documentation]    click create cn/dn button
    Awaiting Until Loading Screen Not Visible
    Wait until element is visible    ${btn_create_creditdebitnote_locator}
    Click element    ${btn_create_creditdebitnote_locator}

Click select invoice option from drop down list
    [Documentation]    click select invoice option from dropdown list after click create cn/dn button 
    Wait until element is visible    ${ddl_creditdebitnote_selected_locator}
    Click element    ${ddl_creditdebitnote_selected_locator}



    
              
