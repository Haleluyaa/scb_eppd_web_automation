***Settings***
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
Resource    ../../../keywords/web/cn_dn/view_cndn_keywords.resource
Resource    ../../../keywords/web/cn_dn/cndn_approve_keywords.resource
Resource    ../../../keywords/web/cn_dn/approval_view_cndn_keywords.resource
Resource    ../../../keywords/web/cn_dn/rejected_cndn_keywords.resource

### Page keyword related third party ###
Resource    ../../../keywords/web/thirdparty/common_ep_login_keywords.resource
Resource    ../../../keywords/web/thirdparty/common_ep_invoice_link_keywords.resource

### Keywords related DB ###
Resource    ../../../keywords/database/cndn/cndn_db_keywords.resource
Resource    ../../../keywords/database/cndn/reject_cndn_db_keywords.resource
Resource    ../../../keywords/database/common/common_buyer_info_db_keywords.resource

### Test Suite Data ###
Variables   ../../../resources/testdata/${env}/cn_dn/cndn.yaml

### Set Up ###
Suite Setup      Go to einvoice website from EP via "${TRUE_EP_WEB}" site with "${TRUE_VERIFY_03}" and "${TRUE_PASSWORD}"
Suite Teardown     Run Keywords    Delete All Cookies
                            ...    Close All browsers     

***Test Cases***
Modal reject at the "View Credit / Debit Note" page displayed correctly
    [Tags]    ApproveCNDN    Buyer    EditCNDN    RejectCNDN    TC_eINVOICE_02582    TC_eINVOICE_02583    TC_eINVOICE_02585    Ready 
    [Documentation]    Verify the system show Modal reject and elements are correct such 
                ...    as Modal title, Place Holder, Button, etc when click Reject on View Credit/Debit Note 

    Go to "Manage Credit/Debit Note" list via ${EINVOICE_URL_WEB} and path uri ${BUYER_APPROVE_CNDN_URI}
    And Go to "View CNDN Detail" on specific invoice number "C202004141529" on column "supplier"
    When Click reject button On View/Edit Credit/Debit Note page
    Then The system must display the pop up reject debit/credit note
    And The pop up reject debit/credit note Title must be "${REJECTED_MODAL.TITLE}" 
    And The pop up reject debit/credit note Text area Place holder is "${REJECTED_MODAL.PLACE_HOLDER}" and Title is "${REJECTED_MODAL.TEXT_AREA_TITLE}" and length is "255"
    And The pop up reject debit/credit note must show "Confirm" button with label "${REJECTED_MODAL.BTN_CONFIRM_LABEL}" and "Cancel" button with label "${REJECTED_MODAL.BTN_CANCEL_LABEL}"          


Modal reject at the "Edit Credit / Debit Note" page displayed correctly
    [Tags]    ApproveCNDN    Buyer    EditCNDN    RejectCNDN     TC_eINVOICE_02585    TC_eINVOICE_02583    TC_eINVOICE_02581    Ready
    [Documentation]    Verify the system show Modal reject and elements are correct such 
                ...    as Modal title, Place Holder, Button, etc when click Reject on View Credit/Debit Note

    Go to "Manage Credit/Debit Note" list via ${EINVOICE_URL_WEB} and path uri ${BUYER_APPROVE_CNDN_URI}
    And Go to "View CNDN Detail" on specific invoice number "C202004141529" on column "supplier"
    #And Click Edit button at View Credit/Debit Note 
    And Click Edit Button on View Credit/Debit Note page
    When Click reject button On View/Edit Credit/Debit Note page
    Then The system must display the pop up reject debit/credit note
    And The pop up reject debit/credit note Title must be "${REJECTED_MODAL.TITLE}" 
    And The pop up reject debit/credit note Text area Place holder is "${REJECTED_MODAL.PLACE_HOLDER}" and Title is "${REJECTED_MODAL.TEXT_AREA_TITLE}" and length is "255"
    And The pop up reject debit/credit note must show "Confirm" button with label "${REJECTED_MODAL.BTN_CONFIRM_LABEL}" and "Cancel" button with label "${REJECTED_MODAL.BTN_CANCEL_LABEL}"             


Verify that the user can successfully reject the credit/debit when the conditions are correct
    [Tags]    ApproveCNDN    Buyer    EditCNDN    RejectCNDN    DB   TC_eINVOICE_02593    TC_eINVOICE_02592
       ...    TC_eINVOICE_02591     TC_eINVOICE_02590    TC_eINVOICE_02589    TC_eINVOICE_02588     TC_eINVOICE_02585
    [Documentation]    Verify when the user successfully reject the Credit/Debit Note then the system
                ...    Insert/update data to the database correctly and correctly display data on the screen  
                ...    Input reject reason to maximum value include Thai, Englist and Special Characters   
                ...     "beer" note : i've removed Ready because this test case need setup or teardown
                
    #[Setup]    Prepare Credit/Debit Note for rejected test cases 
    Go to "Manage Credit/Debit Note" list via ${EINVOICE_URL_WEB} and path uri ${BUYER_APPROVE_CNDN_URI}
    And Go to "View CNDN Detail" on specific invoice number "CN20200414-008" on column "supplier"
    And Click Edit Button on View Credit/Debit Note page
    When Click reject button On View/Edit Credit/Debit Note page 
    And Input reject credit/debit note to maximum value with reason "${REJECTED_MODAL.TEXT_REJECT_REASON}"
    And Click "Confirm Button" to reject credit/debit note
    Then The system must be redirect to list and success bar is "${REJECT_SUCCESSES_MESSAGE}" and show search on "CN20200414-008" and status is "Rejected"
    And The system must be inserted/update the Reject Data correctly on cndn number is "${CNDN_NUMBER}"
    
    And The system must correct insert Credit/Debit Note history for "${CNDN_NUMBER}"
    #[Teardown]    Set Credit/Debit Not for rejected test cases to initial value on CNDN Number is "${CREDIT_DEBIT_NOTE_NUMBER}"    



Verify that the system show error when to choose to reject the credit/debit note with not complete reject reason
    [Tags]    ApproveCNDN    Buyer    EditCNDN    RejectCNDN    TC_eINVOICE_02584    Ready
    [Documentation]    Verify the error when rejecting the Credit/ Debit Note without required condition
                ...    Include error message, icon and form console
                ...    If choose create Credit/Debit Note at all run time; then "Setup an Tear" not necessarary

 
    Go to "Manage Credit/Debit Note" list via ${EINVOICE_URL_WEB} and path uri ${BUYER_APPROVE_CNDN_URI}
    And Go to "View CNDN Detail" on specific invoice number "C202004141529" on column "supplier"
    When Click reject button On View/Edit Credit/Debit Note page
    And Click "Confirm Button" to reject credit/debit note
    Then Error on the "Modal Rejected" must be correctly with message "${REJECTED_MODAL.ERROR_MESSAGE}"


Verify the system must close "Modal Reject" when clicking Cancel Button on the Modal
    [Tags]    ApproveCNDN    Buyer    EditCNDN    RejectCNDN     TC_eINVOICE_02595    Ready
    [Documentation]   Verify cancelled rejected credit/debit note

    Go to "Manage Credit/Debit Note" list via ${EINVOICE_URL_WEB} and path uri ${BUYER_APPROVE_CNDN_URI}
    And Go to "View CNDN Detail" on specific invoice number "C202004141529" on column "supplier"
    When Click reject button On View/Edit Credit/Debit Note page
    And Click "Cancel Button" to cancel reject credit/debit note 
    Then "Modal Reject Credit/Debit Note" must hide from the screen 
    












    
