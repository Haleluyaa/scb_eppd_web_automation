*** Keywords ***
Get query string for SELECT 'UIItem' where with 'IsRequired','MPID' and 'ShowToSupplier' is True
    [Arguments]     ${BUYERMPID}
    ${query_string}    CATENATE
    ...    SELECT DisplayName , InputType
    ...    FROM UIItem
    ...    WHERE BuyerMpID = ${BUYERMPID} AND IsRequired = 'True' AND isShowToSupplier = 'True'
    ...    ORDER BY Sequence
    [Return]    ${query_string}   

Get query string for SELECT 'UIItem' where with 'IsRequired','MPID'
    [Arguments]     ${BUYERMPID}
    ${query_string}    CATENATE
    ...    SELECT DisplayName , InputType
    ...    FROM UIItem
    ...    WHERE BuyerMpID = ${BUYERMPID} AND IsRequired = 'True'
    ...    ORDER BY Sequence
    [Return]    ${query_string}     

Get query string for SELECT 'UIItem' where with 'MPID','Tab' and 'ShowToSupplier' is True
    [Arguments]     ${Tab}     ${BUYERMPID}
    ${query_string}    CATENATE
    ...    SELECT DisplayName , InputType , UiItemID
    ...    FROM UIItem
    ...    WHERE BuyerMpID = ${BUYERMPID} AND isShowToSupplier = 'True' AND Tabnumber = ${Tab}
    ...    ORDER BY Sequence
    [Return]    ${query_string}

Get query string for SELECT 'UIItem' where with 'MPID','Tab'
    [Arguments]     ${Tab}      ${BUYERMPID}
    ${query_string}    CATENATE
    ...    SELECT DisplayName , InputType , UiItemID
    ...    FROM UIItem
    ...    WHERE BuyerMpID = ${BUYERMPID} AND Tabnumber = ${Tab}
    ...    ORDER BY Sequence
    [Return]    ${query_string}  

Get query string for SELECT 'UIItem' where with 'MPID','Tab' and IsDisabled = 'False'
    [Arguments]     ${Tab}      ${BUYERMPID}
    ${query_string}    CATENATE
    ...    SELECT DisplayName , InputType , UiItemID
    ...    FROM UIItem
    ...    WHERE BuyerMpID = ${BUYERMPID} AND Tabnumber = ${Tab} and IsDisabled = 'False'
    ...    ORDER BY Sequence
    [Return]    ${query_string}   

Get query string for SELECT 'UIItem' where with 'MPID','Tab',IsDisabled = 'False' and 'ShowToSupplier' is True     
    [Arguments]     ${Tab}      ${BUYERMPID}
    ${query_string}    CATENATE
    ...    SELECT DisplayName , InputType , UiItemID
    ...    FROM UIItem
    ...    WHERE BuyerMpID = ${BUYERMPID} AND Tabnumber = ${Tab} and IsDisabled = 'False' AND isShowToSupplier = 'True'
    ...    ORDER BY Sequence
    [Return]    ${query_string}          

Get query string for SELECT 'UIItem' where with 'MPID' and 'ShowToSupplier' is True and 'InputType' is dropdown
    [Arguments]     ${BUYERMPID}
    ${query_string}    CATENATE
    ...    SELECT DisplayName , InputType
    ...    FROM UIItem
    ...    WHERE BuyerMpID = ${BUYERMPID} AND isShowToSupplier = 'True' AND InputType = 'dropdown'
    ...    ORDER BY Sequence
    [Return]    ${query_string}     