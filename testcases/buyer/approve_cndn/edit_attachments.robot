***Settings***
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
Resource    ../../../keywords/web/invoice/buyer_approve_invoice_list_keywords.resource
Resource    ../../../keywords/web/cn_dn/buyer_create_cndn_keywords.resource
Resource    ../../../keywords/web/cn_dn/manage_cndn_keywords.resource
Resource    ../../../keywords/web/cn_dn/cndn_approve_keywords.resource
Resource    ../../../keywords/web/cn_dn/approval_cndn_keywords.resource
Resource    ../../../keywords/web/cn_dn/approval_view_cndn_keywords.resource
Resource    ../../../keywords/web/cn_dn/edit_cndn_keywords.resource

### Database keyword ###
Resource    ../../../keywords/database/cndn/cndn_db_keywords.resource

### Test Suite Data ###
Variables   ../../../resources/testdata/${env}/cn_dn/cndn.yaml
Variables   ../../../resources/testdata/${env}/common/message.yaml

### Setup ### 
Suite Setup      Go to einvoice website from EP via "${TRUE_EP_WEB}" site with "${TRUE_APP_TYPE_1}" and "${TRUE_PASSWORD}"
Suite Teardown     Run Keywords    Delete All Cookies
                            ...    Close All browsers
***Test Cases***
Verify icon attachment when upload completed on credit/debit note level
    [Documentation]    Verify the system show icon completed attachment when upload completed at least one file
    [Tags]    Web    Buyer    ApproveCNDN    EditCNDN    EditAttachment     Ready   

    Given Go to "Approve CNDN" via URL on "${EINVOICE_URL_WEB}" and "${BUYER_APPROVE_CNDN_URI}" 
    And Go to 'View CN/DN detail page' of CN/DN Number "${CNDN_NUMBER_EDIT_ATTACHMENT}"
    And Click menu "Edit" at top right corner
    When User click attachment icon document cndn level
    And Choose upload files on credit/debit note level on this file "${ATTACHMENT_FILE.RESUBMIT}"
    And Click "Done" button on attachment modal 
    Then Verify icon attachment when upload completed on credit/debit note level

Verify the error should be correctly when choose incorrect format file on credit/debit note level
    [Documentation]    Verify the error edit attachment file when
                ...    1. Choose invalid format files
    [Tags]    Web    Buyer    ApproveCNDN    EditCNDN    EditAttachment     Ready

    Given Go to "Approve CNDN" via URL on "${EINVOICE_URL_WEB}" and "${BUYER_APPROVE_CNDN_URI}" 
    And Go to 'View CN/DN detail page' of CN/DN Number "${CNDN_NUMBER_EDIT_ATTACHMENT}"
    And Click menu "Edit" at top right corner
    When User click attachment icon document cndn level
    And Choose upload files on credit/debit note level on this file "${ATTACHMENT_FILE.INVALID_FORMAT}"   
    Then Error message at credit/debit note level when incorrect format file should be "${TEXT_INVALID_FORMAT_FILE}"    

Verify the error should be correctly when choose over maximum file size on credit/debit note level
    [Documentation]    Verify the error edit attachment file when
                ...    1. Choose invalid format files    
    [Tags]    Web    Buyer    ApproveCNDN    EditCNDN    EditAttachment     Ready

    Given Go to "Approve CNDN" via URL on "${EINVOICE_URL_WEB}" and "${BUYER_APPROVE_CNDN_URI}" 
    And Go to 'View CN/DN detail page' of CN/DN Number "${CNDN_NUMBER_EDIT_ATTACHMENT}"
    And Click menu "Edit" at top right corner
    When User click attachment icon document cndn level  
    and Choose upload files on credit/debit note level on this file "${ATTACHMENT_FILE.INVALID_FILE_SIZE}"    
    Then Error message at credit/debit note level when maximum file size should be "${TEXT_INVALID_FILE_SIZE}"          

Verify user can download attachment file on credit/debit note level
    [Documentation]    Verify user can download attachment file when upload complete
    [Tags]    Web    Buyer    ApproveCNDN    EditCNDN    EditAttachment     Ready

    Given Go to "Approve CNDN" via URL on "${EINVOICE_URL_WEB}" and "${BUYER_APPROVE_CNDN_URI}" 
    And Go to 'View CN/DN detail page' of CN/DN Number "${CNDN_NUMBER_EDIT_ATTACHMENT}"
    And Click menu "Edit" at top right corner
    And User click attachment icon document cndn level
    And Choose upload files on credit/debit note level on this file "${ATTACHMENT_FILE['RESUBMIT']}"
    When Click download file at credit/debit note level at first position
    # Then Verify success download file on credit/debit note level

Verify the modal attachment file display correctly when upload completed on credit/debit note level with label and place holder
    [Documentation]    Verify the system show correct modal attachment file when user completed upload files
    [Tags]    Web    Buyer    ApproveCNDN    EditCNDN    EditAttachment     Ready

    Given Go to "Approve CNDN" via URL on "${EINVOICE_URL_WEB}" and "${BUYER_APPROVE_CNDN_URI}" 
    And Go to 'View CN/DN detail page' of CN/DN Number "${CNDN_NUMBER_EDIT_ATTACHMENT}"
    And Click menu "Edit" at top right corner
    And User click attachment icon document cndn level
    And Choose upload files on credit/debit note level on this file "${ATTACHMENT_FILE['RESUBMIT']}"   
    Then Modal edit attachment after completed on credit/debit note level should be correctly with label "${LBL_CHECKBOX_SEND_TO_SUPPLIER}" and place holder is "${TEXT_NOTE_PLACE_HOLDER}"

Verify the data when edit attachment file with select send file to the supplier and note on credit/debit note level
    [Documentation]    Verify the system insert data correctly when confirm edit attachment
               ...     and choose send file to supplier and input note              
    [Tags]    Web    Buyer    ApproveCNDN    EditCNDN    EditAttachment    DB   Ready  
    [Setup]     Reload page
    Given Create a CNDN offline with status 'Awaiting Approval' 
    And Go to "Approve CNDN" via URL on "${EINVOICE_URL_WEB}" and "${BUYER_APPROVE_CNDN_URI}" 
    And Go to 'View CN/DN detail page' of CN/DN Number "${CNDN_NUMBER_EDIT_ATTACHMENT_AND_APPROVE}"
    And Click menu "Edit" at top right corner
    And User click attachment icon document cndn level
    And Choose upload files on credit/debit note level on this file "${ATTACHMENT_FILE.RESUBMIT}"  
    When Input note for this attachment "${TEXT_NOTE_TO_SUPPLIER}" into text box on credit/debit note level 
    And Select check box send file to supplier on credit/debit note level
    And Click "Done" button on attachment modal
    And Fill required data duedate '${EDIT_ATTACHMENT_DUEDATE}' and payment location '${TRUE_PAYMENT_LOCATION_TRANSFER}'
    When Click "Approve" button on edit credit/debit note
    Then CNDNNumber "${CNDN_NUMBER_EDIT_ATTACHMENT_AND_APPROVE}" data for attachment on credit/debit note level should be correctly with "${TEXT_NOTE_TO_SUPPLIER}"        

Verify icon attachment when upload completed on invoice level
    [Documentation]    Verify the system show icon completed attachment when upload completed at least one file
    [Tags]    Web    Buyer    ApproveCNDN    EditCNDN    EditAttachment     Ready

    Given Go to "Approve CNDN" via URL on "${EINVOICE_URL_WEB}" and "${BUYER_APPROVE_CNDN_URI}" 
    And Go to 'View CN/DN detail page' of CN/DN Number "${CNDN_NUMBER_EDIT_ATTACHMENT_INV}"
    And Click menu "Edit" at top right corner
    And Click attachment icon on invoice level   
    And Choose upload files on invoice level on this file "${ATTACHMENT_FILE.RESUBMIT}"    
    When Click "Done" button on attachment modal
    Then Verify icon attachment when upload completed on invoice level


Verify the error should be correctly when choose incorrect format file on invoice level
    [Documentation]    Verify the error edit attachment file when
                ...    1. Choose invalid format files
    [Tags]    Web    Buyer    ApproveCNDN    EditCNDN    EditAttachment     Ready

    Given Go to "Approve CNDN" via URL on "${EINVOICE_URL_WEB}" and "${BUYER_APPROVE_CNDN_URI}" 
    And Go to 'View CN/DN detail page' of CN/DN Number "${CNDN_NUMBER_EDIT_ATTACHMENT_INV}"
    And Click menu "Edit" at top right corner
    And Click attachment icon on invoice level   
    When Choose upload files on invoice level on this file "${ATTACHMENT_FILE.INVALID_FORMAT}"  
    Then Error message at credit/debit note level when incorrect format file should be "${TEXT_INVALID_FORMAT_FILE}"    

Verify the error should be correctly when choose over maximum file size on invoice level
    [Documentation]    Verify the error edit attachment file when
                ...    1. Choose invalid format files    
    [Tags]    Web    Buyer    ApproveCNDN    EditCNDN    EditAttachment     Ready

    Given Go to "Approve CNDN" via URL on "${EINVOICE_URL_WEB}" and "${BUYER_APPROVE_CNDN_URI}" 
    And Go to 'View CN/DN detail page' of CN/DN Number "${CNDN_NUMBER_EDIT_ATTACHMENT_INV}"
    And Click menu "Edit" at top right corner
    And Click attachment icon on invoice level   
    When Choose upload files on invoice level on this file "${ATTACHMENT_FILE.INVALID_FILE_SIZE}"   
    Then Error message at invoice level when maximum file size should be "${TEXT_INVALID_FILE_SIZE}"           

Verify user can download attachment file on invoice level
    [Documentation]    Verify user can download attachment file when upload complete
    [Tags]    Web    Buyer    ApproveCNDN    EditCNDN    EditAttachment     Ready

    Given Go to "Approve CNDN" via URL on "${EINVOICE_URL_WEB}" and "${BUYER_APPROVE_CNDN_URI}" 
    And Go to 'View CN/DN detail page' of CN/DN Number "${CNDN_NUMBER_EDIT_ATTACHMENT_INV}"
    And Click menu "Edit" at top right corner
    And Click attachment icon on invoice level   
    And Choose upload files on invoice level on this file "${ATTACHMENT_FILE.RESUBMIT}"  
    When Click download file at invoice level at first position
    # Then Verify success download file on invoice level

Verify the modal attachment file display correctly when upload completed on invoice level with label and place holder
    [Documentation]    Verify the system show correct modal attachment file when user completed upload files
                ...    Label is message for check box
    [Tags]    Web    Buyer    ApproveCNDN    EditCNDN    EditAttachment     Ready

    Given Go to "Approve CNDN" via URL on "${EINVOICE_URL_WEB}" and "${BUYER_APPROVE_CNDN_URI}" 
    And Go to 'View CN/DN detail page' of CN/DN Number "${CNDN_NUMBER_EDIT_ATTACHMENT_INV}"
    And Click menu "Edit" at top right corner
    And Click attachment icon on invoice level   
    And Choose upload files on invoice level on this file "${ATTACHMENT_FILE.RESUBMIT}"  
    Then Modal edit attachment after completed on invoice level should be correctly with label "${LBL_CHECKBOX_SEND_TO_SUPPLIER}" and place holder is "${TEXT_NOTE_PLACE_HOLDER}"

Verify the data when edit attachment file with select send file to the supplier and note on invoice level
    [Documentation]    Verify the system insert data correctly when confirm edit attachment
               ...     and choose send file to supplier and input note   
    [Tags]    Web    Buyer    ApproveCNDN    EditCNDN    EditAttachment    DB   Ready         
    [Setup]     Reload page
    Given Create a CNDN offline with status 'Awaiting Approval'  
    And Go to "Approve CNDN" via URL on "${EINVOICE_URL_WEB}" and "${BUYER_APPROVE_CNDN_URI}" 
    And Go to 'View CN/DN detail page' of CN/DN Number "${CNDN_NUMBER_EDIT_ATTACHMENT_AND_APPROVE}"
    And Click menu "Edit" at top right corner
    And Click attachment icon on invoice level   
    And Choose upload files on invoice level on this file "${ATTACHMENT_FILE.RESUBMIT}"  
    When Input note for this attachment "${TEXT_NOTE_TO_SUPPLIER}" into text box on invoice level 
    And Select check box send file to supplier on invoice level
    And Click "Done" button on attachment modal
    And Fill required data duedate '${EDIT_ATTACHMENT_DUEDATE}' and payment location '${TRUE_PAYMENT_LOCATION_TRANSFER}'
    When Click "Approve" button on edit credit/debit note
    Then CNDNNumber "${CNDN_NUMBER_EDIT_ATTACHMENT_AND_APPROVE}" data for attachment on invoice level should be correctly with "${TEXT_NOTE_TO_SUPPLIER}"                   