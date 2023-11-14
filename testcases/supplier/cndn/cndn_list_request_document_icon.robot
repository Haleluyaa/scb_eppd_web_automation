*** Settings ***
### Global ###
Resource    ../../../resources/global_lib.resource
Resource    ../../../resources/global_var.resource
Resource    ../../../resources/global_keyword.resource
### Keyword for Common/Reuse ###
Resource    ../../../keywords/web/common/common_web_keywords.resource
Resource    ../../../keywords/api/common/common_api_keywords.resource
Resource    ../../../keywords/database/common/common_db_keywords.resource
### Page keyword releted ###
Resource    ../../../keywords/web/cn_dn/supplier_cndn_keywords.resource
### Test Suite Data ###
Variables   ../../../resources/testdata/${env}/cn_dn/cndn.yaml

### Setup ###
Suite Setup    Run Keywords    Open setup browser with ${EINVOICE_URL_WEB} and ${BROWSER} and go to invoice supplier
                            ...    Go to menu CN/DN

Suite Teardown    Run Keywords    Delete All Cookies
                            ...    Close All browsers

Test Teardown    Reload page

***Test Cases***
Request more CNDN information Modal has correct data
    [Tags]    Ready    Regression    High    Web
    [Documentation]    To verify that request more CNDN information Modal has correct data
    Given user search CNDN "${CNDN_NUMBER_NEED_INFORMATION}" which has information icon 
    When user clicked at CNDN "${CNDN_NUMBER_NEED_INFORMATION}" information icon
    Then Hint Modal is shown
    and Modal shown correct data of CNDN "${CNDN_NUMBER_NEED_INFORMATION}" request

