***Keywords***
########### Response Code ##############
Response Should Be 200 OK
    [Arguments]    ${response}
    [Documentation]    Expect HTTP 200 [OK]
    Should Be Equal As Integers    ${response.status_code}    200

Response Should Be 201 Created
    [Arguments]    ${response}
    [Documentation]    Expect HTTP 201 [Created]
    Should Be Equal As Integers    ${response.status_code}    201

Response Should Be 204 No Content
    [Arguments]    ${response}
    [Documentation]    Expect HTTP 202 [No Content]
    Should Be Equal As Integers    ${response.status_code}    204

Response Should Be 400 Bad Request
    [Arguments]    ${response}
    [Documentation]    Expect HTTP 400 [Bad Request]
    Should Be Equal As Integers    ${response.status_code}    400

Response Should Be 401 Unauthorized
    [Arguments]    ${response}
    [Documentation]    Expect HTTP 401 [Unauthorized]
    Should Be Equal As Integers    ${response.status_code}    401

Response Should Be 402 Payment Required
    [Arguments]    ${response}
    [Documentation]    Expect HTTP 402 [Payment Required]
    Should Be Equal As Integers    ${response.status_code}    402

Response Should Be 404 Not Found
    [Arguments]    ${response}
    [Documentation]    Expect HTTP 404 [Not Found]
    Should Be Equal As Integers    ${response.status_code}    404

Response Should Be 500 Internal Server Error
    [Arguments]    ${response}
    [Documentation]    Expect HTTP 500 [Internal Server Error]
    Should Be Equal As Integers    ${response.status_code}    500

############## Action keywords ##############
Get Request API
    [Arguments]    ${api_url}    ${params}
    [Documentation]    Ger Request via API
    Create Session    Get API    ${EINVOICE_URL_API}
    ${resp}=    Get Request    Get API    ${api_url}    params=${params}
    [Return]    ${resp}

Get GUID From SWW via API
    #Hard code for user:metro-admin supplier web work staging
    #Password info:   Username = TT00100 :::    VFQwMDEwMDpXVmRLYWsxVVNYbzRPVGcwTkRBeE0yUmpOV1kxTURZME5UVmxPR1JrTTJFME9HVTFZalJoT1E9PQ==
    #                 Username = metro-admin :::   bWV0cm8tYWRtaW46V1ZkS2FrMVVTWG80T1RnME5EQXhNMlJqTldZMU1EWTBOVFZsT0dSa00yRTBPR1UxWWpSaE9RPT0=
    ${headers}    Create Dictionary    Content-Type=application/json
    ...    Basic=bWV0cm8tYWRtaW46NFlwZlhnaDMwdnFJV3JXZTcreVFIT1gvV2ZEYkcydlk0ZzZxTFFnYjliWT0
    ...    PublicKey=89844013dc5f506455e8dd3a48e5b4a9
    ...    User-Agent=WebApiForPortal
    ...    AuthInfo=bWV0cm8tYWRtaW46NFlwZlhnaDMwdnFJV3JXZTcreVFIT1gvV2ZEYkcydlk0ZzZxTFFnYjliWT0=
    ...    Userpassword=bWV0cm8tYWRtaW46V1ZkS2FrMVVTWG80T1RnME5EQXhNMlJqTldZMU1EWTBOVFZsT0dSa00yRTBPR1UxWWpSaE9RPT0=
    ...    Accept=application/json
    Create Session    generate_guid    ${SWW_API_AUTHEN}    headers=${headers}
    ${resp}    Get Request    generate_guid    /

    ${guid}=    Get Regexp Matches    ${resp.text}    "GUID":"(.+?)"    1

    ${guid}=    Get From List    ${guid}    0 
    [return]    ${guid}

Get GUID from SWW via API for user TT00100 
    #Hard code for user : TT00100 supplier web work staging   
    #Password info:   Username = TT00100 :::    VFQwMDEwMDpXVmRLYWsxVVNYbzRPVGcwTkRBeE0yUmpOV1kxTURZME5UVmxPR1JrTTJFME9HVTFZalJoT1E9PQ==
    #                 Username = metro-admin :::   bWV0cm8tYWRtaW46V1ZkS2FrMVVTWG80T1RnME5EQXhNMlJqTldZMU1EWTBOVFZsT0dSa00yRTBPR1UxWWpSaE9RPT0=
    ${headers}    Create Dictionary    Content-Type=application/json
    ...    Basic=bWV0cm8tYWRtaW46NFlwZlhnaDMwdnFJV3JXZTcreVFIT1gvV2ZEYkcydlk0ZzZxTFFnYjliWT0
    ...    PublicKey=89844013dc5f506455e8dd3a48e5b4a9
    ...    User-Agent=WebApiForPortal
    ...    AuthInfo=bWV0cm8tYWRtaW46NFlwZlhnaDMwdnFJV3JXZTcreVFIT1gvV2ZEYkcydlk0ZzZxTFFnYjliWT0=
    ...    Userpassword=VFQwMDEwMDpXVmRLYWsxVVNYbzRPVGcwTkRBeE0yUmpOV1kxTURZME5UVmxPR1JrTTJFME9HVTFZalJoT1E9PQ==
    ...    Accept=application/json
    Create Session    generate_guid    ${SWW_API_AUTHEN}    headers=${headers}
    ${resp}    Get Request    generate_guid    /


    ${guid}=    Get Regexp Matches    ${resp.text}    "GUID":"(.+?)"    1

    ${guid}=    Get From List    ${guid}    0 
    [return]    ${guid}

Get Cookie Value Of Invoice Supplier
    [Documentation]    Keywords for get cookie from supplier invoice
    ${supplier_auth}=    Get Cookie    supplier_auth
    ${application_type}=    Set Variable    EInvoiceSupplier
    ${application_lang}=    Set Variable    en
    ${supplier_authentication}=    Set Variable    ${supplier_auth.value}
    ${application_header}=    Create Dictionary    Content-Type=application/json
    ...                                userGuid=820b5a8dc1ec4e6eb8f3b5bbdfe09067
    ...                                Cookie=app_type=${application_type};supplier_lang=${application_lang};supplier_auth=${supplier_authentication}
    [Return]    ${application_header}

Set api header content type multipart/form-data for invoice supplier   
    [Documentation]    Get cookie and set to api headers that content-type is multipart/form-data  

    ${supplier_auth}=    Get Cookie    supplier_auth
    ${application_type}=    Set Variable    EInvoiceSupplier
    ${application_lang}=    Set Variable    en
    ${supplier_authentication}=    Set Variable    ${supplier_auth.value}
    &{application_header}=    Create Dictionary    userGuid=1f96463a74da442b910db22d482ed84f
    ...                                Cookie=app_type=${application_type};supplier_lang=${application_lang};supplier_auth=${supplier_authentication}

    [Return]    &{application_header}

Delete invoice session
    [Arguments]    ${gr_data}={"grIdList": ${gr_list}}
    ${grlist_data}=    Set Variable    {"grIdList": ${gr_list}}
    ${supplier_auth_value}=    Get Cookie    supplier_auth
    ${app_type}=    Set Variable    EInvoiceSupplier
    ${supplier_lang}=    Set Variable    en
    ${supplier_auth}=    Set Variable    ${supplier_auth_value.value}

    ${headers}    Create Dictionary    Content-Type=application/json
           ...    userGuid=820b5a8dc1ec4e6eb8f3b5bbdfe09067
           ...    appType=EInvoiceSupplier  
           ...    Cookie=app_type=${app_type};supplier_lang=${supplier_lang};supplier_auth=${supplier_auth_value.value}

    Create Session    delete_create_invoice_session    ${EINVOICE_URL_WEB}   headers=${headers}     max_retries=5    backoff_factor=1    

    ${resp}=    Post Request    delete_create_invoice_session    /api/invoices/deleteInvoiceSession?userGuid=820b5a8dc1ec4e6eb8f3b5bbdfe09067&appType=EInvoiceSupplier    data=${grlist_data}
   

Get Buyer Authentication Value Of Invoice Buyer
    [Documentation]    Keywords for get cookie from buyer invoice
    ${buyer_auth}=    Get Cookie    buyer_auth
    ${buyer_authentication}=    Set Variable    ${buyer_auth.value}
    [Return]    ${buyer_authentication}     

#Get Request API
#    [Arguments]    ${api_url}    ${params}
#    [Documentation]    Ger Request via API
#    Create Session    Get API    ${EINVOICE_URL_API}
#    ${resp}=    Get Request    Get API    ${api_url}    params=${params}
#    [Return]    ${resp}       

Prepare Json Keyword
    [Arguments]    @{args}
    ${req_dict}    Create Dictionary
    :FOR     ${pair}    IN     @{args}
    \     ${key}    ${value}=     Split String    ${pair}    =
    \     Set To Dictionary    ${req_dict}    ${key}=${value}
    ${req_json}    Json.Dumps    ${req_dict}
    [Return]    ${req_json}    

Get json value in file and convert to object
    [Arguments]    ${response}    ${json_path}
    ${value}=    Get Json Value    ${response}    ${json_path}
    ${value}=    Parse Json    ${value}
    [Return]    ${value} 

Load dictionary to json format
    [Arguments]    ${source_dictionary}
    ${json}    evaluate    json.dumps(${source_dictionary})    json
    [Return]    ${json}  

Post request data for supplier user TT00100
    [Arguments]    ${endpoint}  ${uri}  ${request_body}

    #Relog-in SWW via api then go to einvoice supplier with supplier guid for user TT00100
    
    ${request_header}    Get supplier cookie  
    #${request_header}  Create Dictionary  Content-Type=application/json
    #                   ...  Accept-Encoding=UTF-8

    Create Session  request_session  ${endpoint}  headers=${request_header}  max_retries=5  backoff_factor=1
    ${response}  Post Request  request_session  ${uri}  data=${request_body}
    [Return]    ${response}      

Put request data
    [Arguments]    ${endpoint}  ${uri}  ${request_body}
    [Documentation]    Put request api without authentication token

    ${request_header}  Create Dictionary  Content-Type=application/json
                       ...  Accept-Encoding=UTF-8

    Create Session  put_request  ${endpoint}  headers=${request_header}  max_retries=5  backoff_factor=1
    ${response}  Put Request  request_session  ${uri}  data=${request_body}
    [Return]    ${response}


Post request data   
    [Arguments]    ${endpoint}    ${uri}    ${content}
    [Documentation]    Post request api without authentication token

    ${headers}    Create Dictionary    Content-Type=application/json
                  ...    Accept-Encoding=UTF-8
                  
    Create Session    post_request    ${endpoint}    headers=${headers}    max_retries=5    backoff_factor=1
    #debug
    ${response}    Post Request    post_request    ${uri}    data=${content}

    [Return]    ${response}               


Delete request data
    [Arguments]    ${endpoint}    ${uri}    ${condition}
    [Documentation]    Delete request api without authentication token

    ${headers}    Create Dictionary    Content-Type=appliaction/json
                ...                    Accept-Encoding=UTF-8
                
    Create Session    delete_request    ${endpoint}    max_retries=5    backoff_factor=1    headers=${headers}    
    ${response}    Delete Request    delete_request    ${uri}/${condition}     

    [Return]    ${response}  

Get request data with param
    [Arguments]    ${endpoint}    ${uri}    ${params}  

    ${headers}    Create Dictionary    Accept-Encoding=UTF-8 

    Create Session    get_request    ${endpoint}    max_retries=5    backoff_factor=1    headers=${headers}
    ${response}    Get Request    get_request    ${uri}    params=${params}

    [Return]    ${response}     

Get request data with param and header torken
    [Arguments]    ${endpoint}    ${uri}    ${params}

    ${request_header}    Get supplier cookie    
    Create Session    get_request    ${endpoint}    max_retries=5    backoff_factor=1    headers=${request_header}    
    ${response}    Get Request    get_request    ${uri}    params=${params} 

    [Return]    ${response}          




