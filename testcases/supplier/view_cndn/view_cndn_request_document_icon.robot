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
Resource    ../../../keywords/web/cn_dn/cndn_status_keywords.resource
Resource    ../../../keywords/web/cn_dn/view_cndn_keywords.resource
Resource    ../../../keywords/database/cndn/cndn_db_keywords.resource
### Test Suite Data ###
Variables   ../../../resources/testdata/${env}/cn_dn/cndn.yaml
Variables   ../../../resources/testdata/${env}/thirdparty/buyer_manage_invoice.yaml

### Setup ###
Suite Setup    Run Keywords    Open setup browser with ${EINVOICE_URL_WEB} and ${BROWSER} and go to invoice supplier
                            ...    Go to menu CN/DN

Suite Teardown    Run Keywords    Delete All Cookies
                            ...    Close All browsers

Test Teardown    Reload page

***Test Cases***
Request more CNDN information Modal has correct data
    [Documentation]    To verify that Hint Modal is shown and Request more CNDN information Modal has correct data
    [Tags]      Ready
    Given user search CNDN "${CNDN_NUMBER_NEED_INFORMATION}" which has information icon 
    and user select CNDN "${CNDN_NUMBER_NEED_INFORMATION}"
    When user clicked at information icon on view CNDN page
    Then Hint Modal is shown
    and Modal shown correct data "${CNDN_NUMBER_NEED_INFORMATION}"

