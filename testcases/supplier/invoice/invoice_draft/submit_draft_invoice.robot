***Settings***
#### Global Keyword ####
Library    keyboard
#Library    Dialogs
Resource    ../../../../resources/global_keyword.resource
Resource    ../../../../resources/global_lib.resource
Resource    ../../../../resources/global_var.resource

#### Common Keyword ####
Resource    ../../../../keywords/web/common/common_web_keywords.resource
Resource    ../../../../keywords/api/common/common_api_keywords.resource
Resource    ../../../../keywords/database/common/common_db_keywords.resource

### Database Keywords ###
Resource    ../../../../keywords/database/invoice/invoice_db_keywords.resource
Resource    ../../../../keywords/database/invoice/workflow_db_keywords.resource

### Keyword relate page
Resource    ../../../../keywords/api/upload-invoice-controller/upload_invoice_api_keywords.resource
Resource    ../../../../keywords/api/invoice-controller/invoice_api_keywords.resource
Resource    ../../../../keywords/api/workflow-controller/workflow_api_keywords.resource
Resource    ../../../../keywords/web/invoice/invoice_status_keywords.resource
Resource    ../../../../keywords/web/invoice/invoice_edit_keywords.resource
Resource    ../../../../keywords/web/invoice/invoice_details_keywords.resource
Resource    ../../../../keywords/web/invoice/invoice_history_keywords.resource

### Test data ###
Variables   ../../../../resources/testdata/${env}/invoice/upload-invoice-controller.yaml
Variables   ../../../../resources/testdata/${env}/invoice/create-invoice-controller.yaml
Variables   ../../../../resources/testdata/${env}/invoice/approval-workflow-controller.yaml
Variables    ../../../../resources/testdata/${env}/invoice/invoice.yaml
Variables   ../../../../resources/testdata/${env}/invoice/edit_invoice.yaml



Suite Setup    Open setup browser with ${EINVOICE_URL_WEB} and ${BROWSER} and go to invoice supplier with user TT00100
Suite Teardown    Clear all cookie and closed browser

***Test Cases***

To verify submit invoice status draft success from invoice list
    [Tags]    SubmitInvoice    Ready    Supplier    DraftInvoice
    [Documentation]    Include attached file on invoice and po
                ...    By click submit from action submit

    [Setup]      Run Keywords    Reload Page
          ...    Prepare post draft invoice to "${EINVOICE_URL_API}" at uri "${UPLOAD_INVOICE_URI}" from file "${UPLOAD_INVOICE_TEMPLATE_FILE_NAME}"

    Given Search invoice number via input "${TV_invoice_num_upload}"
    And User clicked action button on row "1" 
    And User choose invoice options "edit" at row "1"
    And Attach file "${ATTACHED_INVOICE_FILE}" to invoice level at type "Invoice" 
    And Attach file "${ATTACHED_PO_FILE}" to po level at type "PO Form"
    When Click submit button in edit invoice
    And Click confirm submit draft invoice
    Then Redirect from edit invoice to invoice list and show success bar "${SUBMIT_INVOIC_SUCCESS_BAR['EN']}" and status on row "1" should be "Awaiting Approval"    

    [Teardown]    Rejected invoice "${TV_invoice_num_upload}" on buyer "${INVOICE_BUYER_SUPPLIER['buyer_mpid']}" and supplier "${INVOICE_BUYER_SUPPLIER['supplier_mpid']}" from "${APPROVAL_WORKFLOW_TEMPLATE_FILE_NAME}" to endpoint "${EINVOICE_URL_API}" and workflow "${APPROVAL_WORKFLOW_URI}" approval "${APPROVAL_URI}"
    

To verify submit invoice status draft success from invoice detail 
    [Tags]    SubmitInvoice    Ready    Supplier    DraftInvoice
    [Documentation]    Include attached file on invoice and po
               ...     By go to invoice detail then click edit

    [Setup]    Run Keywords    Reload Page
        ...    Prepare post draft invoice to "${EINVOICE_URL_API}" at uri "${UPLOAD_INVOICE_URI}" from file "${UPLOAD_INVOICE_TEMPLATE_FILE_NAME}" 

    Given Search invoice number via input "${TV_invoice_num_upload}"
    And User click on specificed invoice row "1" at column "5"
    And User click button edit
    And Attach file "${ATTACHED_INVOICE_FILE}" to invoice level at type "Invoice" 
    And Attach file "${ATTACHED_PO_FILE}" to po level at type "PO Form"
    When Click submit button in edit invoice
    And Click confirm submit draft invoice
    Then Redirect from edit invoice to invoice list and show success bar "${SUBMIT_INVOIC_SUCCESS_BAR['EN']}" and status on row "1" should be "Awaiting Approval"    

    [Teardown]    Rejected invoice "${TV_invoice_num_upload}" on buyer "${INVOICE_BUYER_SUPPLIER['buyer_mpid']}" and supplier "${INVOICE_BUYER_SUPPLIER['supplier_mpid']}" from "${APPROVAL_WORKFLOW_TEMPLATE_FILE_NAME}" to endpoint "${EINVOICE_URL_API}" and workflow "${APPROVAL_WORKFLOW_URI}" approval "${APPROVAL_URI}"

To verify submit invoice error when without attached required field for invoice and po and disappear when successfilly attached
    [Tags]    SubmitInvoice    Ready    Supplier    DraftInvoice    Regression
    [Documentation]    Veriry show error when submit draft invoice without upload required atttachment file for invoice level and po level.
                ...    Then error should be appear when attached file
    
    [Setup]    Run Keywords    Reload Page
        ...    Prepare post draft invoice to "${EINVOICE_URL_API}" at uri "${UPLOAD_INVOICE_URI}" from file "${UPLOAD_INVOICE_TEMPLATE_FILE_NAME}" 

    Given Filter invoice with status "Draft"
    And Search invoice number via input "${TV_invoice_num_upload}"
    And User clicked action button on row "1" 
    And User choose invoice options "edit" at row "1"
    When Click submit button in edit invoice
    Then Error noti should be show on invoice attachment
    And Error noti should be show on po attachment
    And Error noti should be disappear when attached required files "${ATTACHED_INVOICE_FILE}" to "Invoice" and files "${ATTACHED_PO_FILE}" to "PO Form"
    And Noti attach file invoice level show be show 
    And Noti attach file po level should be show
    Click 'X' to close edit invoice page

    [Teardown]    Delete draft invoice from "${EINVOICE_URL_API}" at uri "${DELETE_DRAFT_INVOICE_URI}" via "${UPLOAD_DRAFT_INV_VALIDATE['supplierMpId']}" and "${TV_invoice_num_upload}"             

To verify successfully submit invoice status draft and correct update data
    [Tags]   SubmitInvoice    Ready    Supplier    DraftInvoice    Regression
    [Documentation]    Verify successfully submit draft invoice, data should be update status to 'Awaiting Approve'
                ...    And data should insert to approve data
                ...    And data should insert to elastic


    [Setup]    Run Keywords    Reload Page
        ...    Prepare post draft invoice to "${EINVOICE_URL_API}" at uri "${UPLOAD_INVOICE_URI}" from file "${UPLOAD_INVOICE_TEMPLATE_FILE_NAME}" 

    Given Search invoice number via input "${TV_invoice_num_upload}"
    And User click on specificed invoice row "1" at column "5"
    And User click button edit
    And Attach file "${ATTACHED_INVOICE_FILE}" to invoice level at type "Invoice" 
    And Attach file "${ATTACHED_PO_FILE}" to po level at type "PO Form"
    When Click submit button in edit invoice
    And Click confirm submit draft invoice
    Then Redirect from edit invoice to invoice list and show success bar "${SUBMIT_INVOIC_SUCCESS_BAR['EN']}" and status on row "1" should be "Awaiting Approval"    
    And Invoice log "history" should be saved for selected invoice row "1" for invoice "${TV_invoice_num_upload}", buyer "${TV_upload_buyer_name}", create date "${TV_invoice_create_date_upload}"
    And Work flow should be saved for invoice "${TV_invoice_num_upload}",supplier "${INVOICE_BUYER_SUPPLIER['supplier_mpid']}","${INVOICE_BUYER_SUPPLIER['buyer_mpid']}" status "Awaiting" at sequence "1"
    And Invoice elastic should be saved for invoice "${TV_invoice_num_upload}" on supplier "${INVOICE_BUYER_SUPPLIER['supplier_mpid']}" from endpoint "${EINVOICE_URL_WEB}", uri "${GET_INV_ELASTIC_PORTAL_URI}"

    [Teardown]    Rejected invoice "${TV_invoice_num_upload}" on buyer "${INVOICE_BUYER_SUPPLIER['buyer_mpid']}" and supplier "${INVOICE_BUYER_SUPPLIER['supplier_mpid']}" from "${APPROVAL_WORKFLOW_TEMPLATE_FILE_NAME}" to endpoint "${EINVOICE_URL_API}" and workflow "${APPROVAL_WORKFLOW_URI}" approval "${APPROVAL_URI}"

To verify cancel submit invoice status draft
    [Tags]    SubmitInvoice    Ready    Supplier    DraftInvoice
    [Documentation]    Verify cancel submit draft invoice, show be show edit invoice page
    
    [Setup]    Run Keywords    Reload Page
        ...    Prepare post draft invoice to "${EINVOICE_URL_API}" at uri "${UPLOAD_INVOICE_URI}" from file "${UPLOAD_INVOICE_TEMPLATE_FILE_NAME}"

    Given Search invoice number via input "${TV_invoice_num_upload}"
    And User clicked action button on row "1" 
    And User choose invoice options "edit" at row "1"
    And Attach file "${ATTACHED_INVOICE_FILE}" to invoice level at type "Invoice" 
    And Attach file "${ATTACHED_PO_FILE}" to po level at type "PO Form"
    When Click submit button in edit invoice
    And Click cancel submit draft invoice
    Then Edit invoice detail should be show   
    Click 'X' to close edit invoice page 

    [Teardown]    Delete draft invoice from "${EINVOICE_URL_API}" at uri "${DELETE_DRAFT_INVOICE_URI}" via "${UPLOAD_DRAFT_INV_VALIDATE['supplierMpId']}" and "${TV_invoice_num_upload}" 

To verify submit invoice when po/gr remaining amount not enough
    [Tags]    SubmitInvoice    Ready    Supplier    DraftInvoice    Regression
    [Documentation]    Verify remaining po/gr amount not enough, show popup error message and cannot submit invoice
    
    [Setup]    Run Keywords    Reload Page 
        ...    Prepare post draft invoice to "${EINVOICE_URL_API}" at uri "${UPLOAD_INVOICE_URI}" from file "${UPLOAD_INVOICE_TEMPLATE_FILE_NAME}"  
    
    Given Create invoice post request data to "${EINVOICE_URL_WEB}" at uri "${GROUP_INVOICE_URI}" via "${CREATE_INVOICE_TEMPLATE}" with "${CREATE_INV_FOR_VALIDATE_DRAFT}"
    When Search invoice number via input "${TV_invoice_num_upload}"
    And User click on specificed invoice row "1" at column "5"
    And User click button edit
    And Attach file "${ATTACHED_INVOICE_FILE}" to invoice level at type "Invoice" 
    And Attach file "${ATTACHED_PO_FILE}" to po level at type "PO Form"
    And Click submit button in edit invoice
    And Click confirm submit draft invoice
    Then Popup amount exceed gr line amount shown with message "${MSG_GR_AMT_EXCEED}"
    And Edit invoice page again when click OK button on popup warning
    Click 'X' to close edit invoice page

    [Teardown]    Run Keywords    Delete draft invoice from "${EINVOICE_URL_API}" at uri "${DELETE_DRAFT_INVOICE_URI}" via "${UPLOAD_DRAFT_INV_VALIDATE['supplierMpId']}" and "${TV_invoice_num_upload}" 
                          ...    Rejected invoice "${TV_invoice_num_api}" on buyer "${INVOICE_BUYER_SUPPLIER['buyer_mpid']}" and supplier "${INVOICE_BUYER_SUPPLIER['supplier_mpid']}" from "${APPROVAL_WORKFLOW_TEMPLATE_FILE_NAME}" to endpoint "${EINVOICE_URL_API}" and workflow "${APPROVAL_WORKFLOW_URI}" approval "${APPROVAL_URI}"

