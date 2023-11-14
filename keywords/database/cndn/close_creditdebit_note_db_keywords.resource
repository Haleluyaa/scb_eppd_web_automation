*** Keywords ***
Select query get true payment location
    [Documentation]    Initial query string for get Payment Location from database

    ${query_string}    CATENATE
    ...    SELECT Location
    ...    FROM PaymentLocation
    ...    WHERE BuyerMpID = '19553eee-b30a-46dd-b978-d75f807295ce'
    ...    ORDER BY Location
    [Return]    ${query_string}

Get query string for SELECT 'CNDN_UIItemClose' where with 'IsRequired'
    ${query_string}    CATENATE
    ...    SELECT DisplayName , InputType
    ...    FROM CNDN_UIItemClose
    ...    WHERE BuyerMpID = '19553eee-b30a-46dd-b978-d75f807295ce' AND IsRequired = 'True'
    ...    ORDER BY Sequence
    [Return]    ${query_string}   

Get query string for SELECT 'CNDN_UIItemClose'
    ${query_string}    CATENATE
    ...    SELECT DisplayName
    ...    FROM CNDN_UIItemClose
    ...    WHERE BuyerMpID = '19553eee-b30a-46dd-b978-d75f807295ce'
    ...    ORDER BY Sequence
    [Return]    ${query_string} 

Get query string for SELECT 'CNDN_UIItemLookup'
    ${query_string}    CATENATE
    ...    SELECT C.Sequence,V.Value
    ...    FROM 
    ...    ( SELECT TOP 1 UIItemID,BuyerMpID,Sequence 
    ...    FROM CNDN_UIItemClose 
    ...    WHERE BuyerMpID = '19553eee-b30a-46dd-b978-d75f807295ce' 
    ...    AND InputType = 'dropdown'
    ...    ) C
    ...    JOIN CNDN_UIItemLookup V on C.UIItemID = V.UIItemID 
    ...    AND C.BuyerMpID = V.BuyerMpID
    [Return]    ${query_string}             