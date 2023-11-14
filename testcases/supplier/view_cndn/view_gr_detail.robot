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
Resource    ../../../keywords/database/cndn/cndn_db_keywords.resource
Resource    ../../../keywords/web/invoice/invoice_status_keywords.resource
Resource    ../../../keywords/web/cn_dn/cndn_status_keywords.resource
Resource    ../../../keywords/web/cn_dn/view_cndn_keywords.resource
### Test Suite Data ###
Variables   ../../../resources/testdata/${env}/cn_dn/cndn.yaml
### Setup ###
Suite Setup    Open setup browser with ${EINVOICE_URL_WEB} and ${BROWSER} and go to invoice supplier
Suite Teardown    Clear all cookie and closed browser
Test teardown   Reload page


*** Test Cases ***
Modal "GR Details" display over "View Credit/ Debit note" page shoud display data properly when click each row from "Invoice number"
    [Tags]   regression      high    web    DB    TC_eINVOICE_02441    TC_eINVOICE_02442    TC_eINVOICE_02443
    [Documentation]  Verify new modal is implemented and pass data to display on that page
    Given User go to invoice page
    When Go to menu CN/DN
    and Get target CN/DN No. at column "${TEXT.CNDN_NUMBER}" at row "${FIRST_ROW}" 
    and Click first row of CN/DN at column "${TEXT.BUYER}"
    and Click first row of Invoice at column "${TEXT.INVOICE_NUMBER}" to see GR detail
    Then GR detail on modal should match with DB
    and Click 'X' mark to close 'View GR Detail' modal