*** Settings ***
Variables    ../../../resources/locators/common/common_locators.yaml

***Keywords***
Click submit button on invoice step2
    Wait until element is visible    ${btn_submit_invoice}
    Click element     ${btn_submit_invoice}

Click back button on invoce step2
    Wait until element is visible    ${btn_back_to_invoice_step_1_cndn_locator}
    Click element    ${btn_back_to_invoice_step_1_cndn_locator}