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
Resource    ../../../keywords/web/thirdparty/common_ep_login_keywords.resource
Resource    ../../../keywords/web/common/buyer_menu_keywords.resource
Resource    ../../../keywords/web/common/invoice_menu_keywords.resource
Variables   ../../../resources/locators/common/invoice_menu_locator.yaml
Resource    ../../../keywords/web/thirdparty/common_ep_invoice_link_keywords.resource
### Page keyword releted ###
Resource    ../../../keywords/web/cn_dn/cndn_approve_keywords.resource
Resource    ../../../keywords/database/cndn/cndn_db_keywords.resource
Variables   ../../../resources/locators/cn_dn/cndn_approve_locators.yaml
Variables   ../../../resources/testdata/${env}/cn_dn/cndn.yaml


### Test Suite Data ###
Variables   ../../../resources/testdata/${env}/thirdparty/buyer_manage_invoice.yaml
### Setup ### 
Suite setup     Go to einvoice website from EP via "${TRUE_EP_WEB}" site with "${TRUE_APP_TYPE_2}" and "${TRUE_PASSWORD}" and go to cndn approve list   
Suite Teardown     Run Keywords    Delete All Cookies
                            ...    Close All browsers
Test teardown   Reload page

*** Test Cases ***
Verify dropdownlist show filter condition list correctly for site true
    [Tags]      regression      high    web     TC_eINVOICE_02497   Ready
    [Documentation]     ddl filter condition show condition list match with group user and site true
    Given Get 'Condition list' of approver, user login "${TRUE_APP_TYPE_2}" and "${TRUE_MPID}"      
    When Click dropdownlist filter condition 
    Then Dropdownlist filter condition should show 'All Cost Center' at top
    and Dropdownlist filter condition should show 'My Approval' at second
    and Dropdownlist filter condition should show 'Cost Center Group' at bottom
    and Dropdownlist filter condition should show 'Condition list' under my approval menu

Verify dropdownlist show filter condition list correctly in case approver who dose not has group user for site true
    [Tags]      regression      medium    web   TC_eINVOICE_02498   Ready
    [Documentation]     ddl filter condition show all condition list of site true
    Given Remove '${TRUE_APP_TYPE_2}' site '${TRUE_MPID}' from all group user
    and Get 'Condition list' of approver, user login "${TRUE_APP_TYPE_2}" and "${TRUE_MPID}" who dont have group user 
    When Click dropdownlist filter condition 
    Then Dropdownlist filter condition should show 'All Cost Center' at top
    and Dropdownlist filter condition should show 'My Approval' at second
    and Dropdownlist filter condition should show 'Cost Center Group' at bottom
    and Dropdownlist filter condition should show 'Condition list' under my approval menu
    and Assign '${TRUE_APP_TYPE_2}' site '${TRUE_MPID}' to an old one group user

Verify CNDN list show correctly in case select All cost center and approver has one group user
    [Tags]      regression      medium    web   TC_eINVOICE_02499   Ready 
    and Get total number of CNDN list with "${TRUE_APP_TYPE_2}" site '${TRUE_MPID}' Type 'Verify document' and filter condition is 'All Cost Center'
    and click dropdownlist filter condition
    When select 'All Cost Center' from dropdownlist filter condition
    Then Approval CN/DN list footer show total number format "${TOTAL_FOOTER}" correctly
    and Dropdownlist filter condition should display selected option    All Cost Center

Verify CNDN list show correctly in case select My approval and approver has one group user
    [Tags]      regression      medium    web   TC_eINVOICE_02500   Ready
    and Get total number of CNDN list with "${TRUE_APP_TYPE_2}" site '${TRUE_MPID}' Type 'Verify document' and filter condition is 'My Approval'
    and click dropdownlist filter condition
    When select 'My Approval' from dropdownlist filter condition
    Then Approval CN/DN list footer show total number format "${TOTAL_FOOTER}" correctly
    and Dropdownlist filter condition should display selected option    My Approval

Verify CNDN list show correctly in case select Condition group and approver has one group user 
    [Tags]      regression      medium    web   TC_eINVOICE_02501   Ready  
    and Get total number of CNDN list with "${TRUE_APP_TYPE_2}" site '${TRUE_MPID}' Type 'Verify document' and filter condition is 'Cost Center Group'
    and click dropdownlist filter condition
    When select 'Cost Center Group' from dropdownlist filter condition
    Then Approval CN/DN list footer show total number format "${TOTAL_FOOTER}" correctly
    and Dropdownlist filter condition should display selected option    Cost Center Group
    and First page of CNDN list column "${APPROVAL_TEXT.COST_CENTER}" is "${TEXT.CONDITIONGROUP.CONDITIONGROUP}"

Verify CNDN list show correctly in case select own condition and approver has one group user
    [Tags]      regression      medium    web   TC_eINVOICE_02502   Ready   
    and Get total number of CNDN list with "${TRUE_APP_TYPE_2}" site '${TRUE_MPID}' Type 'Verify document' and filter condition is 'Commercial'
    and click dropdownlist filter condition
    When select 'Commercial' from dropdownlist filter condition
    Then Approval CN/DN list footer show total number format "${TOTAL_FOOTER}" correctly
    and Dropdownlist filter condition should display selected option    Commercial
    and First page of CNDN list column "${APPROVAL_TEXT.COST_CENTER}" is "${TEXT.CONDITIONGROUP.COMMERCIAL}"