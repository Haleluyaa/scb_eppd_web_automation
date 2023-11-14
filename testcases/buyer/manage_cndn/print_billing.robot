*** Settings ***
### Global ###
Resource    ../../../resources/global_lib.resource
Resource    ../../../resources/global_var.resource
Resource    ../../../resources/global_keyword.resource
### Keyword for Common/Reuse ###
Resource    ../../../keywords/web/common/common_web_keywords.resource
Resource    ../../../keywords/api/common/common_api_keywords.resource
Resource    ../../../keywords/database/common/common_db_keywords.resource
### Keyword for thirdparty ###
Resource    ../../../keywords/web/thirdparty/common_ep_login_keywords.resource
Resource    ../../../keywords/web/thirdparty/common_ep_invoice_link_keywords.resource
### Page keyword releted ###
Resource    ../../../keywords/web/cn_dn/manage_cndn_keywords.resource
Resource    ../../../keywords/web/cn_dn/view_cndn_keywords.resource


### Test Suite Data ###
Variables   ../../../resources/testdata/${env}/cn_dn/cndn.yaml


### Setup ###
Suite Setup    Go to einvoice website from EP via "${TRUE_EP_WEB}" site with "${TRUE_VERIFY_03}" and "${TRUE_PASSWORD}"
Test Setup    Run keywords    Switch Window  MAIN    AND    Reload Page
Suite teardown    Close All Browsers


*** Test Cases ***
Print Billing action from CN/DN status page is working
    [Tags]    Ready    Regression    High    Web    
    [Documentation]    To Verify that Print Billing action from CN/DN status page is working properly
    Given Go to menu manage CN/DN
    When user select action button of any CN/DN that status is Awaiting Approval
    and click print billing
    Then Browser should open new tab with print preview of Billing Statement

Print Billing action from CN/DN View page is working 
    [Tags]    Ready    Regression    High    Web    
    [Documentation]    To Verify that Print Billing action from CN/DN View page is working properly
    Given Go to menu manage CN/DN
    When user select any CN/DN that status is Awaiting Approval
    and click print billing in CN/DN view
    Then Browser should open new tab with print preview of Billing Statement 

Print Billing action from CN/DN status page is no visible if CN/DN status is Rejected, Document Returned, Expired, Cancelled
    [Tags]    Ready    Regression    High    Web    
    [Documentation]    To verify Print Billing action from CN/DN status page is no visible or accessible, if CN/DN status is Rejected, Document Returned, Expired, Cancelled
    Given Go to menu manage CN/DN
    When user select action button of any CN/DN that status is Rejected
    Then print billing button should not visible

Print Billing action from CN/DN View page is no visible if CN/DN status is Rejected, Document Returned, Expired, Cancelled
    [Tags]    Ready    Regression    High    Web    
    [Documentation]    To verify that Print Billing action from CN/DN View page is no visible and not accessible, if CN/DN status is Rejected, Document Returned, Expired, Cancelled
    Given Go to menu manage CN/DN
    When user select any CN/DN that status is Rejected
    Then print billing button should not visible