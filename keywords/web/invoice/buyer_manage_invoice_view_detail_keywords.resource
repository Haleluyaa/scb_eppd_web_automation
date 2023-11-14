*** Settings ***
Variables    ../../../resources/locators/common/common_locators.yaml
Variables    ../../../resources/locators/invoice/buyer_manage_invoice_view_detail_locator.yaml

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
User buyer click button history
    Click "History" button 

Prepare validate PO Number and GR Number on row number "${row_num}"
    Get PO Number    ${row_num}
    Get GR Number    ${row_num}

Click on PO Number at the first row
    Click on PO Number at the selected row on detail page

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
Click on PO Number at the selected row on detail page
    [Arguments]    ${row_num}=1  

    ${target_row}    Replace Variables    ${tbl_nested_inv1['row_selected']}
    
    Wait until loading complete
    Wait Until Element Is Visible    ${target_row}    ${TIMEOUT} 
    Click Element    ${target_row}

Get PO Number
    [Arguments]    ${row_num}

    ${target_cel}    Replace Variables    ${tbl_nested_inv1['col_po_no']}

    Wait Until Element Is Visible    ${target_cel}    ${TIMEOUT}
    ${TV_PONumber_ViewGR}    Get Text    ${target_cel} 
    Set Test Variable        ${TV_PONumber_ViewGR} 

Get GR Number
    [Arguments]    ${row_num}

    ${target_cel}    Replace Variables    ${tbl_nested_inv1['col_gr_no']}

    Wait Until Element Is Visible    ${target_cel}    ${TIMEOUT}
    ${TV_GRNumber_ViewGR}    Get Text    ${target_cel} 
    Set Test Variable        ${TV_GRNumber_ViewGR}   

Loop for select status and search invoice by type then view detail and verify action 
    [Arguments]    ${site_code}    ${jsonfile}    ${users}    ${user_index}   
    ${inv_type_obj}=    Get Json Value in file And Convert To Object    ${jsonfile}     /${site_code}/user/${user_index}/invoice_type
    ${inv_type_num}=    Get Length    ${inv_type_obj}
    :FOR    ${i}    IN RANGE    0    ${inv_type_num} 
    \   ${inv_type}   Get Json Value    ${jsonfile}    /${site_code}/user/${user_index}/invoice_type/${i}/id
    \   Set Test Variable       ${inv_type}
    \   Loop for select status by statusid then click view detail     ${i}     ${site_code}    ${jsonfile}    ${user_index}

Loop for select status by statusid then click view detail
    [Arguments]    ${type_id}     ${site_code}    ${jsonfile}    ${user_index}
    ${inv_status_obj}=    Get Json Value in file And Convert To Object    ${jsonfile}        /${site_code}/user/${user_index}/invoice_type/${type_id}/data
    ${inv_status_num}=    Get Length    ${inv_status_obj}
    :FOR    ${i}    IN RANGE    0    ${inv_status_num}
    \   ${inv_status}   Get Json Value    ${jsonfile}    /${site_code}/user/${user_index}/invoice_type/${type_id}/data/${i}/invoice_status 
    \   ${inv_number}   Get Json Value    ${jsonfile}    /${site_code}/user/${user_index}/invoice_type/${type_id}/data/${i}/invoice_number
    # \   ${inv_number}=       Evaluate     ${inv_number}.replace('"','') 
    \   ${inv_number}=       Replace String     ${inv_number}    "    ${EMPTY}
    \   ${inv_action_obj}   Get Json Value in file And Convert To Object    ${jsonfile}    /${site_code}/user/${user_index}/invoice_type/${type_id}/data/${i}/action 
    \   ${user_action} =	Get Dictionary Keys     ${inv_action_obj}  
    \   Set Test Variable       ${inv_status}
    \   Set Test Variable       ${inv_number}
    \   Select invoice status on dropdown  ${inv_status}
    \   Search invoice by search keyword on manage invoice page     ${inv_number}
    \   Verify action displayed correctly in case search result found in view detail page   ${user_action}

Verify action displayed correctly in case search result found in view detail page
    [Arguments]     ${user_action} 
    
    ${Hasdata}=     Run Keyword And Return Status    Wait Until Element Is Visible   ${tbl_manage_invoice_count_result}
    Run keyword if      '${Hasdata}' == 'True'     
    ...     Run Keywords
    ...     Click view detail first result      
    ...     AND     Verify action data on header view detail by compare with action list     ${user_action} 

Verify action data on header view detail by compare with action list
    [Arguments]     ${expected_list} 
    ${Expected_count}   Get Length   ${expected_list}
    ${count}=  Get element count   //div[@class="popup-top-action hide-sm"]/a
    Should be equal     ${count}    ${Expected_count}   type:${inv_type}-invnum:${inv_number}-status:${inv_status} Action number expected not equal to actual
    :FOR     ${i}    IN RANGE    1    ${count} + 1    
    \   ${action_item}      Get text    //div[@class="popup-top-action hide-sm"]/a[${i}]
    \   List Should Contain Value  ${expected_list}  ${action_item}     type:${inv_type}-invnum:${inv_number}:${inv_status}-status: Action menu wrong    
    Close view detail page

Click view detail first result
    Wait Until Element Is Visible    ${td_first_buyer_invoice_number}    ${TIMEOUT}
    click element   ${td_first_buyer_invoice_number}

Close view detail page
    Wait Until Element Is Visible    ${btn_close_view_detail}    ${TIMEOUT}
    click element   ${btn_close_view_detail}

Click "History" button 
    [Documentation]    Click history button on view invoice detail page   
    
    Wait until loading complete
    Wait Until Element Is Visible    ${btn_action.history}    ${TIMEOUT} 
    Click Element     ${btn_action.history} 