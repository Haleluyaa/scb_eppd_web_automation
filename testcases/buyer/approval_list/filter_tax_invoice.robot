*** Settings ***
### Global ###
Resource    ../../../resources/global_lib.resource
Resource    ../../../resources/global_var.resource
Resource    ../../../resources/global_keyword.resource
### Keyword for Common/Reuse ###
Resource    ../../../keywords/api/common/common_api_keywords.resource
Resource    ../../../keywords/web/common/common_web_keywords.resource
### Keyword for thirdparty ###
Resource    ../../../keywords/web/thirdparty/common_ep_login_keywords.resource
Resource    ../../../keywords/web/common/invoice_menu_keywords.resource
Resource    ../../../keywords/web/thirdparty/common_ep_invoice_link_keywords.resource
Resource    ../../../keywords/database/common/common_db_keywords.resource
### Page keyword releted ###
Resource    ../../../keywords/web/cn_dn/cndn_approve_keywords.resource
Resource    ../../../keywords/database/cndn/cndn_db_keywords.resource
### Test Suite Data ###
Variables   ../../../resources/testdata/${env}/thirdparty/buyer_manage_invoice.yaml
Suite Setup     Go to einvoice website from EP via "${TRUE_EP_WEB}" site with "${TRUE_VERIFY_03}" and "${TRUE_PASSWORD}"
Suite Teardown     Run Keywords    Delete All Cookies
                            ...    Close All browsers
### Setup ###
Test teardown    Reload page

*** Test Cases ***
Filter Tax Invoice shows choice in list when click on it.
    [Tags]      regression      high    web    TC_eINVOICE_02463    TC_eINVOICE_02464     Ready
    [Documentation]  Verify icon filter display in the column and has choice properly
    Given Click menu cn/dn
    When Go to menu Approve CN/DN
    and Click icon 'tax filter' in column 'CN/DN Number'
    Then There are "All CN/DN", "With Tax Invoice", "No Tax Invoice" in dropdown list

Filter Tax Invoice works properly when select "With Tax Invoice"
    [Tags]      regression      high    web    DB    TC_eINVOICE_02465      
    [Documentation]   Verify icon filter woks properly 
                ...    Remove Ready because approval list order by only approve begin date 
                ...    in case cndn more  in group can't get same list result
                     
    Given Click menu cn/dn
    and Go to menu Approve CN/DN
    and Click icon 'tax filter' in column 'CN/DN Number'
    and Select "With Tax Invoice" in dropdown list
    Then Table display top 20 results 'With Tax Invoice' match with DB

Filter Tax Invoice works properly when select "No Tax Invoice"
    [Tags]      regression      high    web    DB    TC_eINVOICE_02466      Ready
    [Documentation]  Verify icon filter woks properly
    Given Click menu cn/dn
    and Go to menu Approve CN/DN
    and Click icon 'tax filter' in column 'CN/DN Number'
    and Select "No Tax Invoice" in dropdown list
    Then Table display top 20 results 'No Tax Invoice' match with DB