*** Settings ***
Variables    ../../../resources/locators/common/common_locators.yaml

*** Keywords ***
Click Invoice Link
    Wait Until Element Is Visible     ${todo_list_invoice_link_locator}    ${timeout}
    Click Element    ${todo_list_invoice_link_locator} 
