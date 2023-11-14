*** Setting ***
### Global ###
Resource    ../../../resources/global_lib.resource
Resource    ../../../resources/global_var.resource
Resource    ../../../resources/global_keyword.resource
### Keyword for Common/Reuse ###
Resource    ../../../keywords/web/common/common_web_keywords.resource
Resource    ../../../keywords/api/common/common_api_keywords.resource
Resource    ../../../keywords/database/common/common_db_keywords.resource
Resource    ../../../keywords/web/common/invoice_menu_keywords.resource
### Page keyword releted ###
Resource    ../../../keywords/web/invoice/supplier_create_invoice_keywords.resource
Resource    ../../../keywords/database/common/common_db_keywords.resource
Resource    ../../../keywords/web/invoice/invoice_status_keywords.resource
Resource    ../../../keywords/database/invoice/create_invoice.resource
### Test Suite Data ###
Variables   ../../../resources/testdata/${env}/invoice/create_invoice.yaml
Variables   ../../../resources/testdata/${env}/invoice/invoice_status.yaml
Variables   ../../../resources/testdata/${env}/thirdparty/buyer_manage_invoice.yaml

Suite Setup    Open setup browser with ${url} and ${browser} and go to invoice supplier with user TT00100
Suite Teardown     Run Keywords    Delete All Cookies
                            ...    Close All browsers



*** Test Cases ***
Create invoice online for buyer MTL
    [Tags]      Regression      Supplier    MTL     CreateInvoice   Invoice     DB
    [Documentation]     Create Invoice for buyer MTL
                ...     Verify feature Additional fields 
                ...     Config additional fields for invoice level , po level 
                ...     Verify arrangement, displayname, input value, update value
                ...     And submit invoice then go to check invoice status and value
    Gen invoice data for invoice header
    User create Invoice with buyer "${BUYER_NAME_TH_MTL}" currency "${ALL_CURRENCY_EN}"
    Verify create invoice step1 page
    Select PO GR at first row and Create new invoice
    Verify create invoice step2 page
    Calculate vat and set to variable
    Input Invoice Number ${Gen_InvoiceNumber} at row '1', Invoice date ${Gen_InvoiceDate} at row '1'
    Input Taxinvoice Number ${Gen_TaxInvoiceNumber} at row '1', Taxinvoice date ${Gen_TaxInvoiceDate} at row '1'
    Input Vat at invoice row '1'
    Input NoteToBuyer ${Gen_NoteToBuyer}
    Set invoice header data to variables
    Go to Additional Invoice at row '1' 
    Verify additional invoice modal
    Verify Header data on additional invoice modal
    Verify additional invoice config fields show correctly
    Input additional invoice data then go back to create invoice step2
    Sleep   20s
    ### Go to Additional PO
    ### Verify additional PO modal
    ### Verify Header data on additional PO modal
    ### Verify additional PO config fields show correctly
    ### Input additional PO data then go back to create invoice step2 
    # Submit invoice
    # Verify success bar show ${CREATE_1_INVOICE_SUCCESS_ON_SUCCESS_BAR_EN} and web redirect to invoice list page  
    # Invoice '${Gen_invoiceNumber}' status should be 'Awaiting Approval'
    ### And invoice number ${Gen_invoiceNumber} show additional data correctly on View detail page                                