*** Settings ***
Variables    ../../../resources/locators/invoice/upload_invoice_locator.yaml

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

Select buyer "${buyer_name}" on upload invoice modal
    search buyer on upload invoice modal    ${buyer_name}
    select buyer on upload invoice modal    ${buyer_name}

Upload invoice template "${filename}" 
    Browse file on upload invoice modal   ${filename}

Verify upload invoice error massage "${error_list}"   
    Verify upload invoice warning ,error number and text correctly     ${error_list}
    Verify upload invoice summary message list      ${error_list}

Verify error list hide from modal and upload button can click    
    Verify error list disable
    Verify upload button enable

Verify upload invoice file format invalid error massage "${error_list}"   
   Verify upload invoice warning ,error number and text correctly     ${error_list}    

Page redirect to Upload status page
    Verify tab 'Upload status' display  

Verify invoice created and insert data to db correctly
    ${actual_invoice_data}  Get active invoice online data in DB by invoice number and buyer 

Success bar is shown "${expect_successbar}"
    Verify Success bar visibility with massage      ${expect_successbar} 

first row show filename "${filename}" ,buyer ${buyer}" ,upload date is current date and status is "${uploadstatus}"
    Upload status first row filename is         ${filename}
    Upload status first row buyer is            ${buyer}
    Upload status first row upload date is      #${uploaddate}
    Upload status first row status is           ${uploadstatus}
        
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

Verify Success bar visibility with massage
    [Arguments]     ${expect_successbar}
    Wait Until Element Is Visible    ${lbl_success_bar}    ${TIMEOUT}
    ${actual_successbar}    Get Text     ${lbl_success_bar}
    Should Contain Any    ${expect_successbar}    ${actual_successbar}    

Verify tab 'Upload status' display  
    Wait until element is visible    ${tab_upload_status}     ${TIMEOUT} 

Click Clear file      
    Wait until element is visible    ${error_section.btn_clearfile}     ${TIMEOUT} 
    Click element       ${error_section.btn_clearfile}
    Wait until element is not visible       ${error_section.btn_clearfile}     ${TIMEOUT} 

Click upload invoice button  
    Wait until loading complete
    wait until element is visible   ${btn_upload_invoice}      ${TIMEOUT}
    click element   ${btn_upload_invoice}

Browse file on upload invoice modal   
    [Arguments]  ${filename}    
    ${file_path}    Get Canonical Path    ${CURDIR}/../../../resources/testdata/${env}/invoice/attachfile/${file_name}
    Choose File     ${btn_browse_upload_invoice}   ${file_path}


Verify upload invoice warning ,error number and text correctly    
    [Arguments]     ${error_list}
    Wait until element is visible    ${error_section.error}         ${TIMEOUT}
    Wait until element is visible    ${error_section.error_detail}  ${TIMEOUT}
    ${error_num_with_text}      Get text    ${error_section.error_number}
    ${error_text}               Get text    ${error_section.error_desc}
    ${error_rows}               Get element count   ${error_section.tbl_error_rows}
    Should be equal     ${error_list['error_num_with_text']}    ${error_num_with_text}
    Should be equal     ${error_list['error_txt']}              ${error_text}
    Should be equal as integers     ${error_list['error_num']}  ${error_rows}    

Verify upload invoice summary message list
    [Arguments]     ${error_list}
    Wait until element is visible    ${error_section.tbl_error}     ${TIMEOUT} 
    ${error_rows}   Get element count   ${error_section.tbl_error_rows}
    :FOR    ${i}    IN RANGE   1   ${error_rows+1}  
    \    Verify upload invoice error message result    ${i}     ${error_list['error_list_row_${i}']['desc']}    ${error_list['error_list_row_${i}']['row_num']}   ${error_list['error_list_row_${i}']['column']}

Verify upload invoice error message result    
    [Arguments]     ${index_row}    ${description}    ${row}    ${column}    
    ${desc_locator}=    Replace variables    ${error_section.tbl_error_rows_desc}
    ${row_locator}=    Replace variables    ${error_section.tbl_error_rows_row}
    ${column_locator}=    Replace variables    ${error_section.tbl_error_rows_column}
    ${actual_desc}=    Get Text    ${desc_locator}
    ${actual_row}=    Get Text    ${row_locator}
    ${actual_column}=    Get Text    ${column_locator}
    Should Be Equal    ${description}   ${actual_desc}
    Should Be Equal    ${row}           ${actual_row}
    Should Be Equal    ${column}        ${actual_column}    

Verify error list disable
    Element Should Not Be Visible       ${error_section.error_detail}
    Element Should Not Be Visible       ${error_section.tbl_error}

Verify upload button enable
    Element Should Be Enabled       ${btn_browse_upload_invoice}    

search buyer on upload invoice modal   
    [Arguments]     ${buyer_name} 
    Wait until element is visible   ${ddl_buyer_list}      ${TIMEOUT}
    click element   ${ddl_buyer_list}
    input text      ${txt_search_buyer_list}      ${buyer_name}    

select buyer on upload invoice modal   
    [Arguments]     ${buyer_name}    
    ${ddl_locator}      replace variables   ${ddl_buyer_select}
    click element   ${ddl_locator}

Upload status first row filename is         
    [Arguments]     ${filename}
    Wait until element is visible   //table[@class="table-default table-border table-ein-list"]//tr[1]/td[1]      ${TIMEOUT}
    Element Should Contain      //table[@class="table-default table-border table-ein-list"]//tr[1]/td[1]   ${filename}    

Upload status first row buyer is            
    [Arguments]     ${buyer}
    Element Should Contain      //table[@class="table-default table-border table-ein-list"]//tr[1]/td[2]   ${buyer}    

Upload status first row upload date is      
    [Arguments]
    
    Wait Until Element Is visible    //table[@class="table-default table-border table-ein-list"]//tr[1]/td[4]
    ${upload_date}    Get Text    //table[@class="table-default table-border table-ein-list"]//tr[1]/td[4]

    ${curr_date}    Get Current Date    result_format=%d/%m/%Y

    Should Be Equal    ${upload_date}    ${curr_date}

    #Element Should Contain      //table[@class="table-default table-border table-ein-list"]//tr[1]/td[4]   ${uploaddate}    

Upload status first row status is           
    [Arguments]     ${uploadstatus}    
    Element Should Contain      //table[@class="table-default table-border table-ein-list"]//tr[1]/td[5]   ${uploadstatus}    
