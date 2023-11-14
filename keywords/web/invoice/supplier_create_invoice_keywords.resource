*** Settings ***
Variables    ../../../resources/locators/invoice/supplier_create_invoice_locator.yaml
Variables    ../../../resources/locators/invoice/invoice_locator.yaml

*** Keywords ***
########################################################################################################################
# KEYWORD LEVEL 1 : To Support BDD style
# PLEASE DO
#   1. Passing parameter in keyword's name, then pass it to keyword level 2.
#
# PLEASE DO NOT 
#   1. Access any LOCATOR.
#   2. Access any VARIABLE directly.
########################################################################################################################
User create Invoice with buyer "${buyer_name}" currency "${currency_name}"
    Click "Create New Invoice" button
    Click "Select PR/PO" button
    Click on buyer dropdownlist
    Verify Displaying of Continue Button Must Be Disabled
    Input value to "Buyer Search" text field    ${buyer_name}
    Select buyer        ${buyer_name}
    Verify Displaying of Buyer on Drop Down List Supplier Online    ${buyer_name}
    Click on currency dropdownlist
    Select currency     ${currency_name}
    Verify Displaying of Currency on Drop Down List Supplier Online    ${currency_name}
    Click "Next" button to "Create Invoice"

Select all PO and Create New Invoice
    Select all PO by check dropdown list on table
    Click "Create New Invoice" button
    Click "Next" button to summary PO of Invoice

Select PO GR at first row and Create new invoice
    Select PO Number By Selected Row    1
    Click "Create New Invoice" button on step1
    Click "Next" button to summary PO of Invoice

Go to Invoice details page
    Click first row of PO to drew down to "Invoice Details"

"${column_name}" column first row in create invoice page should equal to "${total_amount}"
    ${actual_retention_firstrow}=  Get cell text by column name and row number    ${column_name}    1
    Should Be Equal As Numbers    ${total_amount}    ${actual_retention_firstrow}

# Click "Next" button to "Create Invoice"
#     Wait Until Element Is Visible    ${btn_continue}    ${TIMEOUT}
#     Click Element    ${btn_continue}

Verify create invoice step1 page
    Verify displaying of navigator step 1 must be actived

Verify create invoice step2 page
   Verify displaying of navigator step 2 must be actived

Gen invoice data for invoice header 
    Generate invoice number, tax invoice number, invoice date, tax invoice date, note to buyer 

Input Invoice Number ${invoicenumber} at row '${Invnumrow}', Invoice date ${invoicedate} at row '${Invdaterow}'
    Input Invoice Number        ${invoicenumber}        ${Invnumrow}
    Select Invoice Date         ${invoicedate}          ${Invdaterow}
    
Input Taxinvoice Number ${taxinvoicenumber} at row '${Taxinvrow}', Taxinvoice date ${taxinvoicedate} at row '${Taxinvdate}'
    Input Tax Invoice Number    ${taxinvoicenumber}     ${Taxinvrow}
    Select Tax Invoice Number   ${taxinvoicedate}       ${Taxinvdate}

Input NoteToBuyer ${Note}    
    Input Note To Buyer        ${Note}

Input Vat at invoice row '${vat_rownum}'
    Input Vat   ${Vat}  ${vat_rownum}
Submit invoice
    Click on submit button
    Click on 'Yes button' to submit invoice

Go to Additional Invoice at row '${row_num}'
    Click on additional invoice button at row   ${row_num}   

Verify additional invoice modal
    Verify displaying of additional invoice modal at tab    1

Verify header data on additional invoice modal
    Verify displaying of invoice number    ${Gen_InvoiceNumber}
    Verify displaying of invoice date      ${Gen_InvoiceDateDisplay}
    Verify displaying of amount included vat   ${Invoice_amt_included_vat}
    Verify displaying of amount currency   ${Invoice_amt_currency}

Set invoice header data to variables
    ${invoice_amt_currency}=    Get invoice amount currency
    ${invoice_amt_included_vat}=    Get invoice amount included vat 
    Set test variable   ${invoice_amt_included_vat}
    Set test variable   ${invoice_amt_currency}
    
Calculate vat and set to variable
    ${invoice_amt_excluded_vat}=    Get invoice amount excluded vat 
    ${Vat}=     Calculate vat from amount excluded vat      ${invoice_amt_excluded_vat}
    Set test variable   ${Vat}
    Set test variable   ${invoice_amt_excluded_vat}

Verify additional invoice config fields show correctly
    # Verify configuration invoice additional required fields show error  "${REQUIRED_FIELDS_ERROR_TH}"   ${MTL_MPID}
    Verify arrangement for configuration invoice additional at tab      1   ${MTL_MPID}

Input additional invoice data then go back to create invoice step2
    Input data to additional invoice by data type at tab    1   ${MTL_MPID}
    Click on update button
    Verify displaying of navigator step 2 must be actived

On create invoice step1 system show initial data ,buyer "${buyer_name}" and currency "${currency}"
    Verify Displaying Of Buyer Header Name    ${buyer_name}
    Verify Displaying Of Amount Header    0.00
    Verify Displaying Of Amount Currency Header    ${currency}
    Verify Create New Button Must Be Disabled
    Verify Next Button Must Be Disabled

User search invoice "${INVOICE_NUMBER_COMPLETE_RETENTION}" and status "${STATUS.COMPLETED_RETENTION}" which will be use to create invoice
    Select invoice status on dropdown    ${STATUS.COMPLETED_RETENTION}
    Search invoice by search keyword    ${INVOICE_NUMBER_COMPLETE_RETENTION}

User select status filter "${invoice_status}"
    Select invoice status on dropdown    ${invoice_status}

System should display all Invoice that have status "${invoice_status}"
    Verify status of invoice results     ${invoice_status}   

User clicked at invoice "${INVOICE_NUMBER_COMPLETE_RETENTION}" to select invoice
    Click the first row of invoice list 

User clicked "${invoice_action_button}" button
    Click invoice detail's view action button     ${invoice_action_button}
    Wait until loading complete 

Set invoice amount to "${invoice_amount}"

    Select PO GR at first row
    Set invoice amount     ${invoice_amount} 

User clicked submit 
    Click on submit retention button
    Click on 'Yes button' to submit invoice

System should create invoice "${INVOICE_NUMBER_FROM_RETENTION}" successfully 
    Wait Until Keyword Succeeds    5 min    2 sec    verify invoice in database    ${INVOICE_NUMBER_FROM_RETENTION}

user can change page size to "${ddl_option_20}","${ddl_option_50}","${ddl_option_100}"
    Wait Until Keyword Succeeds    2 min    2 sec    Verify Number Of Entries Showing Per Page    ${ddl_option_20}
    Select Number Of Entries Showing Per Page    50
    Wait Until Keyword Succeeds    2 min    2 sec    Verify Number Of Entries Showing Per Page    ${ddl_option_50}
    Select Number Of Entries Showing Per Page    100
    Wait Until Keyword Succeeds    2 min    2 sec    Verify Number Of Entries Showing Per Page    ${ddl_option_100}
    Select Number Of Entries Showing Per Page    20
    Wait Until Keyword Succeeds    2 min    2 sec    Verify Number Of Entries Showing Per Page    ${ddl_option_20}

user can change pagination to "${next_page}" ,"${prev_page}" , "${first_page}" and "${last_page}"
    ${po_list_range}=    Get Range From PO List Offline
    ${total_entries}=    Get Total Entries From PO List Offline
    Run Keyword If      ${total_entries} > ${po_list_range}     Run Keywords    
    ...             Verify Pagination       ${next_page}
    ...     AND     Verify Pagination       ${prev_page}
    ...     AND     Verify Pagination       ${last_page}
    ...     AND     Verify Pagination       ${first_page}

user can search PO/GR by search filter
#   Verify Search By PO Number
    ${expected_po_number}=    Get PO Number By Selected Row    1
    Search By PO Number    ${expected_po_number}
    Verify Search Function By PO Number As Keyword    ${expected_po_number}
    Click Close Button On Search Results    PO Number
#   Verify Search By PO Created Date
    Select PO Created Date From And PO Created Date To     ${CREATE_STEP1_FILTER.CREATE_DATE_FROM}    ${CREATE_STEP1_FILTER.CREATE_DATE_TO}
    Click Search Button
    Verify Displaying PO Created Date On Search Results    ${CREATE_STEP1_FILTER.CREATE_DATE_FROM}    ${CREATE_STEP1_FILTER.CREATE_DATE_TO}
    Click Close Button On Search Results    PO Created
#   Verify Search By GR Number
    ${expected_gr_number}=    Get GR Number By Selected Row    2
    Search By GR Number    ${expected_gr_number}
    Verify Search Function By GR Number As Keyword    ${expected_gr_number}
    Click Close Button On Search Results    GR Number
#   Verify Search By GR Created Date
    Select GR Created Date From And GR Created Date To     ${CREATE_STEP1_FILTER.CREATE_DATE_FROM}    ${CREATE_STEP1_FILTER.CREATE_DATE_TO}
    Click Search Button
    Verify Displaying GR Created Date On Search Results    ${CREATE_STEP1_FILTER.CREATE_DATE_FROM}    ${CREATE_STEP1_FILTER.CREATE_DATE_TO}
    Click Close Button On Search Results    GR Created    

user can expand po list
    ${total_entries}=    Get Range From PO List Offline
    Click Expand Button At Line Number   1
    Verify Expand Function At Line Number    1
    Click Collapse Button At Line Number   1
    Verify Collapse Function At Line Number    1
    Click Expand All Button
    Verify Expand All Function   ${total_entries}
    Click Expand All Button
    Verify Collapse All Function    ${total_entries}

user select '2' po/gr to create an invoice then click "Next" button to summary PO of Invoice
    Select PO Number By Selected Row    1
    Click "Create New Invoice" button on step 1
    Select PO Number By Selected Row    2
    Click Add to Invoice Button    Invoice 01
    Awaiting Expected Element Is Enabled    ${btn_next_step1}
    Click "Next" button to summary PO of Invoice

user select a po/gr to create an invoice then click "Next" button to summary PO of Invoice    
    Select PO Number By Selected Row    1
    Click "Create New Invoice" button on step 1
    Awaiting Expected Element Is Enabled    ${btn_next_step1}
    Click "Next" button to summary PO of Invoice

user select po/gr to create '2' invoices then click "Next" button to summary PO of Invoice
    Select PO Number By Selected Row    1
    Click "Create New Invoice" button on step 1
    Select PO Number By Selected Row    2
    Click "Create New Invoice" button on step 1
    Awaiting Expected Element Is Enabled    ${btn_next_step1}
    Click "Next" button to summary PO of Invoice   

On create invoice step2 when user submit invoice system show warning message correctly 
    #Verify displaying of warning message for "Invoice Number field" and "Invoice Date field"
    Click on submit button
    Wait Until Element Is Visible    ${lbl_invoice_number_required}
    Verify Displaying Warning Message Of Required Fields    ${lbl_invoice_number_required}
    Wait Until Element Is Visible    ${lbl_invoice_date_required}
    Verify Displaying Warning Message Of Required Fields    ${lbl_invoice_date_required}
    # Verify displaying of warning message for "Tax Invoice Date field"
    Input Invoice Number    invoice_number    1
    Input Tax Invoice Number       Taxinvoice_number   1
    Select Invoice Date     '2020-05-25 00:00:00.000'      1
    Input Tax Invoice Number    Tax_invoice_number    1
    Click on submit button
    Wait Until Element Is Visible    ${lbl_tax_invoice_number_required}
    Verify Displaying Warning Message Of Required Fields    ${lbl_tax_invoice_number_required}
    # Verify displaying of warning message for "VAT Amount field"
    Wait Until Element Is Visible    ${lbl_vat_amount_required}
    Verify Displaying Warning Message Of Required Fields    ${lbl_vat_amount_required}

User can delete a selected invoice at create invoice 
    Verify invoice at linenum      2
    Select Checked On Invoice Table On Create Invoice At Row '1'
    Delete selected row
    Verify deleted invoice at linenum   2

user can delete a po/gr that selected from step1
    Wait until loading complete
    Delete PO/GR of first invoice at row    2
    Verify deleted PO/GR of first invoice at row    2

user adjust VAT then VAT Base Amount ,Invoice amount calculate correctly
    Input VAT    5  1
    Verify VAT Base Amount calculate correctly
    Verify Displaying Of Value On Invoice Amount (Include VAT)

Get "GR number" "PO number" "${buyer_name}" "Invoice Amount" "${currency_code}" from create invoice step 2     
    ${GRnumber_step2}   Get text    ${lbl_invoice_details_first_row_GRnumber}
    ${POnumber_step2}   Get text    ${lbl_invoice_details_first_row_POnumber}
    ${buyername_step2}      Set variable    ${buyer_name}
    ${Invoiceamount_step2}  Get text    ${lbl_invoice_details_first_row_invoiceamount}
    ${currencycode_step2}   Set variable    ${currency_code}
    Set test variable   ${GRnumber_step2}  
    Set test variable   ${POnumber_step2}
    Set test variable   ${buyername_step2}
    Set test variable   ${Invoiceamount_step2}
    Set test variable   ${currencycode_step2}

Verify "Invoice Details" show correct data from create invoice step 2
    Wait until loading complete 
    ${GRnumber_details}   Get text    ${lbl_invoice_details_page_GRnumber}
    @{GRnumber} =  Split String    ${GRnumber_details}      :${SPACE}
    ${POnumber_details}   Get text    ${lbl_invoice_details_page_POnumber}
    @{POnumber} =  Split String    ${POnumber_details}      :${SPACE}
    ${buyername_details}      Get text    ${lbl_invoice_details_page_buyername}
    ${Invoiceamount_details}  Get text    ${lbl_invoice_details_page_invoiceamount}
    ${currencycode_details}   Get text    ${lbl_invoice_details_page_currency}

    Should be equal     ${GRnumber}[1]   ${GRnumber_step2}  
    Should be equal     ${POnumber}[1]   ${POnumber_step2}  
    Should be equal     ${buyername_details}        ${buyername_step2}
    Should be equal     ${Invoiceamount_details}    ${Invoiceamount_step2}
    Should be equal     ${currencycode_details}     ${currencycode_step2}

Modify data "Invoice amount" "Retention" all items
    ${items_row}    Get Element Count   ${gr_detail.tr_row}
    Set Test Variable    ${count_enabled}    ${0}
    :FOR    ${row}      IN RANGE    1   ${items_row}+1
        ${inv_locator}  Replace variables   ${gr_detail.txt_invoice_amount_row}   
        ${row_check}=    Run Keyword And Return Status    Element Should Be Enabled     ${inv_locator}  
        RUN KEYWORD IF      ${row_check} == True    Put "Invoice amount" "Retention" to an item     ${row}
        RUN KEYWORD IF      ${row_check} == True    Counting number
    END
    ${detail_subtotal}=    Evaluate    "{:,.2f}".format(${count_enabled} * 2)
    ${detail_retention}=   Evaluate    "{:,.2f}".format(${count_enabled} * 1)
    ${detail_invoice_amount}=  Evaluate    "{:,.2f}".format(${detail_subtotal} - ${detail_retention})

    Set test variable   ${detail_subtotal}
    Set test variable   ${detail_retention}
    Set test variable   ${detail_invoice_amount}

Verify "Invoice Amount" show correctly on "Invoice Details" page and save
    ${actual_Invoiceamount}  Get text    ${lbl_invoice_details_page_invoiceamount}
    Should be equal     ${actual_Invoiceamount}    ${detail_invoice_amount}
    Click Button    ${gr_detail.create_step2_btn_save_invoice_amount}

"Invoice Amount" "Retention Amount" show correctly on create invoice step 2
    Verify "Invoice Amount" "Retention Amount" at PO/GR first row
    Verify "Invoice Amount" "Retention Amount" at Invoice first row
    Verify Displaying Of Value On Invoice Amount (Include VAT)
Search filter is visible
    Verify page 'invoice' filter

Default filter should be 'Invoice Number' and status filter should be 'All Status'
    Check default value of filter    Invoice Number
    Check default value of status    All Status    

User click calendar in search textbox
    Click calendar button

Default calendar selection should be 'Any Time'
    Anytime radio button is selected

Select 'Created Date' date range
    Click 'Created Date' radio button

Selected calendar selection should be 'Created Date'
    Created Date radio button is selected

Select 'Due Date' date range
    Click 'Due Date' radio button

Selected calendar selection should be 'Due Date'
    Due Date radio button is selected
    
########################################################################################################################
# KEYWORD LEVEL 2 : Micro keyword
# PLEASE DO
#   1. Always keep it do small action.
#   2. Access LOCATOR.
#   3. Passing parameter by using [Arguments] tag
#
# PLEASE DO NOT 
#   1. Access any VARIABLE directly. (Allow only ${TIMEOUT})
########################################################################################################################
Select all PO by check dropdown list on table
    Wait Until Element Is Visible    ${obj_create_invoice.add_invoice_step.chb_select_all_po}    ${TIMEOUT}
    Click Element    ${obj_create_invoice.add_invoice_step.chb_select_all_po}

# Click "Select PR/PO" button
#     Wait Until Element Is Visible    ${btn_select_po_gr}    ${TIMEOUT}
#     Click Element    ${btn_select_po_gr}

Click "Create New Invoice" button
    Wait Until Element Is Visible    ${btn_create_invoice}    ${TIMEOUT}
    Click Element    ${btn_create_invoice}

Click "Create New Invoice" button on step 1
    Wait Until Element Is Visible    ${btn_create_invoice_step1}    ${TIMEOUT}
    Click Element    ${btn_create_invoice_step1}

Click "Next" button to summary PO of Invoice
    Wait Until Element Is Enabled    ${btn_next_step1}    ${TIMEOUT}
    Click Element    ${btn_next_step1}

Click first row of PO to drew down to "Invoice Details"
    Wait until loading complete
    Wait Until Element Is Enabled    ${lbl_invoice_details_first_row_second_col}    ${TIMEOUT}
    Click Element    ${lbl_invoice_details_first_row_second_col}

Get column number by column name
    [Arguments]    ${column_name}
    ${column_number}=  Set Variable    0
    @{items}=  Get WebElements    ${obj_create_invoice.invoice_detail_step.lbl_cols_po_list}
    FOR    ${item}    IN    @{items}   
       ${column_number}=    Evaluate    ${column_number} + 1
       ${actual_col_name}=   Get Text   ${item}
       Run Keyword If    '${actual_col_name.upper()}' == '${column_name.upper()}'    Exit For Loop
    END       
    ${column_number}=    Evaluate    ${column_number} - 1
    [Return]   ${column_number}

Get cell text by column name and row number
    [Arguments]    ${column_name}    ${row_number}
    ${col_number}=  Get column number by column name    ${column_name}
    ${obj_target_cell}=  Replace Variables    ${obj_create_invoice.invoice_detail_step.lbl_cell_in_table}
    ${cell_text}=   Get Text   ${obj_target_cell}
    [Return]   ${cell_text}    

Click on buyer dropdownlist
    Wait Until Element Is Visible    ${ddl_selected_buyer_offline}    ${TIMEOUT}
    Click Element    ${ddl_selected_buyer_offline}

Click on supplier dropdownlist
    Wait Until Element Is Visible    ${ddl_selected_supplier_offline}    ${TIMEOUT}
    Click Element    ${ddl_selected_supplier_offline}

Click on currency dropdownlist
    Wait Until Element Is Visible    ${ddl_selected_currency_offline}    ${TIMEOUT}
    Click Element    ${ddl_selected_currency_offline}

# Input value to "Buyer Search" text field
#     [Arguments]    ${search_criteria}
#     Wait Until Element Is Visible    ${txt_search_buyer}    ${TIMEOUT}
#     Input Text    ${txt_search_buyer}    ${search_criteria}

Select buyer
    [Arguments]    ${selected_value}
    Wait Until Element Is Visible    ${ddl_search_buyer_offline}    ${TIMEOUT}
    ${selected_buyer}   Replace variables   ${select_buyer}
    Click Element    ${selected_buyer}

Select currency
    [Arguments]    ${selected_value}
    Wait Until Element Is Visible    ${ddl_currency_offline_list}    ${TIMEOUT}
    ${selected_currency}   Replace variables   ${select_currency}
    Wait Until Element Is Visible    ${selected_currency}
    Click Element    ${selected_currency}

Verify Displaying Of Navigator Step 1 Must be Actived
    Wait Until Element Is Visible    ${ico_step_1}
    Element Should Be Visible    ${ico_step_1}   

Select PO Number By Selected Row
    [Documentation]    This keyword is checking at the selected po in table at selected row
    [Arguments]    ${row}
    ${cbo_po}     Replace variables   ${cbo_po_with_row}
    Wait Until Element Is Visible       ${cbo_po}    ${TIMEOUT}
    Wait Until Page Contains Element    ${cbo_po}    ${TIMEOUT}
    Select Checkbox                     ${cbo_po}

Verify Displaying Of Navigator Step 2 Must be Actived
    Wait Until Element Is Visible    ${ico_step_last}
    Element Should Be Visible    ${ico_step_last}      

Generate invoice number, tax invoice number, invoice date, tax invoice date, note to buyer
    ${date_create_date}=        Get Current Date    result_format=%Y%m%d%H%M
    ${string_create_date}       Convert To String   ${date_create_date}    
    ${date_create_date_2}=      Get Current Date    result_format=%Y-%m-%d
    ${string_create_date_2}     Convert To String   ${date_create_date_2} 
    ${Gen_InvoiceDateDisplay}=      Get Current Date    result_format=%d/%m/%Y       
    ${Gen_InvoiceNumber}=       Set Variable       I${string_create_date}
    ${Gen_TaxInvoiceNumber}=    Set Variable       T${string_create_date}
    ${Gen_NoteToBuyer}=         Set Variable       Note-${string_create_date}
    ${Gen_InvoiceDate}=         Set Variable       '${string_create_date_2} 00:00:00.000'
    ${Gen_TaxInvoiceDate}=      Set Variable       '${string_create_date_2} 00:00:00.000'
    set test variable   ${Gen_InvoiceNumber}
    set test variable   ${Gen_TaxInvoiceNumber}
    set test variable   ${Gen_NoteToBuyer}
    set test variable   ${Gen_InvoiceDate}
    set test variable   ${Gen_InvoiceDateDisplay}
    set test variable   ${Gen_TaxInvoiceDate}

Input Invoice Number        
    [Arguments]    ${invoicenumber}         ${row}
    ${invnum_with_row}=    Replace variables   ${txt_invoice_number}
    Wait Until Element Is Visible    ${invnum_with_row}
    Input Text    ${invnum_with_row}    ${invoicenumber}

Input Tax Invoice Number    
    [Arguments]    ${taxinvoicenumber}      ${row}
    ${taxnum_with_row}=    Replace variables   ${txt_tax_invoice_number}
    Wait Until Element Is Visible    ${taxnum_with_row}
    Input Text    ${taxnum_with_row}    ${taxinvoicenumber}

Select Invoice Date         
    [Arguments]    ${invoicedate}   ${row}
    #Convert Date Format
    ${invoicedate}=    Convert Date    ${invoicedate}    result_format=%Y-%m-%d
    ${invoicedate_wo_zero}=    Replace String    ${invoicedate}    -0    -
    #Get month and year
    ${month_txt}=    Convert Date    ${invoicedate}    result_format=%B
    ${year_txt}=    Convert Date    ${invoicedate}    result_format=%Y

    ${locator_txt_invoice_date}     Replace variables   ${txt_invoice_date}
    Click Element       ${locator_txt_invoice_date}

    #Select Month
    FOR    ${i}    IN RANGE    999999
        ${month_checker}=    Run Keyword And Return Status    Element Should Contain   ${calendar_menu.spn_month_select}    ${month_txt}
        Exit For Loop If    ${month_checker} == True
        Wait Until Element Is Visible         ${calendar_menu.btn_previous_month}    ${TIMEOUT}
        Click element     ${calendar_menu.btn_previous_month}
    END    
    #Select Year
    FOR    ${i}    IN RANGE    999999
        ${year_checker}=    Run Keyword And Return Status    Element Should Contain   ${calendar_menu.spn_year_select}    ${year_txt}
        Exit For Loop If    ${year_checker} == True
        Wait Until Element Is Visible         ${calendar_menu.btn_previous_year}    ${TIMEOUT}
        Click element     ${calendar_menu.btn_previous_year}
    END    
    #Select Date
    Execute Javascript    document.querySelector("td[title='${invoicedate_wo_zero}'] > div").click()

Select Tax Invoice Number   
    [Arguments]     ${taxinvoicedate}   ${row}
    #Convert Date Format
    ${taxinvoicedate}=    Convert Date    ${taxinvoicedate}    result_format=%Y-%m-%d
    ${taxinvoicedate_wo_zero}=    Convert Date    ${taxinvoicedate}    result_format=%Y-%#m-%#d
    #Get month and year
    ${month_txt}=    Convert Date    ${taxinvoicedate}    result_format=%B
    ${year_txt}=    Convert Date    ${taxinvoicedate}    result_format=%Y

    ${locator_txt_tax_invoice_date}     Replace variables   ${txt_tax_invoice_date}
    Click Element       ${locator_txt_tax_invoice_date}

    #Select Month
    FOR    ${i}    IN RANGE    999999
        ${month_checker}=    Run Keyword And Return Status    Element Should Contain   ${calendar_menu.spn_month_select}    ${month_txt}
        Exit For Loop If    ${month_checker} == True
        Wait Until Element Is Visible         ${calendar_menu.btn_previous_month}    ${TIMEOUT}
        Click element     ${calendar_menu.btn_previous_month}
    END    
    #Select Year
    FOR    ${i}    IN RANGE    999999
        ${year_checker}=    Run Keyword And Return Status    Element Should Contain   ${calendar_menu.spn_year_select}    ${year_txt}
        Exit For Loop If    ${year_checker} == True
        Wait Until Element Is Visible         ${calendar_menu.btn_previous_year}    ${TIMEOUT}
        Click element     ${calendar_menu.btn_previous_year}
    END    
    #Select Date
    Execute Javascript    document.querySelector("td[title='${taxinvoicedate_wo_zero}'] > div").click()

Input Note To Buyer        
    [Arguments]     ${Note}    
    Wait Until Page Contains Element    ${txt_notetobuyer}    ${TIME_OUT}
    Wait Until Element Is Visible    ${txt_notetobuyer}    ${TIME_OUT}
    Input Text    ${txt_notetobuyer}    ${Note}

Click on submit retention button
    Wait until loading complete
    Wait Until Element Is Visible    ${btn_footer_submit_retention}
    Click Button    ${btn_footer_submit_retention}


Click on submit button
    Wait until loading complete
    Wait Until Element Is Visible    ${btn_footer_submit}
    Click Button    ${btn_footer_submit}

Click on 'Yes button' to submit invoice
    Wait Until Element Is Visible    ${btn_footer_submit_yes}
    Click Element    ${btn_footer_submit_yes}

Click on additional invoice button at row
    [Arguments]     ${row_num}
    ${btn_additional_invoice_with_row}      Replace variables       ${btn_additional_invoice}
    Wait Until Element Is Visible    ${btn_additional_invoice_with_row}
    Click Element    ${btn_additional_invoice_with_row}

Verify displaying of additional invoice modal at tab 
    [Arguments]     ${tab_num}
    ${invoice_additional_tab_with_no}      Replace variables       ${invoice_additional_tab}
    Wait Until Element Is Visible    ${invoice_additional_tab_with_no}
    Element Should Be Visible    ${invoice_additional_tab_with_no}    

Verify displaying of invoice number    
    [Arguments]      ${InvoiceNumber}=(Undifined)
    Wait Until Element Is Visible    ${additional_inv_header.lbl_invoicenumber}
    Element Text Should Be    ${additional_inv_header.lbl_invoicenumber}    ${InvoiceNumber}

Verify displaying of invoice date      
    [Arguments]      ${InvoiceDate}=(Undifined)
    Wait Until Element Is Visible    ${additional_inv_header.lbl_invoicedate}
    Element Text Should Be    ${additional_inv_header.lbl_invoicedate}    ${InvoiceDate}

Verify displaying of amount included vat    
    [Arguments]     ${invoice_amt_included_vat}=0.00
    Wait Until Element Is Visible    ${additional_inv_header.lbl_invoiceamt}
    Element Text Should Be    ${additional_inv_header.lbl_invoiceamt}    ${invoice_amt_included_vat}

Verify displaying of amount currency  
    [Arguments]     ${currency}=THB
    Wait Until Element Is Visible    ${additional_inv_header.lbl_currency}
    Element Text Should Be    ${additional_inv_header.lbl_currency}    ${currency}

Get invoice amount included vat 
    Wait Until Element Is Visible    ${lbl_amount_included_vat}
    ${amount_included_vat}=    Get Text    ${lbl_amount_included_vat}
    [Return]    ${amount_included_vat}

Get invoice amount excluded vat 
    Wait Until Element Is Visible    ${lbl_amount_excluded_vat}
    ${amount_excluded_vat}=    Get Text    ${lbl_amount_excluded_vat}
    [Return]    ${amount_excluded_vat}    

Get invoice amount currency
    Wait Until Element Is Visible    ${lbl_amt_currency}
    ${amt_currency}=    Get Text    ${lbl_amt_currency}
    [Return]    ${amt_currency}

Calculate vat from amount excluded vat      
    [Arguments]     ${invoice_amt_excluded_vat}
    ${invoice_amt_excluded_vat}=    Remove String        ${invoice_amt_excluded_vat}   ,
    ${cal_vat}=  Evaluate  (${invoice_amt_excluded_vat} * ${VAT7}) / 100
    ${cal_vat}=  Convert To Number  ${cal_vat}  2
    ${cal_vat}=  Evaluate  "%.2f" % ${cal_vat}
    [Return]    ${cal_vat}

Verify configuration invoice additional required fields show error 
    [Arguments]     ${errormsg}     ${buyermpid}
    ${db_required_field}    Get configuration required field additional invoice for online supplier from db     ${buyermpid}
    Clear Value from UI     ${db_required_field}
    Compare configuration required field    ${db_required_field}    ${errormsg}

Verify arrangement for configuration invoice additional at tab
    [Arguments]     ${tab}     ${buyermpid}
    ${db_arrangement_field}    Get additional invoice configuration arrangement field for online supplier from db      ${tab}      ${buyermpid}
    Compare configuration arrangement field    ${db_arrangement_field}    

Verify configuration dropdown list value   
    ${db_dropdown_field}    Get additional invoice configuration dropdown field value first field from db 
    Compare configuration dropdown value field    ${db_dropdown_field}    

Input data to additional invoice by data type at tab
    [Arguments]     ${tab}  ${buyermpid}
    ${db_dropdown_field}    Get all additional invoice configuration field for online supplier from db      ${tab}     ${buyermpid}
    Fill data to additional invoice configuration field by inputType    ${db_dropdown_field}

Click on update button
    Wait Until Element Is Visible    ${btn_additional_invoice_update}
    Click Element    ${btn_additional_invoice_update}

Input Vat
    [Arguments]    ${vat}   ${vat_rownum}
    ${vat_with_row}=    Replace variables   ${txt_vat}
    Wait Until Element Is Visible    ${vat_with_row}
    Input Text    ${vat_with_row}    ${vat}

Get configuration required field additional invoice for online supplier from db  
    [Arguments]     ${BuyerMPID} 
    ${sql_inv_UIItem_req}=     Get query string for SELECT 'UIItem' where with 'IsRequired','MPID' and 'ShowToSupplier' is True    '${BuyerMPID}'
    ${return_inv_UIItem}=  eInvoice Execute SELECT query string    ${sql_inv_UIItem_req}
    [Return]    ${return_inv_UIItem} 

Get additional invoice configuration arrangement field for online supplier from db  
     [Arguments]     ${tab_number}      ${BuyerMPID} 
    ${sql_inv_UIItem}=     Get query string for SELECT 'UIItem' where with 'MPID','Tab' and 'ShowToSupplier' is True     ${tab_number}    '${BuyerMPID}'
    ${return_inv_UIItem}=  eInvoice Execute SELECT query string    ${sql_inv_UIItem}
    [Return]    ${return_inv_UIItem}     

Get additional invoice configuration dropdown field value first field for online supplier from db  
    [Arguments]     ${BuyerMPID} 
    ${sql_inv_UIItem_ddl}=     Get query string for SELECT 'UIItem' where with 'MPID' and 'ShowToSupplier' is True and 'InputType' is dropdown    '${BuyerMPID}'
    ${return_inv_UIItem}=  eInvoice Execute SELECT query string    ${sql_inv_UIItem_ddl}
    [Return]    ${return_inv_UIItem} 

Get all additional invoice configuration field for online supplier from db
    [Arguments]     ${tab}  ${BuyerMPID} 
    ${sql_inv_UIItem}=     Get query string for SELECT 'UIItem' where with 'MPID','Tab',IsDisabled = 'False' and 'ShowToSupplier' is True    ${tab}  '${BuyerMPID}'
    ${return_inv_UIItem}=  eInvoice Execute SELECT query string    ${sql_inv_UIItem}
    [Return]    ${return_inv_UIItem}    

Compare configuration required field
    [Arguments]    ${db_required_field}    ${error_msg}
    [Documentation]    Compare required field from DB and UI 
    ${rowCount}     Get Length   ${db_required_field}
    FOR     ${i}    IN RANGE    0    ${rowCount}
       ${lbl_configuration_fields}=    set variable    ${db_required_field[${i}][0]}
       ${lbl_config_locator}   Replace variables   ${msg_required.config}
       Element should be visible       ${lbl_config_locator}    
    END

Compare configuration arrangement field         
    [Arguments]    ${db_arrangement_field}     
    [Documentation]    Compare arrangement field from DB and UI 
    ${rowCount}     Get Length   ${db_arrangement_field}
    FOR     ${i}    IN RANGE    0    ${rowCount}
       ${row_ui}=  evaluate    ${i}+1
       ${row_ul}=  evaluate    (${i} / 4 )+1
       ${row_li}=  evaluate    (${i} % 4 )+1
       ${lbl_config}=      Set variable        ${db_arrangement_field[${i}][0]} :
       ${ui_config_locator}   replace variables    ${config.lbl}
       Element Should be visible   ${ui_config_locator} 
       Element text should be   ${ui_config_locator}   ${lbl_config}
    END

Compare configuration dropdown value field    
    [Arguments]  ${db_ddl_field}   
    [Documentation]    Compare dropdown option from DB and UI
     ${rowCount}     Get Length   ${db_ddl_field}
     ${row_seq}=    set variable    ${db_ddl_field[0][0]}
     ${ddl_count_locator}   replace variables   ${config.ddl_with_value}
     ${option_count}    Get Element Count   ${ddl_count_locator}
    FOR     ${i}    IN RANGE    0    ${rowCount}
       ${ddl_value_locator}   replace variables    ${config.ddl}
       Click Element       ${ddl_value_locator}
       Select From List By Label   ${ddl_value_locator}    ${db_ddl_field[${i}][1]}
    END   

    Should be equal as integers       ${option_count}     ${rowCount}    

Fill data to additional invoice configuration field by inputType
    [Arguments]     ${db_all_field}   
     ${rowCount}     Get Length   ${db_all_field}
    FOR     ${i}    IN RANGE    0    ${rowCount}
       ${Value}=    Get value to fill by InputType     ${db_all_field[${i}][1]}   ${db_all_field[${i}][0]}
       Fill data by InputType      ${db_all_field[${i}][1]}   ${db_all_field[${i}][2]}     ${Value}
    END   

Clear Value from UI
    [Arguments]    ${db_required_field}
    ${rowCount}     Get Length   ${db_required_field}
    FOR     ${i}    IN RANGE    0    ${rowCount}
       ${UI_locator}=    Get Locator for configuration required field      ${db_required_field[${i}][1]}
       ${lbl_config}=      Set variable        ${db_required_field[${i}][0]}
       ${lbl_config_locator}   Replace variables   ${config.txt_with_value}
       Run Keyword If      '${db_required_field[${i}][1]}' != 'dropdown'      Clear Element Text      ${lbl_config_locator}    
    END

Get Locator for configuration required field
    [Arguments]     ${UI_type}
    ${UI_type_locator} =	Run Keyword If	'${UI_type}' == 'date'	Set variable    /following-sibling::div/input
    ...	ELSE IF     '${UI_type}' == 'dropdown'                      Set variable    /following-sibling::select
    ...	ELSE                                                        Set variable    /following-sibling::input
    [Return]    ${UI_type_locator}

Get value to fill by InputType     
    [Arguments]     ${UI_type}  ${displayname}
    ${date_create_date}=        Get Current Date    result_format=%Y-%m-%d
    ${string_create_date}       Convert To String   ${date_create_date}    
    ${Today_date}=              Set Variable        '${string_create_date} 00:00:00.000'
    ${year_txt}=                Convert Date    ${date_create_date}    result_format=%Y.%m

    ${valuetofill} =	Run Keyword If	'${UI_type}' == 'date'	Set variable    ${Today_date}
    ...	    ELSE IF     '${UI_type}' == 'dropdown'                      Set variable    /following-sibling::select
    ...	    ELSE IF     '${UI_type}' == 'text'                          Set variable    ${displayname}
    ...     ELSE                                                        Set variable    ${year_txt}
    [Return]    ${valuetofill}

Fill data by InputType
    [Arguments]     ${Inputtype}     ${Uiitemid}   ${value}  
    ${locator_by_type}=	    Run Keyword If	'${Inputtype}' == 'date'      Set variable    id=calendar-${Uiitemid}
    ...     ELSE                                                          Set variable    id=input_${Uiitemid}
    Run Keyword If	'${Inputtype}' == 'date'	                        Select config date          ${locator_by_type}      ${value}  
    ...	ELSE IF     '${Inputtype}' == 'dropdown'                      Select config dropdown at first option     ${locator_by_type}
    ...	ELSE                                                        Input config text            ${locator_by_type}      ${value}

Select config date
     [Arguments]     ${locator}  ${date}   
     #Convert Date Format
    ${date}=    Convert Date    ${date}    result_format=%Y-%m-%d
    ${date_wo_zero}=    Convert Date    ${date}    result_format=%Y-%#m-%#d
    #Get month and year
    ${month_txt}=    Convert Date    ${date}    result_format=%B
    ${year_txt}=    Convert Date    ${date}    result_format=%Y

    Click Element       ${locator}

    #Select Month
    FOR    ${i}    IN RANGE    999999
        ${month_checker}=    Run Keyword And Return Status    Element Should Contain   ${calendar_menu.spn_month_select}    ${month_txt}
        Exit For Loop If    ${month_checker} == True
        Wait Until Element Is Visible         ${calendar_menu.btn_previous_month}    ${TIMEOUT}
        Click element     ${calendar_menu.btn_previous_month}
    END    
    #Select Year
    FOR    ${i}    IN RANGE    999999
        ${year_checker}=    Run Keyword And Return Status    Element Should Contain   ${calendar_menu.spn_year_select}    ${year_txt}
        Exit For Loop If    ${year_checker} == True
        Wait Until Element Is Visible         ${calendar_menu.btn_previous_year}    ${TIMEOUT}
        Click element     ${calendar_menu.btn_previous_year}
    END    
    #Select Date
    Execute Javascript    document.querySelector("td[title='${date_wo_zero}'] > div").click()

Select config dropdown at first option
     [Arguments]     ${locator}
     Wait Until Element Is Visible    ${locator}
     Click element     ${locator}
     ${first_option}=   Remove String        ${locator}   id=   
     ${config_first_option}     Replace variables   ${config_first_option}
     Wait Until Element Is Visible    ${config_first_option} 
     Click element     ${config_first_option} 

Input config text
    [Arguments]     ${locator}  ${txt}   
    Wait Until Element Is Visible    ${locator}
    Input Text    ${locator}    ${txt}

Select invoice status on dropdown
    [Arguments]    ${invoice_status}
    Wait Until Element Is Visible    ${obj_invoice.search_invoice.lbl_status}    ${TIMEOUT}
    Wait until loading complete
    Click Element    ${obj_invoice.search_invoice.lbl_status}
    ${ddl_status_search_invoice_in_status_locator}=    Replace Variables    ${obj_invoice.search_invoice.ddl_status}    #${invoice_status}
    Wait Until Element Is Visible    ${ddl_status_search_invoice_in_status_locator}    ${TIMEOUT}
    Click Element    ${ddl_status_search_invoice_in_status_locator}
    Wait until loading complete   

Search invoice by search keyword
    [Arguments]     ${search_keyword}
    Input Text    ${obj_invoice.search_invoice.txt_search_invoice}    ${search_keyword}
    Click Element    ${obj_invoice.search_invoice.btn_search}
    Wait until loading complete

Click the first row of invoice list
    ${ret_col_no}=  set variable  3
    ${target_obj}=    Replace Variables     ${obj_invoice.invoice_list.tbl_firstrow_with_columm}
    Wait Until Element Is Visible    ${target_obj}    ${TIMEOUT}
    Click Element    ${target_obj}
    
Click invoice detail's view action button 
    [Arguments]    ${invoice_action_button}
    ${target_obj}=    Replace Variables     ${obj_view_invoice_detail.btn_action}
    Wait Until Element Is Visible    ${target_obj}    ${TIMEOUT}
    Click Element    ${target_obj}

Select PO GR at first row
    Wait Until Element Is Visible    ${invoice_detail.tbl_first_row_po}    ${TIMEOUT}
    Click Element    ${invoice_detail.tbl_first_row_po}

Verify invoice in database    
    [Arguments]    ${INVOICE_NUMBER_FROM_RETENTION}
    ${query_result}=    eInvoice Execute SELECT query string    SELECT InvoiceNum FROM Invoice WHERE InvoiceNum = '${INVOICE_NUMBER_FROM_RETENTION}'
    Should be Equal    ${INVOICE_NUMBER_FROM_RETENTION}    ${query_result}[0][0]

Verify created invoice success bar 
    Wait Until Element Is Visible    ${lbl_success_bar}    ${TIMEOUT}
    
Verify Displaying of Continue Button Must Be Disabled
    Wait Until Element Is Visible    ${btn_continue}    ${TIMEOUT}
    Element Should Be Disabled    ${btn_continue}

Verify Displaying of Buyer on Drop Down List Supplier Online
    [Arguments]    ${expected_value}=Please select buyer
    Wait Until Element Is Visible    ${ddl_selected_buyer_offline}    ${TIMEOUT}
    Element Should Contain    ${ddl_selected_buyer_offline}    ${expected_value}

Verify Displaying of Currency on Drop Down List Supplier Online
    [Arguments]    ${expected_value}=All Currency
    Wait Until Element Is Visible    ${ddl_selected_currency_offline}    ${TIMEOUT}
    Element Text Should Be    ${ddl_selected_currency_offline}    ${expected_value}    


Verify Displaying Of Buyer Header Name    
    [Arguments]  ${buyer}
    Wait Until Element Is Visible    ${lbl_header_buyer_name}    ${TIMEOUT}
    Element Text Should Be    ${lbl_header_buyer_name}    ${buyer}

Verify Displaying Of Amount Header    
    [Arguments]    ${amount}=0.00
    Wait Until Element Is Visible    ${lbl_header_amount}    ${TIMEOUT}
    Element Text Should Be    ${lbl_header_amount}    ${amount}

Verify Displaying Of Amount Currency Header    
    [Arguments]    ${amount_currency}=THB
    Wait Until Element Is Visible    ${lbl_header_amount_currency}    ${TIMEOUT}
    Element Text Should Be    ${lbl_header_amount_currency}    ${amount_currency}

Verify Create New Button Must Be Disabled
    Wait Until Element Is Visible    ${btn_create_new_invoice}    ${TIMEOUT}
    ${btn_class}    Get Element Attribute    ${btn_create_new_invoice}    class
    Should Contain    ${btn_class}    btn-op-disabled

Verify Create New Button Must Be Enabled
    Wait Until Element Is Visible    ${btn_create_new_invoice}    ${TIMEOUT}
    Element Should Be Enabled    ${btn_create_new_invoice}

Verify Next Button Must Be Disabled
    Wait Until Element Is Visible    ${btn_next_disabled}    ${TIMEOUT}
    Element Should Be Disabled    ${btn_next_disabled}

Verify Next Button Must Be Enabled
    Wait Until Element Is Visible    ${btn_next_enabled}    ${TIMEOUT}
    Element Should Be Enabled    ${btn_next_enabled}    

Select Number Of Entries Showing Per Page
    [Arguments]    ${expected_entries}
    Wait Until Page Contains Element    ${lbl_showing_entries}
    Scroll Element Into View    ${create_inv_step1_footer.lbl_footer}
    Wait Until Element Is Visible    ${lbl_showing_entries}
    Select From List By Value    ${lbl_showing_entries}    ${expected_entries}

Verify Number Of Entries Showing Per Page
    [Arguments]    ${expected_entries}
    Wait Until Page Contains Element    ${lbl_showing_entries}      ${TIMEOUT}
    Wait Until Element Is Visible    ${lbl_showing_entries}         ${TIMEOUT}
    ${count}    Set Variable    0
    ${index}    Set Variable    1
    ${po_list_range}=    Get Range From PO List Offline
    ${expected_entries}=    Run keyword if      ${po_list_range} < ${expected_entries}      Set Variable    ${po_list_range}        
    ...   ELSE    Set Variable    ${expected_entries}
    ${count}=    Get Element Count    ${tbl_po_gr.tr_rows}
    ${po_list_entries}=    Convert To String    ${count}
    Should Be Equal    ${po_list_entries}    ${expected_entries}

Get Range From PO List Offline
    Wait until loading complete
    Wait Until Page Contains Element    ${lbl_footer_record_summary_create_inv_page}
    Wait Until Element Is Visible    ${lbl_footer_record_summary_create_inv_page}
    ${record_summary}=    Get Text    ${lbl_footer_record_summary_create_inv_page}
    ${range}=    Evaluate    '${record_summary}'.replace('1 to ','')
    [Return]   ${range}    

Click Next Page Button By Expected Click Time
    [Arguments]    ${index}
    FOR    ${i}    IN RANGE    0    ${index}
        Wait until loading complete
        Wait Until Page Contains Element    ${ico_next_page}
        Wait Until Element Is Visible    ${ico_next_page}
        Scroll Element Into View    ${ico_next_page}
        Wait Until Keyword Succeeds    1 min    2 sec    Click Element    ${ico_next_page}
    END

Click Previous Page Button By Expected Click Time
    [Arguments]    ${index}
    FOR    ${i}    IN RANGE    0    ${index}
        Wait until loading complete
        Wait Until Page Contains Element    ${ico_previous_page}
        Wait Until Element Is Visible    ${ico_previous_page}
        Scroll Element Into View    ${ico_previous_page}
        Wait Until Keyword Succeeds    1 min    2 sec    Click Element    ${ico_previous_page}        
    END

Click First Page Button
    Wait until loading complete
    Wait Until Page Contains Element    ${ico_first_page}      ${TIMEOUT}
    Wait Until Element Is Visible    ${ico_first_page}
    Scroll Element Into View    ${ico_first_page}
    Wait Until Keyword Succeeds    1 min    2 sec    Click Element    ${ico_first_page}

Click Last Page Button
    Wait until loading complete
    Wait Until Page Contains Element    ${ico_last_page}      ${TIMEOUT}
    Wait Until Element Is Visible    ${ico_last_page}
    Scroll Element Into View    ${ico_last_page}
    Wait Until Keyword Succeeds    1 min    2 sec    Click Element    ${ico_last_page}    

Get Current Page On PO List Offline
    Wait Until Keyword Succeeds    1 min    2 sec    Wait until loading complete
    Wait Until Page Contains Element    ${lbl_footer_record_summary_create_inv_page}
    Wait Until Element Is Visible    ${lbl_footer_record_summary_create_inv_page}
    ${entries_per_page}=    Get Number Of Entries Per Page From PO List Offline
    ${record_summary}=    Get Text    ${lbl_footer_record_summary_create_inv_page}
    ${record_summary}=    Fetch From Left    ${record_summary}    to
    ${record_summary}=    Strip String    ${record_summary}
    ${current_page}=    Evaluate    ${record_summary}-1
    ${current_page}=    Evaluate    ${current_page}/${entries_per_page}
    [Return]   ${current_page}    

Get Total Entries From PO List Offline
    Wait Until Page Contains Element    ${lbl_footer_total_entries_create_inv_page}
    Wait Until Element Is Visible    ${lbl_footer_total_entries_create_inv_page}    ${TIMEOUT}
    ${total_entries}=    Get Text    ${lbl_footer_total_entries_create_inv_page}
    ${total_entries}=    Evaluate    '${total_entries}'.replace('of ','')
    ${total_entries}=    Evaluate    '${total_entries}'.replace(' entries','')
    [Return]    ${total_entries}

Get Number Of Entries Per Page From PO List Offline
    Wait Until Page Contains Element    ${lbl_showing_entries}
    Wait Until Element Is Visible    ${lbl_showing_entries}
    ${entries_per_page}=   Get Selected List Value    ${lbl_showing_entries}
    [Return]    ${entries_per_page}    

Verify Pagination After Click Previous Page By Expected Click Time
    [Arguments]    ${click_time}    ${page_before_click}
    Wait Until Keyword Succeeds    2 min    2 sec    Wait until loading complete
    ${entries_per_page}=    Get Number Of Entries Per Page From PO List Offline
    ${start_value}=    Evaluate    ${page_before_click}-${click_time}
    ${start_value}=    Evaluate    ${start_value}*${entries_per_page}
    ${start_value_per_page}=    Evaluate    ${start_value}+1
    ${end_value_per_page}=    Evaluate    ${start_value}+${entries_per_page}
    ${total_entries}=    Get Total Entries From PO List Offline
    Element Text Should Be    ${lbl_footer_record_summary_create_inv_page}    ${start_value_per_page} to ${end_value_per_page}
    Element Text Should Be    ${lbl_footer_total_entries_create_inv_page}    of ${total_entries} entries

Verify Pagination After Click Next Page By Expected Click Time
    [Arguments]    ${click_time}    ${page_before_click}
    Wait Until Keyword Succeeds    2 min    2 sec    Wait until loading complete
    ${entries_per_page}=    Get Number Of Entries Per Page From PO List Offline
    ${start_value}=    Evaluate    ${page_before_click}+${click_time}
    ${start_value}=    Evaluate    ${start_value}*${entries_per_page}
    ${start_value_per_page}=    Evaluate    ${start_value}+1
    ${end_value_per_page}=    Evaluate    ${start_value}+${entries_per_page}
    ${total_entries}=    Get Total Entries From PO List Offline
    Element Text Should Be    ${lbl_footer_record_summary_create_inv_page}    ${start_value_per_page} to ${end_value_per_page}
    Element Text Should Be    ${lbl_footer_total_entries_create_inv_page}    of ${total_entries} entries    

Verify Pagination After Click First Page Button
    Wait Until Keyword Succeeds    2 min    2 sec    Wait until loading complete
    ${total_entries}=    Get Total Entries From PO List Offline
    ${entries_per_page}=    Get Number Of Entries Per Page From PO List Offline
    Element Text Should Be    ${lbl_footer_record_summary_create_inv_page}    1 to ${entries_per_page}
    Element Text Should Be    ${lbl_footer_total_entries_create_inv_page}    of ${total_entries} entries    

Verify Pagination After Click Last Page Button
    Wait Until Keyword Succeeds    2 min    2 sec    Wait until loading complete
    ${total_entries}=    Get Total Entries From PO List Offline
    ${entries_per_page}=    Get Number Of Entries Per Page From PO List Offline
    ${number_of_invoice_in_list}    Get Element Count    ${tbl_po_gr.tr_rows}
    ${start_value} =    Evaluate    ${total_entries} - ${number_of_invoice_in_list}
    ${start_value_per_page}=    Evaluate    ${start_value}+1
    Element Text Should Be    ${lbl_footer_record_summary_create_inv_page}    ${start_value_per_page} to ${total_entries}
    Element Text Should Be    ${lbl_footer_total_entries_create_inv_page}    of ${total_entries} entries    

Verify Pagination   
    [Arguments]     ${page_button}
    Run Keyword If    '${page_button}' == 'Next page'   Verify pagination next page button
        ...     ELSE IF     '${page_button}' == 'Previous page'     Verify pagination previous page button
        ...     ELSE IF     '${page_button}' == 'First page'        Verify pagination first page button 
        ...     ELSE                                                Verify pagination last page button 

Verify pagination next page button
    ${current_page1}=    Get Current Page On PO List Offline
    Wait Until Keyword Succeeds    2 min    2 sec    Click Next Page Button By Expected Click Time    1
    Verify Pagination After Click Next Page By Expected Click Time           1    ${current_page1}

Verify pagination previous page button    
    ${current_page2}=    Get Current Page On PO List Offline
    Wait Until Keyword Succeeds    2 min    2 sec    Click Previous Page Button By Expected Click Time    1
    Verify Pagination After Click Previous Page By Expected Click Time       1    ${current_page2}

Verify pagination last page button
    Wait Until Keyword Succeeds    2 min    2 sec    Click Last Page Button
    Verify Pagination After Click Last Page Button  

Verify pagination first page button   
    Wait Until Keyword Succeeds    2 min    2 sec    Click First Page Button  
    Verify Pagination After Click First Page Button

Get PO Number By Selected Row
    [Documentation]    This keyword is used for getting PO number by selected row
    [Arguments]    ${row}
    ${po_locator}   Replace variables   ${tbl_po_gr.po_number}
    Wait Until Element Is Visible    ${po_locator}    ${TIMEOUT}
    ${selected_po_number} =    Get Text    ${po_locator}
    [Return]    ${selected_po_number}    

Get GR Number By Selected Row
    [Documentation]    This keyword is used for getting GR number by selected row
    [Arguments]    ${row}
    ${gr_locator}   Replace variables   ${tbl_po_gr.gr_number}
    Wait Until Element Is Visible    ${gr_locator}    ${TIMEOUT}
    ${selected_gr_number} =    Get Text    ${gr_locator}
    [Return]    ${selected_gr_number}    

Search By PO Number
    [Arguments]    ${expected_po_number}
    Wait until loading complete  
    Wait Until Element Is Visible    ${txt_search_box_create_inv_page}
    Input Text    ${txt_search_box_create_inv_page}    ${expected_po_number}
    Click Button    ${btn_search_po_gr}    

Search By GR Number
    [Arguments]    ${expected_gr_number}
    Wait until loading complete
    Wait Until Element Is Visible    ${txt_search_box_create_inv_page}
    Click Element    ${ddl_search_po_gr}
    Wait Until Page Contains Element    ${ddl_search_gr_value}
    Click Element   ${ddl_search_gr_value}
    Input Text    ${txt_search_box_create_inv_page}    ${expected_gr_number}
    Click Button    ${btn_search_po_gr}

Verify Search Function By PO Number As Keyword
    [Arguments]    ${po_keyword}
    Wait until loading complete   
    Wait Until Page Contains Element    ${txt_search_results}
    Wait Until Element Is Visible    ${txt_search_results}
    Element Should Contain    ${lbl_po_search_results}    PO Number “${po_keyword}”

    ${keyword_length}=    Get Length    ${po_keyword}
    ${index}=    Get Range From PO List Offline
    FOR    ${row}    IN RANGE    1    ${index}+1
        ${po_locator}   Replace variables   ${tbl_po_gr.po_number}
        ${po_list}=    Get Text    ${po_locator}
        ${sub_po_list}=    Get Substring    ${po_list}    0    ${keyword_length}
        Should Start With    ${po_keyword}    ${sub_po_list}
    END

Verify Search Function By GR Number As Keyword
    [Arguments]    ${gr_keyword}
    Wait until loading complete   
    Wait Until Page Contains Element    ${txt_search_results}
    Wait Until Element Is Visible    ${txt_search_results}
    Element Should Contain    ${lbl_gr_search_results}    GR Number “${gr_keyword}”    

    ${keyword_length}=    Get Length    ${gr_keyword}
    ${index}=    Get Range From PO List Offline
    FOR    ${row}    IN RANGE    1    ${index}+1
        ${gr_locator}   Replace variables   ${tbl_po_gr.gr_number}
        ${gr_list}=    Get Text    ${gr_locator}
        ${sub_gr_list}=    Get Substring    ${gr_list}    0    ${keyword_length}
        Should Start With    ${gr_keyword}    ${sub_gr_list}
    END

Click Search Button
    Wait Until Element Is Visible    ${btn_search_po_gr}
    Click Button    ${btn_search_po_gr}

Select PO Created Date From And PO Created Date To
    [Arguments]    ${po_created_date_from}    ${po_created_date_to}
    Select PO Created Date Check Box
    @{created_date_from}=     Split String    ${po_created_date_from}    /
    Select PO/GR Created Date On Calendar Modal    ${rb_txt_created_po_date_from}    POFrom    @{created_date_from}[2]    @{created_date_from}[1]     @{created_date_from}[0]
    @{created_date_to}=     Split String    ${po_created_date_to}    /
    Select PO/GR Created Date On Calendar Modal    ${rb_txt_created_po_date_to}    POTo    @{created_date_to}[2]    @{created_date_to}[1]     @{created_date_to}[0]

Select GR Created Date From And GR Created Date To
    [Arguments]    ${gr_created_date_from}    ${gr_created_date_to}
    Select GR Created Date Check Box
    @{created_date_from}=     Split String    ${gr_created_date_from}    /
    Select PO/GR Created Date On Calendar Modal    ${rb_txt_created_gr_date_from}    GRFrom    @{created_date_from}[2]    @{created_date_from}[1]     @{created_date_from}[0]
    @{created_date_to}=     Split String    ${gr_created_date_to}    /
    Select PO/GR Created Date On Calendar Modal    ${rb_txt_created_gr_date_to}    GRTo    @{created_date_to}[2]    @{created_date_to}[1]     @{created_date_to}[0]

Select PO Created Date Check Box
    Wait until loading complete 
    Wait Until Page Contains Element    ${btn_search_calendar_create_inv_page}
    Wait Until Element Is Visible    ${btn_search_calendar_create_inv_page}
    Click Element    ${btn_search_calendar_create_inv_page}
    Wait Until Page Contains Element    ${mdl_search_type}
    Wait Until Element Is Visible    ${mdl_search_type}
    Scroll Element Into View    ${chk_po_created_date}
    Click Element   ${chk_po_created_date}

Select GR Created Date Check Box
    Wait until loading complete 
    Wait Until Element Is Visible    ${btn_search_calendar_create_inv_page}
    Click Element    ${btn_search_calendar_create_inv_page}
    Wait Until Page Contains Element    ${mdl_search_type}
    Wait Until Element Is Visible    ${mdl_search_type}
    Scroll Element Into View    ${chk_gr_created_date}
    Click Element   ${chk_gr_created_date}    

Select PO/GR Created Date On Calendar Modal
    [Documentation]    This keyword is using for selecting Date picker by inputting expected year, month, date
    [Arguments]    ${expected_locator}    ${expected_calendar}    ${expected_year}    ${expected_month}    ${expected_day}
    Wait Until Element Is Visible    ${expected_locator}
    Click Element    ${expected_locator}
    ${modal_calendar_locator}   Replace variables   ${mdl_calendar}
    Wait Until Page Contains Element    ${modal_calendar_locator}
    Wait Until Element Is Visible   ${modal_calendar_locator}

    ${current_date_format} =    Get Current Date    result_format=datetime
    ${current_day} =    Set Variable    ${current_date_format.day}
    ${current_month} =    Set Variable    ${current_date_format.month}
    ${current_year} =    Set Variable    ${current_date_format.year}

    ${year_diff}=   Evaluate    int("${expected_year}")-int("${current_year}")
    ${month_diff}=  Evaluate    int("${expected_month}")-int("${current_month}")

    Run Keyword If  ${year_diff} < 0    Multiple Click On Previous Year Button PO/GR Created Date    ${year_diff}    ${expected_calendar}
    Run Keyword If  ${year_diff} > 0    Multiple Click On Next Year Button PO/GR Created Date    ${year_diff}    ${expected_calendar}

    Run Keyword If  ${month_diff} < 0    Multiple Click On Previous Month Button PO/GR Created Date    ${month_diff}    ${expected_calendar}
    Run Keyword If  ${month_diff} > 0    Multiple Click On Next Month Button PO/GR Created Date    ${month_diff}    ${expected_calendar}

    ${select_day}=    Convert To Integer   ${expected_day}
    ${modal_calendar_date_locator}   Replace variables   ${mdl_calendar_date}
    ${modal_calendar_date_select_locator}   Replace variables   ${mdl_calendar_date_select}
    Scroll Element Into View    ${modal_calendar_date_locator}
    Click Element   ${modal_calendar_date_select_locator}

Multiple Click On Next Year Button PO/GR Created Date
    [Arguments]     ${click_times}    ${calendar_type}
    FOR    ${INDEX}    IN RANGE    0    ${click_times}
       ${btn_year_locator}     Replace variables   ${mdl_calendar_btn_month}
       ${btn_next_year_locator}     Replace variables   ${btn_next_year}    
        Scroll Element Into View    ${btn_year_locator}
        Click Element      ${btn_next_year_locator}
    END

Multiple Click On Previous Year Button PO/GR Created Date
    [Arguments]     ${click_times}    ${calendar_type}
    ${click_times}=     Evaluate    abs(${click_times})
    FOR    ${INDEX}    IN RANGE    0    ${click_times}
       ${btn_year_locator}     Replace variables   ${mdl_calendar_btn_month}
       ${btn_prev_year_locator}     Replace variables   ${btn_prev_year}
        Scroll Element Into View    ${btn_year_locator}
        Click Element    ${btn_prev_year_locator}
    END

Multiple Click On Next Month Button PO/GR Created Date
    [Arguments]     ${click_times}    ${calendar_type}
    FOR    ${INDEX}    IN RANGE    0    ${click_times}
       ${btn_mon_locator}     Replace variables   ${mdl_calendar_btn_month}
       ${btn_next_month_locator}     Replace variables   ${btn_next_month}
        Scroll Element Into View    ${btn_mon_locator}
        Click Element    ${btn_next_month_locator}
    END

Multiple Click On Previous Month Button PO/GR Created Date
    [Arguments]     ${click_times}    ${calendar_type}
    ${click_times}=    Evaluate    abs(${click_times})
    FOR    ${INDEX}    IN RANGE    0    ${click_times}
       ${btn_mon_locator}     Replace variables   ${mdl_calendar_btn_month}
       ${btn_prev_month_locator}     Replace variables   ${btn_prev_month}    
        Scroll Element Into View    ${btn_mon_locator}
        Click Element    ${btn_prev_month_locator}
    END

Verify Displaying PO Created Date On Search Results
    [Arguments]    ${expected_po_date_from}    ${expected_po_date_to}
    Wait Until Page Contains Element    ${txt_search_results}
    Wait Until Element Is Visible    ${txt_search_results}
    Element Text Should Be    ${lbl_po_created_search_results}    PO Created “${expected_po_date_from} - ${expected_po_date_to}”

Verify Displaying GR Created Date On Search Results
    [Arguments]    ${expected_gr_date_from}    ${expected_gr_date_to}
    Wait Until Page Contains Element    ${txt_search_results}
    Wait Until Element Is Visible    ${txt_search_results}
    Element Text Should Be    ${lbl_gr_created_search_results}    GR Created “${expected_gr_date_from} - ${expected_gr_date_to}”

Click Close Button On Search Results
    [Arguments]    ${expected_search}
    Wait until loading complete   
    ${search_result_locator}   Replace variables   ${txt_search_results_with_keyword}
    Wait Until Element Is Visible    ${search_result_locator}
    Click Element    ${search_result_locator}   

Click Expand All Button
    Wait until loading complete   
    Wait Until Page Contains Element    ${btn_expand_all}
    Wait Until Element Is Visible    ${btn_expand_all}
    Click Element    ${btn_expand_all}

Click Expand Button At Line Number
    [Arguments]    ${line_num}
    Wait until loading complete
    ${btn_expand_div}   Replace variables       ${tbl_po_gr.tr_btn_expand_row}
    ${btn_expand}           Replace variables       ${tbl_po_gr.tr_btn_expand}
    ${head_row}             Replace variables       ${tbl_po_gr.tr_row_with_linenum}
    Wait Until Page Contains Element    ${btn_expand_div}
    Wait Until Element Is Visible    ${btn_expand_div}
    Scroll Element Into View    ${head_row}  
    Click Element    ${btn_expand}

Click Collapse Button At Line Number
    [Arguments]    ${line_num}
    Wait until loading complete
    ${btn_collapse_div}   Replace variables       ${tbl_po_gr.tr_btn_collapse_row}
    ${btn_expand}           Replace variables       ${tbl_po_gr.tr_btn_collapse}
    ${head_row}             Replace variables       ${tbl_po_gr.tr_row_with_linenum}   
    Wait Until Page Contains Element     ${btn_collapse_div}
    Wait Until Element Is Visible   ${btn_collapse_div}
    Scroll Element Into View        ${head_row}  
    Click Element    ${btn_expand} 

Verify Expand All Function
    [Arguments]    ${index}
    FOR    ${row}    IN RANGE    1    ${index}+1
        ${detail_locator}   Replace variables   ${tbl_po_gr.tr_row_expand_detail_all}
        Wait Until Page Contains Element    ${detail_locator}
        Wait Until Element Is Visible     ${detail_locator}
        Page Should Contain Element    ${detail_locator}
    END

Verify Expand Function At Line Number
    [Arguments]     ${line_num}
    ${head_row}         Replace variables   ${tbl_po_gr.tr_row_with_linenum}
    ${detail_locator}   Replace variables   ${tbl_po_gr.tr_row_expand_detail}
    Scroll Element Into View    ${head_row} 
    Wait Until Page Contains Element    ${detail_locator}
    Wait Until Element Is Visible    ${detail_locator}
    Page Should Contain Element    ${detail_locator}

Verify Collapse All Function
    [Arguments]    ${index}
    FOR    ${row}    IN RANGE    1    ${index}+1
       ${detail_locator}   Replace variables   ${tbl_po_gr.tr_row_expand_detail_all}
        Wait Until Page Does Not Contain Element    ${detail_locator}
        Wait Until Element Is Not Visible     ${detail_locator}
        Element Should Not Be Visible    ${detail_locator}
    END

Verify Collapse Function At Line Number
    [Arguments]     ${line_num}
    ${head_row}         Replace variables   ${tbl_po_gr.tr_row_with_linenum}
    ${detail_locator}   Replace variables   ${tbl_po_gr.tr_row_expand_detail}
    Scroll Element Into View    ${head_row}   
    Wait Until Page Does Not Contain Element    ${detail_locator}
    Wait Until Element Is Not Visible    ${detail_locator}
    Element Should Not Be Visible    ${detail_locator}  

Click Add to Invoice Button
    [Documentation]   This keyword is click button Add to Invoice on box Item Selected
    [Arguments]    ${invoice_no}
    ${btn_add}  Replace variables   ${create_inv_step1_footer.btn_add_to_invoice}
    Wait Until Element Is Visible     ${btn_add}
    Click Element     ${btn_add}  

Awaiting Expected Element Is Enabled
    [Documentation]    This keyword for waiting expected element is enable
    [Arguments]    ${expected_locator}
    Wait Until Element Is Enabled    ${expected_locator}    

Verify Displaying Warning Message Of Required Fields
    [Arguments]    ${locator}
    ${actual_msg} =    Get Text    ${locator}
    Should Be Equal     This field is required    ${actual_msg}    

Select Checked On Invoice Table On Create Invoice At Row '${rownum}'
    [Documentation]    This keyword for checked at check box on first row
    Wait Until Element Is Visible    id=rb_cb_invoice_detail_${rownum}    ${TIMEOUT}
    Select Checkbox    id=rb_cb_invoice_detail_${rownum}    

Verify Displaying Of Value On Invoice Amount (Include VAT)
    Wait Until Element Is Visible    ${txt_vat_1_invoice_detail}
    ${actual_invoice_amount_exclude_vat} =    Get Text    ${lbl_invoice_amount_exclude_vat}
    ${actual_retention} =    Get Text    ${lbl_retention}
    ${actual_vat_amount} =    Get Value    ${txt_vat_1_invoice_detail}
    ${actual_invoice_amount_exclude_vat}    Evaluate    '${actual_invoice_amount_exclude_vat}'.replace(',','')
    ${actual_invoice_amount_exclude_vat}    Convert To Number    ${actual_invoice_amount_exclude_vat}
    ${actual_invoice_amount_include_vat} =    Evaluate    ${actual_invoice_amount_exclude_vat} - ${actual_retention} + ${actual_vat_amount}
    ${actual_invoice_amount_include_vat} =    Evaluate     "{:,.2f}".format(${actual_invoice_amount_include_vat})
    Convert To String    ${actual_invoice_amount_include_vat}
    Element Text Should Be    ${lbl_invoice_amount_include_vat}    ${actual_invoice_amount_include_vat}    
    # Verify calculating of Invoice Amount (Include VAT) field
    ${invoice_amount_include_vat} =    Get Text    ${lbl_invoice_amount_include_vat}
    ${header_invoice_amount} =    Get Text    ${lbl_header_invoice_amount}
    Should Be Equal    ${header_invoice_amount}    ${invoice_amount_include_vat}

Verify VAT Base Amount calculate correctly
    Wait Until Keyword Succeeds    2 min    2 sec     Click Element    ${txt_vatBaseAmount_1_invoice_detail}
    ${vat_amount} =    Get Value    ${txt_vat_1_invoice_detail}
    ${vat_base_amount} =    Get Value    ${txt_vatBaseAmount_1_invoice_detail}
    ${vat_amount_formular}    Evaluate    "{:,.2f}".format((${vat_amount}.00 * 100.00) / 7.00)
    Should Be Equal    ${vat_base_amount}    ${vat_amount_formular}    

Verify invoice at linenum   
    [Arguments]     ${linenum}
    ${linenum_locator}  Replace variables   ${lbl_invoice_linenum}
    Wait Until Element Is Visible    ${linenum_locator}

Delete selected row
    Wait Until Element Is Visible    ${btn_delete_invoice}    ${TIMEOUT}
    Click Element    ${btn_delete_invoice}
    Wait Until Element Is Visible    ${btn_confirm_delete}
    Click Element    ${btn_confirm_delete} 

Verify deleted invoice at linenum 
    [Arguments]     ${linenum}
    ${linenum_locator}  Replace variables   ${lbl_invoice_linenum}
    Wait Until Element Is Not Visible     ${linenum_locator}   

Delete PO/GR of first invoice at row
    [Arguments]     ${row}
     ${pogr_locator}  Replace variables   ${btn_delete_pogr}
     Wait Until Element Is Visible    ${pogr_locator}
    Click Element    ${pogr_locator}
    Wait Until Element Is Visible    ${btn_confirm_delete}
    Click Element     ${btn_confirm_delete}

Verify deleted PO/GR of first invoice at row
    [Arguments]     ${row}
    ${pogr_locator}  Replace variables   ${btn_delete_pogr}
    Wait Until Element Is Not Visible    ${pogr_locator} 
    Element Should Not Be Visible    ${pogr_locator}    

Set invoice amount on invoice details at row    
    [Arguments]     ${invoice_amount}   ${row} 
    ${invoice_locator}  Replace variables   ${gr_detail.txt_invoice_amount_row}
    Wait Until Element Is Visible    ${invoice_locator}    ${TIMEOUT}
    Double click element   ${invoice_locator}
    #Press Keys      ${invoice_locator}     BACKSPACE
    Click Element   ${invoice_locator}    DELETE
    Input Text    ${invoice_locator}    ${invoice_amount} 
    

Set retention amount on invoice details at row    
    [Arguments]     ${retention_amount}   ${row} 
    ${retention_locator}  Replace variables     ${gr_detail.txt_retention_amount_row}
    Wait Until Element Is Visible    ${retention_locator}    ${TIMEOUT}
    Double click element   ${retention_locator}
    #Press Keys      ${retention_locator}     BACKSPACE
    Click Element   ${retention_locator}    DELETE
    Input Text    ${retention_locator}    ${retention_amount}  

Select retention type percent on invoice details at row   
    [Arguments]     ${row} 
    ${retention_select_locator}  Replace variables     ${gr_detail.ddl_retention_select_row}
    Click Element    ${retention_select_locator} 
    ${retention_locator}  Replace variables     ${gr_detail.ddl_retention_option_row_percent}
    Wait Until Element Is Visible    ${retention_locator}   ${TIMEOUT}
    Click Element    ${retention_locator} 

Select retention type amount on invoice details at row   
    [Arguments]     ${row} 
    ${retention_select_locator}  Replace variables     ${gr_detail.ddl_retention_select_row}
    Click Element    ${retention_select_locator}  
    ${retention_locator}  Replace variables     ${gr_detail.ddl_retention_option_row_amount} 
    Wait Until Element Is Visible    ${retention_locator}   ${TIMEOUT}
    Click Element    ${retention_locator} 

Put "Invoice amount" "Retention" to an item     
    [Arguments]     ${row}    
    Set invoice amount on invoice details at row        2   ${row}
    Set retention amount on invoice details at row      1   ${row}
    Select retention type amount on invoice details at row  ${row}

Verify "Invoice Amount" "Retention Amount" at PO/GR first row
    ${POGR_invoiceamount}       Get Text    ${lbl_invoice_details_first_row_invoiceamount}
    ${POGR_retentionamount}     Get Text    ${lbl_invoice_details_first_row_retentionamount}

    Should be equal      ${POGR_invoiceamount}      ${detail_subtotal}
    Should be equal      ${POGR_retentionamount}    ${detail_retention}
    
Verify "Invoice Amount" "Retention Amount" at Invoice first row
    ${inv_invoiceamount} =      Get Text    ${lbl_invoice_amount_exclude_vat}
    ${inv_retentionamount} =    Get Text    ${lbl_retention}

    Should be equal      ${inv_invoiceamount}      ${detail_subtotal}
    Should be equal      ${inv_retentionamount}    ${detail_retention}

Counting number     
    ${temp}    Evaluate    ${count_enabled} + 1
    Set Test Variable    ${count_enabled}    ${temp}

Verify page 'invoice' filter
    Wait Until Element Is Visible         ${obj_invoice.search_invoice.btn_search}    ${TIMEOUT}

Check default value of filter
    [Arguments]   ${invoice_filter}
    ${target_obj}=    Replace Variables     ${obj_invoice.search_invoice.lbl_filter}  #${invoice_filter}

Check default value of status
    [Arguments]   ${invoice_status}
    ${target_obj}=    Replace Variables     ${obj_invoice.search_invoice.lbl_status}  #${invoice_status}

Verify status of invoice results 
    [Arguments]   ${invoice_status}
    ${results_exist}=    Run Keyword And Return Status    Page Should Contain Element    ${obj_invoice.invoice_list.tbl_result_row}
    @{list}=   Get Dictionary values   ${STATUS}
    Run Keyword if    ${results_exist}    Run Keywords    Remove Values From List     ${list}     ${invoice_status}
    ...    AND    Verify Results    ${list}
    ...    ELSE        Page Should Contain Element    ${obj_invoice.invoice_list.tbl_result_empty}

Verify Results
    [Arguments]   ${list}
    FOR    ${element}    IN    @{list}
           Element Should Not Contain    ${obj_invoice.invoice_list.tbl_result_row}   ${element}
    END

Verify filter of invoice results 
    [Arguments]   ${invoice_filter}
    ${results_exist}=    Run Keyword And Return Status    Page Should Contain Element    ${obj_invoice.invoice_list.tbl_result_row}
    Run Keyword if    ${results_exist}    Element Should Contain    ${obj_invoice.invoice_list.tbl_result_row}   ${invoice_filter}
    ...    ELSE        Page Should Contain Element    ${obj_invoice.invoice_list.tbl_result_empty}

Click calendar button
    Click Element       ${obj_invoice.search_invoice.btn_calendar} 

Anytime radio button is selected
    Wait Until Element Is Visible         ${obj_invoice.search_invoice.rdo_anytime}    ${TIMEOUT}
    Element Attribute Value Should Be    ${obj_invoice.search_invoice.rdo_anytime}    checked    true

Click 'Created Date' radio button
    Wait Until Element Is Visible         ${obj_invoice.search_invoice.rdo_date_range}    ${TIMEOUT}
    Click Element       ${obj_invoice.search_invoice.rdo_date_range} 

Created Date radio button is selected
    Wait Until Element Is Visible         ${obj_invoice.search_invoice.rdo_date_range}    ${TIMEOUT}
    Element Attribute Value Should Be    ${obj_invoice.search_invoice.rdo_date_range}    checked    true

Click 'Due Date' radio button
    Wait Until Element Is Visible         ${obj_invoice.search_invoice.rdo_date_range}    ${TIMEOUT}
    Click Element       ${obj_invoice.search_invoice.rdo_date_range} 

Due Date radio button is selected
    Wait Until Element Is Visible         ${obj_invoice.search_invoice.rdo_date_range}    ${TIMEOUT}
    Element Attribute Value Should Be    ${obj_invoice.search_invoice.rdo_date_range}    checked    true

