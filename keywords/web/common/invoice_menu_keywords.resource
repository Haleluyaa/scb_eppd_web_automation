*** Settings ***
Variables    ../../../resources/locators/common/common_locators.yaml
Variables    ../../../resources/locators/common/invoice_menu_locator.yaml

*** Keywords ***
Go to cn/dn list page
    Click menu cn/dn

Click menu cn/dn
    Awaiting Until Loading Screen Not Visible
    Wait until element is visible    ${menu_cndn_locator}
    Click element    ${menu_cndn_locator}
