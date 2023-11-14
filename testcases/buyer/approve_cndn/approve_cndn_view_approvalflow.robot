*** Settings ***
### Global ###
Resource    ../../../resources/global_lib.resource
Resource    ../../../resources/global_var.resource
Resource    ../../../resources/global_keyword.resource

### Keyword for Common/Reuse ###
Resource    ../../../keywords/web/common/common_web_keywords.resource
Resource    ../../../keywords/api/common/common_api_keywords.resource
Resource    ../../../keywords/database/common/common_db_keywords.resource
Resource    ../../../keywords/web/common/buyer_menu_keywords.resource

### Page keyword releted ###

Resource    ../../../keywords/web/invoice/invoice_status_keywords.resource
#Resource    ../../../keywords/web/cn_dn/cndn_status_keywords.resource
Resource    ../../../keywords/web/cn_dn/view_cndn_keywords.resource
Resource    ../../../keywords/web/cn_dn/cndn_approve_keywords.resource
Resource    ../../../keywords/web/cn_dn/approval_view_cndn_keywords.resource

### Page keyword related third party ###
Resource    ../../../keywords/web/thirdparty/common_ep_login_keywords.resource
Resource    ../../../keywords/web/thirdparty/common_ep_invoice_link_keywords.resource

### Keywords related DB ###
Resource    ../../../keywords/database/cndn/cndn_db_keywords.resource
Resource    ../../../keywords/database/cndn/approval_view_cndn_db_keywords.resource
Resource    ../../../keywords/database/common/common_buyer_info_db_keywords.resource

### Test Suite Data ###
Variables   ../../../resources/testdata/${env}/cn_dn/cndn.yaml

### Set Up ###
Suite Setup     Go to einvoice website from EP via "${TRUE_EP_WEB}" site with "${TRUE_VERIFY_03}" and "${TRUE_PASSWORD}"
Suite Teardown     Run Keywords    Delete All Cookies
                            ...    Close All browsers
Force Tags    ApproveCNDN    Buyer    InvoiceCreditNoteDebitNote    BuyerCNDNDetail

*** Test Cases ***
To verify approval flow on invoice status is "Rejected"
    [Tags]    ViewApproval    regression    Ready
    [Documentation]    Verify CDND Approval flow when CNDN Number had status "Rejected";
                ...    verify part of display icon, etc.   
                ...    Login with approval level 1 : Verify Document  
                ...    Verify suspend when on approval when verify document is rejected
    
    Given Go to "Manage Credit/Debit Note" list via ${EINVOICE_URL_WEB} and path uri ${BUYER_APPROVE_CNDN_URI}
    When And Go to "View CNDN Detail" on specific invoice number "ROBOT-L1-REJECTED" on column "supplier"   
    Then Verify the 'Credit/Debit Note' on Rejected Status should be correctly witn note "Reject by boaw"

To verify approval flow on invoice status is "Approved"
    [Tags]    ViewApproval    regression    Ready
    [Documentation]    Verify CNDN Approval flow when CNDN Number had status "Approved";
                ...    verify part of display icon, etc.

    Given Go to "Manage Credit/Debit Note" list via ${EINVOICE_URL_WEB} and path uri ${BUYER_APPROVE_CNDN_URI}
    When Go to "View CNDN Detail" on specific invoice number "ROBOT-L2-COMPLETED" on column "supplier"   
    Then Verify the 'Credit/Debit Note' Completed Status should be correctly

To verify approval flow on invoice status is "Awaiting" on Level2
    [Tags]    ViewApproval    regression    Ready
    [Documentation]    Verify CNDN Approval flow when CNDN Number had status "Awaiting";
                ...    verify part of display icon, etc.

    Given Go to "Manage Credit/Debit Note" list via ${EINVOICE_URL_WEB} and path uri ${BUYER_APPROVE_CNDN_URI}
    When Go to "View CNDN Detail" on specific invoice number "ROBOT-L1-APPROVE" on column "supplier"  
    Then Verify the 'Credit/Debit Note' Awaiting Approver Status on Level2 should be correctly

To verify approval flow on invoice status is "Pending"
    [Tags]    ViewApproval    regression    Ready
    [Documentation]    Verify CNDN Approval flow when CNDN Number had status "Pending";
                ...    verify part of display icon, etc.

    Given Go to "Manage Credit/Debit Note" list via ${EINVOICE_URL_WEB} and path uri ${BUYER_APPROVE_CNDN_URI}
    When Go to "View CNDN Detail" on specific invoice number "ROBOT-L1-AWAITING1" on column "supplier"  
    Then Verify the 'Credit/Debit Note' Pending Status should be correctly

To verify approval flow on credit/debit note status is 'Completed' from Closed CN/DN 
    [Tags]    ViewApproval    regression    Ready
    [Documentation]    Verify CNDN Approval flow when CNDN Number had status "Completed" from Closed CN/DN;
                ...    verify part of display icon, etc.
                ...    Login with approval level 1 : verify document

    Given Go to "Manage Credit/Debit Note" list via ${EINVOICE_URL_WEB} and path uri ${BUYER_APPROVE_CNDN_URI}
    When Go to "View CNDN Detail" on specific invoice number "REF-CN20200107-09" on column "supplier" 
    Then Verify the 'Credit/Debit Note' Completed Status form Closed CN/DN should be correctly     

#To verify approval flow on invoice status is "Processing"
#    [Tags]    ViewApproval    regression
#    [Documentation]    Verify CNDN Approval flow when CNDN Number had status "Processing";
#                ...    verify part of display icon, etc.
#
#    Given User go to invoice page
#    And Go to menu CN/DN
#    And Given Search CNDN Number with keyword "${CNDN_NUM_BY_STATUS.PROCESSING}"" from all status
#    When Click first row of Approval CN/DN at column "${TEXT.BUYER}"
#    Then Processing Icon should be display  
    
To verify approval flow is "Group Approval"
    [Tags]    ViewApproval    DB    regression    Ready
    [Documentation]    Verify display label and approval detail when approver is an Approval Group

    Given Go to "Manage Credit/Debit Note" list via ${EINVOICE_URL_WEB} and path uri ${BUYER_APPROVE_CNDN_URI}
    And Go to "View CNDN Detail" on specific invoice number "ROBOT-L1-AWAITING" on column "supplier" 
    When Click on the second approval box
    Then Verify the system show group approval correct on credit/debit note "ROBOT-L1-AWAITING"

To verify approval flow is "Personal"
    [Tags]    ViewApproval    DB    regression    Ready
    [Documentation]    Verify display label and approval detail when approver is a Person

    Given Go to "Manage Credit/Debit Note" list via ${EINVOICE_URL_WEB} and path uri ${BUYER_APPROVE_CNDN_URI}
    And Go to "View CNDN Detail" on specific invoice number "ROBOT-L1-AWAITING" on column "supplier" 
    When Click on the first approval box
    Then Verify the system show a person approval correct on credit/debit note "ROBOT-L1-AWAITING"





