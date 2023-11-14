*** Settings ***
Variables    ../../../resources/locators/cn_dn/cndn_history_locators.yaml


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
History of CNDN "${invoice_num}" header should be display correct  
    [Documentation]    Validate history header compare with database.
                ...    Compare data by equal list from modal and db

    ${history_header}    Get "CNDN History" header in modal  
    ${db_history_header}    Get "CNDN History" header from DB    ${invoice_num}    
    List should be equal as    ${history_header}    ${db_history_header}

History of CNDN "${invoice_num}" detail on supplier should be display correct  
    [Documentation]    Validate history detail
                ...    Compare data by equal list from modal and db

    ${history_detail}    Get "CNDN History" detail in modal   
    ${db_history_detail}    Get "CNDN History" detail of supplier from DB    ${invoice_num}
    List should be equal as    ${history_detail}    ${db_history_detail}

History of CNDN "${invoice_num}" detail on buyer should be display correct    
    [Documentation]    Validate history detail
                ...    Compare data by equal list from modal and db
    ${history_detail}    Get "CNDN History" detail in modal   
    ${db_history_detail}    Get "CNDN History" detail of buyer from DB    ${invoice_num}
    List should be equal as    ${history_detail}    ${db_history_detail} 

CNDN history be show correctly on header with invoice number "${cndn_num}" and "${buyer_name}" and "${create_date}"
    [Documentation]    Verify data on screen without database

    CNDN history header should be display correctly    ${cndn_num}    ${buyer_name}    ${create_date}      

CNDN history be show correctly on detail
    [Documentation]    Verify data on screen without database

    CNDN history detail should be display correctly

CNDN history be show correctly on detail on buyer
    [Documentation]    Verify data on screen without database

    CNDN history detail should be display correctly on buyer

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
CNDN history detail should be display correctly
    Verify invoice history detail date not empty
    Verify invoice history detail activity not empty
    Verify invoice history detail action by not empty

CNDN history detail should be display correctly on buyer   
    Verify invoice history detail date not empty
    Verify invoice history detail activity not empty
    Verify invoice history detail action by not empty on buyer

Verify invoice history detail date not empty
    [Documentation]    Verify invoice detail history date have value and correct format

    Wait Until Element Is Visible    ${tbl_history['row_all_activity']}    ${TIMEOUT}
    ${row_num}    Get Element Count    ${tbl_history['row_all_activity']}
    ${target_row}    Replace Variables    ${tbl_history['row_all_date']}

    ${dateandtime}    Get Text    ${target_row}
  
    ${days}    Get Substring    ${dateandtime}    0    2
    ${month}    Get Substring    ${dateandtime}    3    5
    ${year}    Get Substring    ${dateandtime}    6    10
    ${hour}    Get Substring    ${dateandtime}    11    13
    ${minute}    Get Substring    ${dateandtime}    14    17
    
    ${dateandtimeconvert}    Convert Date    ${dateandtime}    date_format=%d/%m/%Y %H:%M
    ${dateandtimeconvert}    Convert Date    ${dateandtimeconvert}    result_format=%d/%m/%Y %H:%M

    Should Be Equal As Strings    ${dateandtime}    ${dateandtimeconvert}

Verify invoice history detail activity not empty
    [Documentation]    Verify invoice detail history activity have value

    ${row_num}    Get Element Count    ${tbl_history['row_all_activity']}
    ${target_row}    Replace Variables    ${tbl_history['row_selected_activity']}

    Wait Until Element Is Visible     ${target_row}    ${TIMEOUT}
    ${actual_activity}    Get Text    ${target_row}

    Should Be Equal As Strings    ${actual_activity}    CNDN was submitted

Verify invoice history detail action by not empty
    [Documentation]    Verify invoice detail history action by havelue

    Wait Until Element Is Visible    ${tbl_history['row_all_activity']}    ${TIMEOUT}

    ${row_num}    Get Element Count    ${tbl_history['row_all_activity']}
    ${target_row}    Replace Variables    ${tbl_history['row_all_action_by']}

    ${actual_create_by}    Get Text    ${target_row}

    Should Be Equal As Strings    ${actual_create_by}    Supplier

Verify invoice history detail action by not empty on buyer
    [Documentation]    Verify invoice detail history action by havelue

    Wait Until Element Is Visible    ${tbl_history['row_all_activity']}    ${TIMEOUT} 
    
    ${row_num}    Get Element Count    ${tbl_history['row_all_activity']}
    ${target_row}    Replace Variables    ${tbl_history['row_all_action_by']}

    ${actual_create_by}    Get Text    ${target_row}

    Should Not Be Empty    ${actual_create_by}      

CNDN history header should be display correctly
    [Arguments]    ${cndn_number}    ${buyer_name}    ${create_date}
    [Documentation]    Verify invoice history header
    Verify cndn history header invoice number    ${cndn_number}
    Verify cndn history header buyername    ${buyer_name}
    Verify cndn history header create date    ${create_date}

Verify cndn history header invoice number
    [Arguments]    ${expected_cndn_number}

    Wait Until Element Is Visible    ${history_header['lbl_cndn_number']}    ${TIMEOUT}
    ${actual_cndn_number}    Get Text    ${history_header['lbl_cndn_number']}

    Should Be Equal As Strings    ${actual_cndn_number}    ${expected_cndn_number}


Verify cndn history header buyername 
    [Arguments]    ${expect_buyer_name}

    Wait Until Element Is Visible    ${history_header['lbl_buyer']}    ${TIMEOUT}
    ${actual_buyer_name}    Get Text    ${history_header['lbl_buyer']}

    Should Be Equal As Strings    ${actual_buyer_name}    ${expect_buyer_name}

Verify cndn history header create date 
    [Arguments]    ${expect_create_date}

    Wait Until Element Is Visible    ${history_header['lbl_create_date']}
    ${actual_create_date}    Get Text    ${history_header['lbl_create_date']} 

    Should Be Equal As Strings    ${actual_create_date}    ${expect_create_date} 

Get "CNDN History" header in modal
    [Documentation]    Get CNDN History Header from modal include CNDN Number, Buyer Name and Create Date
                ...    and return data as list variable

    @{list}    Create List
    Wait until loading complete
    Wait Until Element Is Visible    ${modal_history}
    ${cndn_number}    Get Text    ${history_header.lbl_cndn_number}
    ${buyer}    Get Text    ${history_header.lbl_buyer}
    ${create_date}   Get Text    ${history_header.lbl_create_date}
    Append To List    ${list}    ${cndn_number},${buyer},${create_date}

    [Return]    ${list}          

Get "CNDN History" detail in modal
    [Documentation]    Get CNDN History detail from modal include Date, Activity and Action By
               ...     and return data as list variable

    @{list}    Create List
    ${row_count}    Get Element Count    ${tbl_history_detail.row_all}
    :FOR    ${row_number}    IN RANGE    1    ${row_count}+1
        @{detail}    Create List

        ### Convert ${row_number} variable from Interger to String 
        ### because keyword Replace String not acceptable replace with integer 
        ${row_number}    Convert To String    ${row_number}

        ### Set locator to new variable
        ${date_locator}    Set Variable    ${tbl_history_detail.col_date}
        ${activity_locator}    Set Variable    ${tbl_history_detail.col_activity}
        ${actionby_locator}    Set Variable    ${tbl_history_detail.col_actionby}
 
        ### Replace text "REPLACE ME" with row number
        ${date_locator}    Replace String    ${date_locator}    REPLACE_ME    ${row_number}
        ${activity_locator}    Replace String    ${activity_locator}    REPLACE_ME    ${row_number}
        ${actionby_locator}    Replace String    ${actionby_locator}    REPLACE_ME    ${row_number}
         
        ### Get text from locator 
        ${date}    Get Text    ${date_locator} 
        ${activity}    Get Text    ${activity_locator}
        ${actionBy}    Get Text    ${actionby_locator}      
        
        Append To List    ${detail}    ${date}
        Append To List    ${detail}    ${activity}
        Append To List    ${detail}    ${actionby}

        Append To List    ${list}     ${detail}
    END     
    Log    ${list}
    [Return]    ${list}

Get "CNDN History" header from DB
    [Documentation]    Get CNDN History Header from database include date, buyer name and create date respectively
                ...    and return data as list variable 
    [Arguments]    ${invoice_num}
   
    @{list}    Create List
    ${qry_string}    Get "CNDN History" header    ${invoice_num}
    ${history_header}    eInvoice Execute SELECT query string    ${qry_string}
    Append To List    ${list}    ${history_header}[0][0],${history_header}[0][1],${history_header}[0][2]
    [Return]    ${list}    

Get "CNDN History" detail of supplier from DB
    [Documentation]    Get CNDN History detail from modal include Date, Activity and Action By respectively
                ...    and return data as list variable
    [Arguments]    ${invoice_num}

    @{list}    Create List
    ${qry_string}    Get "CNDN History" action detail on supplier    ${invoice_num}
    ${history_detail}    eInvoice Execute SELECT query string    ${qry_string}

    ${list_length}    Get Length    ${history_detail}
    :FOR   ${seq}    IN RANGE    0    ${list_length}
        @{detail}    Create List
        Append To List    ${detail}    ${history_detail}[${seq}][0]
        Append To List    ${detail}    ${history_detail}[${seq}][1]
        Append To List    ${detail}    ${history_detail}[${seq}][2]

        Append To List    ${list}    ${detail}
    END        
    [Return]    ${list}

Get "CNDN History" detail of buyer from DB
    [Documentation]    Get CNDN History detail from modal include Date, Activity and Action By respectively
                ...    and return data as list variable
    [Arguments]    ${invoice_num}
    
    @{list}    Create List
    ${qry_string}    Get "CNDN History" action detail on buyer    ${invoice_num}
    ${history_detail}    eInvoice Execute SELECT query string    ${qry_string}

    ${list_length}    Get Length    ${history_detail}
    :FOR   ${seq}    IN RANGE    0    ${list_length}
        @{detail}    Create List
        Append To List    ${detail}    ${history_detail}[${seq}][0]
        Append To List    ${detail}    ${history_detail}[${seq}][1]
        Append To List    ${detail}    ${history_detail}[${seq}][2]

        Append To List    ${list}    ${detail}
    END        
    [Return]    ${list}

    







