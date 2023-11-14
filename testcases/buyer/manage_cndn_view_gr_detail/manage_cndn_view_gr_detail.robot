*** Settings ***
### Global ###
Resource    ../../../resources/global_lib.resource
Resource    ../../../resources/global_var.resource
Resource    ../../../resources/global_keyword.resource
### Keyword for Common/Reuse ###
Resource    ../../../keywords/web/common/buyer_menu_keywords.resource
Resource    ../../../keywords/web/common/common_web_keywords.resource
Resource    ../../../keywords/api/common/common_api_keywords.resource
Resource    ../../../keywords/database/common/common_db_keywords.resource
Resource    ../../../keywords/web/thirdparty/common_ep_invoice_link_keywords.resource
Resource    ../../../keywords/web/thirdparty/common_ep_login_keywords.resource
Resource    ../../../keywords/web/common/buyer_menu_keywords.resource
Resource    ../../../keywords/web/common/invoice_menu_keywords.resource
### Page keyword releted ###
Resource    ../../../keywords/web/cn_dn/manage_cndn_keywords.resource
Resource    ../../../keywords/database/cndn/cndn_db_keywords.resource
Resource    ../../../keywords/web/cn_dn/manage_view_cndn_keywords.resource
### Test Suite Data ###
Variables   ../../../resources/testdata/${env}/cn_dn/cndn.yaml
### Setup ###  
Suite setup     Go to einvoice website from EP via "${TRUE_EP_WEB}" site with "${TRUE_APP_TYPE_2}" and "${TRUE_PASSWORD}"    
Suite Teardown     Run Keywords    Delete All Cookies
                            ...    Close All browsers


*** Test Cases ***
Modal "GR Details" display over "View Credit/ Debit note" page shoud display data properly when click each row from "Invoice number"
    [Tags]   regression      high    web    DB  Ready
    [Documentation]  Verify new modal is implemented and pass data to display on that page
    Given Click menu cn/dn
    and Go to menu Manage CN/DN
    and Get target CN/DN No. at column "${APPROVAL_TEXT.CNDN_NUMBER}" at row "${FIRST_ROW}"
    and Click first row of 'Manage CN/DN'
    and Verify page 'CN/DN' detail display
    and Get target Invoice No. at column "${TEXT.INVOICE_NUMBER}" at row "${FIRST_ROW}" 
    When Click first row of Invoice at column "${TEXT.INVOICE_NUMBER}" to see GR detail
    Then GR detail on modal should match with DB
    and Click 'X' mark to close 'View GR Detail' modal