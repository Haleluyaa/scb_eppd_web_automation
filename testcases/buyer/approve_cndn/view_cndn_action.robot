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
Resource    ../../../keywords/web/cn_dn/approval_cndn_keywords.resource
Resource    ../../../keywords/web/cn_dn/cndn_approve_keywords.resource
Resource    ../../../keywords/web/cn_dn/approval_view_cndn_keywords.resource
Resource    ../../../keywords/database/cndn/cndn_db_keywords.resource
### Test Suite Data ###
Variables   ../../../resources/testdata/${env}/thirdparty/buyer_manage_invoice.yaml
Variables   ../../../resources/testdata/${env}/cn_dn/cndn.yaml
Suite Setup     Go to einvoice website from EP via "${TRUE_EP_WEB}" site with "${TRUE_VERIFY_03}" and "${TRUE_PASSWORD}" and go to cndn approve list 
Suite Teardown     Run Keywords    Delete All Cookies
                            ...    Close All browsers
### Setup ###
Test teardown    Reload page
*** Test Cases ***
"View Credit / Debit Note" page display "Request Document", "Approve" and "Reject" button when meet condition
    [Tags]      regression      high    web    DB    TC_eINVOICE_02494  Ready
    [Documentation]     Verify action button display properly 
                        ...     "beer" note : cndn supplier online show 3 button [Req doc , Approve , Reject]  
    
    Given User select Supplier​ filter and enter Supplier​ name "${SUPPLIER_NAME}" in search textbox
    and Search CN/DN with status "${APPROVAL_STATUS.AWAITING}"
    When Click first row of CN/DN at column "${TEXT['RECEIVED_DATE']}"
    Then User view selected CN/DN Detail
    and Button "Request Document" display at footer
    and Button "Approve" display at footer
    and Button "Reject" display at footer

"View Credit / Debit Note" page display "Approve" and "Reject" button when meet condition
    [Tags]      regression      high    web    DB    TC_eINVOICE_02495  Ready
    [Documentation]   Verify action button display properly 
                        ...     "beer" note : cndn supplier offline show 2 button [Approve , Reject]     
    
    Given User select Supplier​ filter and enter Supplier​ name "${SUPPLIER_NAME_AIS}" in search textbox
    and Search CN/DN with status "${APPROVAL_STATUS['AWAITING']}"
    Click on first row of 'CN/DN' no show information needed at column "${TEXT['RECEIVED_DATE']}"
    Then User view selected CN/DN Detail
    and Button "Approve" display at footer
    and Button "Reject" display at footer

"View Credit / Debit Note" page no display any when meet condition
    [Tags]      regression      high    web    DB    TC_eINVOICE_02496  Ready
    [Documentation]   Verify action button display properly 
                    ...     "beer" note  cndn supplier online pending show nothing  
    
    Given User select CN/DN search filter and enter CN/DN number "${CNDN_NUMBER_VIEW_ACTION}" in search textbox
    When Click first row of CN/DN at column "${TEXT['RECEIVED_DATE']}"
    Then User view selected CN/DN Detail
    and No any button display at footer

