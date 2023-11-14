*** Setting ***
### Global ###
Resource    ../../../../resources/global_lib.resource
Resource    ../../../../resources/global_var.resource
Resource    ../../../../resources/global_keyword.resource
### Keyword for Common/Reuse ###
Resource    ../../../../keywords/web/common/common_web_keywords.resource
Resource    ../../../../keywords/api/common/common_api_keywords.resource
Resource    ../../../../keywords/database/common/common_db_keywords.resource
Resource    ../../../../keywords/web/common/invoice_menu_keywords.resource
### Page keyword releted ###
Resource    ../../../../keywords/database/common/common_db_keywords.resource
Resource    ../../../../keywords/web/invoice/invoice_status_keywords.resource
Resource    ../../../../keywords/web/invoice/upload_invoice_keywords.resource
### Test Suite Data ###
Variables   ../../../../resources/testdata/${env}/invoice/create_invoice.yaml
Variables   ../../../../resources/testdata/${env}/invoice/invoice_status.yaml
Variables   ../../../../resources/testdata/${env}/invoice/upload_invoice.yaml
Variables   ../../../../resources/testdata/${env}/thirdparty/buyer_manage_invoice.yaml

Suite Setup        Open setup browser with ${EINVOICE_URL_WEB} and ${BROWSER} and go to invoice supplier with user TT00100

Suite Teardown     Run Keywords    Delete All Cookies
                            ...    Close All browsers
Test Setup    Click tab 'Invoice Status'                             
Test Teardown   Reload page                            



*** Test Cases ***
To Verify upload invoice successfully
     [Tags]      uploadinvoice      ready
     Given Click upload invoice button
     and Select buyer "${BUYER_NAME_EN_TRUE}" on upload invoice modal
     When Upload invoice template "${UPLOAD_INVOICE_SUCCESS}"
     Then Success bar is shown "${INVOICE_UPLOAD_IN_QUEUE.EN}"
     and Page redirect to Upload status page
     and first row show filename "${UPLOAD_INVOICE_SUCCESS}" ,buyer ${BUYER_NAME_EN_TRUE}" ,upload date is current date and status is "Completed"
    #  and Verify invoice created and insert data ${INVOICE_UPLOAD_SUCCESS_DATA} to db correctly

To Verify upload invoice warning correctly incase required fields
    [Tags]      uploadinvoice   ready
    Given Click upload invoice button
    and Select buyer "${BUYER_NAME_EN_TRUE}" on upload invoice modal
    When Upload invoice template "${UPLOAD_INVOICE_INVALID_REQUIRED_FIELD}"
    Then Verify upload invoice error massage "${UPLOAD_INVOICE_ERRORMSG_INVALID_REQUIRED_FIELD}"      

To Verify upload invoice warning correctly incase fields exceed limit characters
    [Tags]      uploadinvoice   ready
    Given Click upload invoice button
    and Select buyer "${BUYER_NAME_EN_TRUE}" on upload invoice modal
    When Upload invoice template "${UPLOAD_INVOICE_INVALID_EXCEED_LIMIT_DATA}"
    Then Verify upload invoice error massage "${UPLOAD_INVOICE_ERRORMSG_INVALID_EXCEED_LIMIT_DATA}"     

To Verify upload supplier offline warning correctly incase dupplicate data in file
    [Tags]      uploadinvoice   ready
    Given Click upload invoice button
    and Select buyer "${BUYER_NAME_EN_TRUE}" on upload invoice modal
    When Upload invoice template "${UPLOAD_INVOICE_INVALID_DUPPLICATE_DATA}"
    Then Verify upload invoice error massage "${UPLOAD_INVOICE_ERRORMSG_INVALID_DUPPLICATE_DATA}"     

To Verify upload supplier offline warning correctly incase fields invalid format
    [Tags]      uploadinvoice   ready
    Given Click upload invoice button
    and Select buyer "${BUYER_NAME_EN_TRUE}" on upload invoice modal
    When Upload invoice template "${UPLOAD_INVOICE_INVALID_FIELD_FORMAT}"
    Then Verify upload invoice error massage "${UPLOAD_INVOICE_ERRORMSG_INVALID_FIELD_FORMAT}" 

To Verify upload supplier offline warning correctly incase data more than 1000 rows
    [Tags]      uploadinvoice   ready
    Given Click upload invoice button
    and Select buyer "${BUYER_NAME_EN_TRUE}" on upload invoice modal
    When Upload invoice template "${UPLOAD_INVOICE_INVALID_ROWS_NUMBER}"
    Then Verify upload invoice file format invalid error massage "${UPLOAD_INVOICE_ERRORMSG_INVALID_ROWS_NUMBER}"       

To Verify upload supplier offline warning correctly incase no data in file
    [Tags]      uploadinvoice   ready
    Given Click upload invoice button
    and Select buyer "${BUYER_NAME_EN_TRUE}" on upload invoice modal
    When Upload invoice template "${UPLOAD_INVOICE_INVALID_NO_DATA}"
    Then Verify upload invoice file format invalid error massage "${UPLOAD_INVOICE_ERRORMSG_INVALID_NO_DATA}" 

To Verify upload invoice warning correctly incase invalid file over size
    [Tags]      uploadinvoice   ready
    Given Click upload invoice button
    and Select buyer "${BUYER_NAME_EN_TRUE}" on upload invoice modal
    When Upload invoice template "${UPLOAD_INVOICE_INVALID_FILE_OVER_SIZE}"
    Then Verify upload invoice file format invalid error massage "${UPLOAD_INVOICE_ERRORMSG_INVALID_FILE_SIZE}"  

To Verify upload invoice warning correctly incase invalid file format
    [Tags]      uploadinvoice   ready
    Given Click upload invoice button
    and Select buyer "${BUYER_NAME_EN_TRUE}" on upload invoice modal
    When Upload invoice template "${UPLOAD_INVOICE_INVALID_FILE_FORMAT}"
    Then Verify upload invoice file format invalid error massage "${UPLOAD_INVOICE_ERRORMSG_INVALID_FILE_FORMAT}"  

To Verify after upload invoice fail can clear file
    [Tags]      uploadinvoice   ready
    Given Click upload invoice button
    and Select buyer "${BUYER_NAME_EN_TRUE}" on upload invoice modal
    When Upload invoice template "${UPLOAD_INVOICE_INVALID_FILE_OVER_SIZE}"      
    and Click Clear file    
    Then Verify error list hide from modal and upload button can click  
