*** Keywords ***
Replace Variables in YAML file
    [Arguments]   ${val}
    ${val_type}=  Evaluate    type($val).__name__
    ${ret}=    Run Keyword If  '${val_type}' == 'list'       Loop and replace variable in list     ${val}
              ...  ELSE IF    '${val_type}' == 'DotDict'    Loop and replace variable in dict     ${val}
              ...  ELSE   Replace Variables    ${val}
    [Return]  ${ret}

Loop and replace variable in list
    [Arguments]   ${val}
    ${temp_list}=  Convert To List    ${EMPTY}
    :FOR  ${item}  IN  @{val}
    \   ${replaced_item}=    Replace Variables    ${item}
    \   Append To List    ${temp_list}        ${replaced_item}
    [Return]    ${temp_list}

Loop and replace variable in dict
    [Arguments]   ${val}
    ${temp_dict}=  Convert To Dictionary	    ${EMPTY}
    :FOR  ${key}  IN  @{val.keys()}
    \   ${replaced_item}=    Replace Variables    ${val["${key}"]}
    \   Set To Dictionary    ${temp_dict}        ${key}=${replaced_item}
    [Return]    ${temp_dict}

Update dictionary value
    [Arguments]    ${source_dict}    ${replace_dict_key}    ${replace_dict_val}

    :FOR    ${key}    IN    @{replace_dict_key}  
        Set To Dictionary    ${source_dict}    ${key}     ${replace_dict_val}[${key}] 
    END
    [Return]    ${source_dict}

Get key from dictionary
    [Arguments]    ${source_dict}

    @{key}    Get Dictionary Keys    ${source_dict}
    [Return]    ${key}

Load yaml template to dictionary
    [Arguments]    ${yaml_path}
    [Documentation]    Load YAML and convert to dictionary
                ...    Argument can be variable or file path
    ${yaml}    Get File    ${yaml_path}
    ${yaml_dict}    yaml.safe_load    ${yaml}  

    [Return]    ${yaml_dict}   
