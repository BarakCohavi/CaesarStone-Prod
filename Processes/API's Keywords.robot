*** Settings ***
Library    RequestsLibrary
Library    JSONLibrary
Library    Collections
#Library    ../Processes/functions.py
Library    SeleniumLibrary
Resource    ../Processes/Login Retailer.robot
Resource    ../Processes/New Job.robot
Resource    ../Processes/Pending Fabricator Review & Acceptance.robot


*** Keywords ***


Maybe Invalid Dates
    sleep    2s
    ${CountProducts1}=    get element count    xpath://*[contains(text(),"invalid data")]
    capture page screenshot

    IF    ${CountProducts1}>0
            click element    xpath://*[@class="slds-button slds-button--neutral pageErrorIconButton uiButton"]
             ${Measurement Date Preference}   Get Current Date    result_format=%m/%d/%Y
             click link    xpath://span[text()="Measurement Date Preference"]/parent::label/following-sibling::div/a[@class="datePicker-openIcon display"]
             Wait Until Page Contains Element    xpath://*[text()="Installation Date Preference"]/parent::label/following-sibling::div/input    60s
             input text    xpath://*[text()="Measurement Date Preference"]/parent::label/following-sibling::div/input    ${Measurement Date Preference}


             ${Installation Date Preference}   Get Current Date    result_format=%m/%d/%Y

             #click element    xpath://span[text()="Installation Time Preference"]/parent::span/following-sibling::div/div[@class="uiPopupTrigger"]/div/div/a
             Wait Until Page Contains Element    xpath://*[text()="Installation Date Preference"]/parent::label/following-sibling::div/input    60s
             input text    xpath://*[text()="Installation Date Preference"]/parent::label/following-sibling::div/input    ${Installation Date Preference}
             sleep    2s
             click button    Save
             #click button    Mark Status as Complete

    END


API - Validate Acceptance Fabricator API
    [Arguments]   ${access_token}    ${token_type}    ${JobId}
    ${header}    set variable    ${token_type} ${access_token}
    ${headers}   create dictionary    Content-Type=application/json    Authorization=${header}
    ${AppURL}   set variable    https://caesarstone--cspartial.my.salesforce.com
    #${HEADERS}  set variable    application/x-www-form-urlencoded
    &{body}   create dictionary   FabricatorApprovalForThisJob__c=Yes
    create session    myssion6    ${AppURL}
    ${Response}=    get on session    myssion6    url=/services/data/v52.0/query/?q=SELECT+FIELDS(ALL)+from+Job__c+where+Id+=+'${JobId}'+LIMIT+200     headers=${headers}
    #The request has been successfully processed and the resource has been created.
    should be equal as integers    ${Response.status_code}    200
    ${jsonres}=    set variable    ${Response.json()}
    ${JOBName}=    get from dictionary     ${jsonres}    records
    ${FABAnsw}=    set variable     ${jsonres['records'][0]['Status__c']}
    #log to console     4
    #log to console     ${jsonres}
    #log to console     ${FABAnsw}
    [Return]     ${FABAnsw}


API - login as retailer
    sleep     5s
    ${csConnectTest_Owner_aus1 page} =        ReadInput  2  21
    ${RetailerAccount}=    ReadInput  2    19
    Go To    ${csConnectTest_Owner_aus1 page}
    Wait Until Page Contains Element   xpath://*[text()="${RetailerAccount}"]    60s
    Wait Until Page Contains Element    ${ARROW>Show more actions}

ay kalam
    [Arguments]    ${JobName}
    wait until page contains element    xpath://*[@aria-label="Search"]   60s
    click element    xpath://*[@aria-label="Search"]

    wait until page contains element    xpath://*[@type="search" and @placeholder="Search..."]    60s
    input text   //*[@type="search" and @placeholder="Search..."]    ${JobName}
    wait until page contains element    xpath://span/mark[text()="${JobName}"]   60s
    click element    xpath://span/mark[text()="${JobName}"]
    #Common.Search Job By Job Name    ${JobName}
    #Choose Measurement && Installation Time
    Wait Until Page Contains Element    xpath://*[text()="Mark Status as Complete"]    60s
    sleep    3s
    click button    xpath://span[text()="Mark Status as Complete"]/parent::button

    Wait Until Page Contains Element    xpath://*[text()="Choose A Fabricator"]    60s
    Wait Until Page Contains Element    xpath://*[text()="Job Number"]    60s
    scroll element into view    xpath://*[@title="Edit Measurement Date Preference"]/lightning-primitive-icon
    Wait Until Element Is Visible    xpath://*[@title="Edit Measurement Date Preference"]/lightning-primitive-icon
    click element    xpath://*[@title="Edit Measurement Date Preference"]/lightning-primitive-icon
    Wait Until Page Contains Element    xpath://*[text()="Job Number"]    60s

    ${Measurement Date Preference}   Get Current Date    result_format=%m/%d/%Y
    Choose Fabricator
    click link    xpath://span[text()="Measurement Date Preference"]/parent::label/following-sibling::div/a[@class="datePicker-openIcon display"]
    Wait Until Page Contains Element    xpath://*[text()="Installation Date Preference"]/parent::label/following-sibling::div/input    60s
    input text    xpath://*[text()="Measurement Date Preference"]/parent::label/following-sibling::div/input    ${Measurement Date Preference}
    Wait Until Element Is Visible     xpath://span[text()="Measurement Time Preference"]/parent::span/following-sibling::div/div[@class="uiPopupTrigger"]/div/div/a
    click element    xpath://span[text()="Measurement Time Preference"]/parent::span/following-sibling::div/div[@class="uiPopupTrigger"]/div/div/a
    CLICK ELEMENT    xpath://*[text()="07:00 - 12:00"]
    ${Installation Date Preference}   Get Current Date    result_format=%m/%d/%Y
    click element    xpath://span[text()="Installation Time Preference"]/parent::span/following-sibling::div/div[@class="uiPopupTrigger"]/div/div/a
    Wait Until Page Contains Element    xpath://*[text()="Installation Date Preference"]/parent::label/following-sibling::div/input    60s
    input text    xpath://*[text()="Installation Date Preference"]/parent::label/following-sibling::div/input    ${Installation Date Preference}
    click element    xpath://*[text()="07:00 - 12:00" and @aria-checked="false"]
    click button    Save
    click button    Mark Status as Complete


Approve By notification
    Wait Until Page Contains Element    xpath://*[@class="slds-button slds-no-space slds-m-bottom_xx-small"]    60s
    wait until element is enabled    xpath://*[@class="slds-button slds-no-space slds-m-bottom_xx-small"]    60s
    wait until element is visible    xpath://*[@class="slds-button slds-no-space slds-m-bottom_xx-small"]    60s
    wait until element is enabled    xpath:(//*[@data-key="search"])[1]    60s
    click element    xpath://*[@class="slds-button__icon slds-global-header__icon slds-icon-utility-notification slds-icon_container forceIcon"]
    wait until page contains element    xpath://*[contains(text(),"${JobName}")]    30s
    click element    xpath://*[contains(text(),"${JobName}")]
    wait until page contains element    xpath://*[text()="Approve"]    30s
    click element    xpath://*[text()="Approve"]
    wait until page contains element    xpath://*[@class=" label bBody" and text()="Approve"]    30s
    click element    xpath://*[@class=" label bBody" and text()="Approve"]

API - Change Measurement && Installation Time
    wait until page contains element    xpath://*[@aria-label="Path Header"]/ul/li[2]/a    60s
    click element    xpath://*[@aria-label="Path Header"]/ul/li[2]/a
    Wait Until Page Contains Element    xpath://*[text()="Choose A Fabricator"]    60s
    Wait Until Page Contains Element    xpath://*[text()="Job Number"]    60s
    scroll element into view    xpath://*[text()="Job Number"]
    Wait Until Element Is Visible    xpath://*[@title="Edit Measurement Date Preference"]/lightning-primitive-icon
    click element    xpath://*[@title="Edit Measurement Date Preference"]/lightning-primitive-icon
    Wait Until Page Contains Element    xpath://*[text()="Job Number"]    60s

    ${Measurement Date Preference}   Get Current Date    result_format=%d/%m/%Y
    #${Measurement Date Preference}   add time to date    ${Measurement Date Preference}    10 days    result_format=%d/%m/%Y
    #API - Choose Fabricator
    wait until page contains element    xpath://*[text()="Choose A Fabricator"]/parent::label/following-sibling::div/div/div/div/input    60s
    ${CountProducts}=    get element count    xpath://*[@class="deleteIcon"]
    IF    ${CountProducts}==1
    click element    xpath://*[@class="deleteIcon"]
    END
    click element    xpath://*[text()="Choose A Fabricator"]/parent::label/following-sibling::div/div/div/div/input

    ${fabricator}    ReadInput  2   23
    input text    //*[text()="Choose A Fabricator"]/parent::label/following-sibling::div/div/div/div/input    ${fabricator}
    Wait Until Page Contains Element    xpath://*[@title="${fabricator}"]    60s
    sleep    1s
    click element    xpath://*[@title="${fabricator}"]
    sleep    0.5s

    click link    xpath://span[text()="Measurement Date Preference"]/parent::label/following-sibling::div/a[@class="datePicker-openIcon display"]
    Wait Until Page Contains Element    xpath://*[text()="Installation Date Preference"]/parent::label/following-sibling::div/input    60s
    input text    xpath://*[text()="Measurement Date Preference"]/parent::label/following-sibling::div/input    ${Measurement Date Preference}
    Wait Until Element Is Visible     xpath://span[text()="Measurement Time Preference"]/parent::span/following-sibling::div/div[@class="uiPopupTrigger"]/div/div/a
    click element    xpath://span[text()="Measurement Time Preference"]/parent::span/following-sibling::div/div[@class="uiPopupTrigger"]/div/div/a
    CLICK ELEMENT    xpath://*[text()="12:00 - 16:00"]
    ${Installation Date Preference}   Get Current Date
    ${Installation}   add time to date    ${Installation Date Preference}    10 days    result_format=%d/%m/%Y

    click element    xpath://span[text()="Installation Time Preference"]/parent::span/following-sibling::div/div[@class="uiPopupTrigger"]/div/div/a
    Wait Until Page Contains Element    xpath://*[text()="Installation Date Preference"]/parent::label/following-sibling::div/input    60s
    input text    xpath://*[text()="Installation Date Preference"]/parent::label/following-sibling::div/input    ${Installation}
    click element    xpath://*[text()="12:00 - 16:00" and @aria-checked="false"]
    capture page screenshot
    click button    Save

    Maybe Invalid Dates
    #${CountProducts}=    get element count    xpath://*[text()="Mark as Current Status"]
    #IF    ${CountProducts}>=1
        #click button    Mark as Current Status
    #END






AUTHENTICATION
    ${AppURL}   set variable    https://test.salesforce.com
    ${HEADERS}  set variable    application/x-www-form-urlencoded
    ${body}   create dictionary    grant_type=password    client_id=3MVG9T992fY2Y4vvJxJ55IpDkio0xMNCUY_LWU4Mg4skz_90qwAiTjXF6h17c9xSdQfgzEwz94FqRcrbylyrf   client_secret=05BA1D9BB0922A49E4C0D83DFC8289C7BED0B5000057EF67AFCEABE8B32CDBB4    username=caesarstone.testing@gmail.com.admin    password=qualitest1234iPf3i6Dxiy9OwypTL4jbakNdo
    create session    myssion    ${AppURL}
    ${Response}=    post on session    myssion     /services/oauth2/token    data=${body}
    should be equal as integers    ${Response.status_code}    200
    ${jsonres}=    set variable    ${Response.json()}
    ${access_token}=    get from dictionary     ${jsonres}    access_token
    ${token_type}=    get from dictionary     ${jsonres}    token_type
    #log to console     ${jsonres}
    #log to console     11111111111
    #log to console     ${access_token}
    [Return]    ${access_token}    ${token_type}


API - Choose Measurement && Installation Time
    Wait Until Page Contains Element    xpath://*[text()="Choose A Fabricator"]    60s
    Wait Until Page Contains Element    xpath://*[text()="Job Number"]    60s
    scroll element into view    xpath://*[text()="Job Number"]
    Wait Until Element Is Visible    xpath://*[@title="Edit Measurement Date Preference"]/lightning-primitive-icon
    click element    xpath://*[@title="Edit Measurement Date Preference"]/lightning-primitive-icon
    Wait Until Page Contains Element    xpath://*[text()="Job Number"]    60s

    ${Measurement Date Preference}   Get Current Date    result_format=%d/%m/%Y

    #API - Choose Fabricator
    wait until page contains element    xpath://*[text()="Choose A Fabricator"]/parent::label/following-sibling::div/div/div/div/input    60s
    ${CountProducts}=    get element count    xpath://*[@class="deleteIcon"]
    IF    ${CountProducts}==1
    click element    xpath://*[@class="deleteIcon"]
    END
    click element    xpath://*[text()="Choose A Fabricator"]/parent::label/following-sibling::div/div/div/div/input

    ${fabricator}    ReadInput  2   23
    input text    //*[text()="Choose A Fabricator"]/parent::label/following-sibling::div/div/div/div/input    ${fabricator}
    Wait Until Page Contains Element    xpath://*[@title="${fabricator}"]    60s
    click element    xpath://*[@title="${fabricator}"]
    sleep    0.5s

    click link    xpath://span[text()="Measurement Date Preference"]/parent::label/following-sibling::div/a[@class="datePicker-openIcon display"]
    Wait Until Page Contains Element    xpath://*[text()="Installation Date Preference"]/parent::label/following-sibling::div/input    60s
    input text    xpath://*[text()="Measurement Date Preference"]/parent::label/following-sibling::div/input    ${Measurement Date Preference}
    Wait Until Element Is Visible     xpath://span[text()="Measurement Time Preference"]/parent::span/following-sibling::div/div[@class="uiPopupTrigger"]/div/div/a
    click element    xpath://span[text()="Measurement Time Preference"]/parent::span/following-sibling::div/div[@class="uiPopupTrigger"]/div/div/a
    CLICK ELEMENT    xpath://*[text()="07:00 - 12:00"]
    ${Installation Date Preference}   Get Current Date    result_format=%d/%m/%Y

    click element    xpath://span[text()="Installation Time Preference"]/parent::span/following-sibling::div/div[@class="uiPopupTrigger"]/div/div/a
    Wait Until Page Contains Element    xpath://*[text()="Installation Date Preference"]/parent::label/following-sibling::div/input    60s
    input text    xpath://*[text()="Installation Date Preference"]/parent::label/following-sibling::div/input    ${Installation Date Preference}
    click element    xpath://*[text()="07:00 - 12:00" and @aria-checked="false"]
    capture page screenshot
    click button    Save
    click button    Mark Status as Complete
    sleep    4s
    Maybe Invalid Dates





API - log in as a fabricator
    ${cs connect_aus_fab1 page11}=    ReadInput  2  24
    Common.Navigating To "Experience As User"    ${cs connect_aus_fab1 page11}
    SLEEP    2s

CREATE NEW JOB
    [Arguments]   ${access_token}    ${token_type}

    ${header}    set variable    ${token_type} ${access_token}
    ${headers}   create dictionary    Content-Type=application/json    Authorization=${header}
    ${AppURL}   set variable    https://caesarstone--cspartial.my.salesforce.com
    #${HEADERS}  set variable    application/x-www-form-urlencoded
    &{body}   create dictionary    Status__c=Quote    Retailer__c=0015t000002ZDK9AAO    RetailerDesigner__c=0035t000006quv9AAA    Job_Source__c=API    ConsumerLastName__c=Sean    ConsumerFirstName__c=Kingstone    ConsumersCity__c=GUNDAGAI    ConsumersCountry__c=Australia    ConsumersEmail__c=seankingstone1@deloitte.co.il    ConsumersPhone__c=06577575    ConsumersState__c=Victoria    ConsumersPostalCode__c=2722    ConsumersStreet__c=11 Greenlee Street
    create session    myssion1    ${AppURL}
    ${Response}=    post on session    myssion1     /services/data/v52.0/sobjects/Job__c    json=${body}    headers=${headers}
    #The request has been successfully processed and the resource has been created.
    should be equal as integers    ${Response.status_code}    201
    ${jsonres}=    set variable    ${Response.json()}

    ${Status}=    get from dictionary     ${jsonres}    success
    ${JobId}=    get from dictionary     ${jsonres}    id
    #log to console     2222222222
    #log to console     ${jsonres}
    #log to console     ${Status}
    #log to console     ${JobId}
    [Return]    ${JobId}



Validate CREATE NEW JOB
    [Arguments]   ${JobId}
    should not be equal    ${JobId}    ${EMPTY}


UPDATE STATUS TO “NEW JOB”
    [Arguments]   ${access_token}    ${token_type}    ${JobId}

    ${header}    set variable    ${token_type} ${access_token}
    ${headers}   create dictionary    Content-Type=application/json    Authorization=${header}
    ${AppURL}   set variable    https://caesarstone--cspartial.my.salesforce.com
    #${HEADERS}  set variable    application/x-www-form-urlencoded
    &{body}   create dictionary     Status__c=New Job    MeasurementDate__c=2023-01-01    MeasurementsTimePreference__c=07:00 - 12:00    InstallationDate__c=2023-01-08    InstallationTimePreference__c=07:00 - 12:00
    create session    myssion2    ${AppURL}
    ${Response}=    patch on session    myssion2     /services/data/v52.0/sobjects/Job__c/${JobId}    json=${body}    headers=${headers}
    #The request has been successfully processed and the resource has been created.
    should be equal as integers    ${Response.status_code}    204
    #${jsonres}=    set variable    ${Response.json()}

    #${Status}=    get from dictionary     ${jsonres}    success
    #${JobId}=    get from dictionary     ${jsonres}    id
    #log to console     333333333333
    #log to console     ${jsonres}
    #log to console     ${Status}
    #log to console     ${JobId}
    #[Return]    ${JobId}



GET JOB NAME “NEW JOB”
    [Arguments]   ${access_token}    ${token_type}    ${JobId}

    ${header}    set variable    ${token_type} ${access_token}
    ${headers}   create dictionary    Content-Type=application/json    Authorization=${header}
    ${AppURL}   set variable    https://caesarstone--cspartial.my.salesforce.com
    #${HEADERS}  set variable    application/x-www-form-urlencoded
    &{body}   create dictionary   FabricatorApprovalForThisJob__c=Yes
    create session    myssion6    ${AppURL}
    ${Response}=    get on session    myssion6    url=/services/data/v52.0/query/?q=SELECT+FIELDS(ALL)+from+Job__c+where+Id+=+'${JobId}'+LIMIT+200     headers=${headers}
    #The request has been successfully processed and the resource has been created.
    should be equal as integers    ${Response.status_code}    200
    ${jsonres}=    set variable    ${Response.json()}
    ${JOBName}=    get from dictionary     ${jsonres}    records
    ${JOBName}=    set variable     ${jsonres['records'][0]['Name']}
    #log to console     4
    #log to console     ${jsonres}
    #log to console     ${JOBName}
    [Return]     ${JOBName}


