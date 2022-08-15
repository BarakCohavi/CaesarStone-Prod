*** Settings ***
Library    SeleniumLibrary
Library    DateTime
Resource    Common.robot
Resource    ../Processes/Invoice and completion.robot
Resource    ../Processes/API's Keywords.robot
Library    functions.py

*** Variables ***
${ARROW>Show more actions} =    xpath://*[@id="brandBand_2"]/div/div/div/div/one-record-home-flexipage2/forcegenerated-adg-rollup_component___force-generated__flexipage_-record-page___-contact_-record_-page___-contact___-v-i-e-w/forcegenerated-flexipage_contact_record_page_contact__view_js/record_flexipage-record-page-decorator/div[1]/records-record-layout-event-broker/slot/slot/flexipage-record-home-template-desktop2/div/div[1]/slot/slot/flexipage-component2/slot/records-lwc-highlights-panel/records-lwc-record-layout/forcegenerated-highlightspanel_contact___012000000000000aaa___compact___view___recordlayout2/force-highlights2/div[1]/div[1]/div[3]/div/runtime_platform_actions-actions-ribbon/ul/li[4]/lightning-button-menu/button
${Log in to Experience as User} =    xpath://*[@id="brandBand_2"]/div/div/div/div/one-record-home-flexipage2/forcegenerated-adg-rollup_component___force-generated__flexipage_-record-page___-contact_-record_-page___-contact___-v-i-e-w/forcegenerated-flexipage_contact_record_page_contact__view_js/record_flexipage-record-page-decorator/div[1]/records-record-layout-event-broker/slot/slot/flexipage-record-home-template-desktop2/div/div[1]/slot/slot/flexipage-component2/slot/records-lwc-highlights-panel/records-lwc-record-layout/forcegenerated-highlightspanel_contact___012000000000000aaa___compact___view___recordlayout2/force-highlights2/div[1]/div[1]/div[3]/div/runtime_platform_actions-actions-ribbon/ul/li[4]/lightning-button-menu/div/div/slot/runtime_platform_actions-action-renderer[3]/runtime_platform_actions-executor-aura-legacy/slot/slot/runtime_platform_actions-ribbon-menu-item/a/span
#${csConnectTest_Owner_aus1 page} =    https://caesarstone--cspartial.lightning.force.com/lightning/r/Contact/0035t000001ynRwAAI/view
#${Measurement Date Preference}    Get Current Date    result_format=%d/%m/%Y
#${Installation Date Preference}=    27/10/2021

${Fabricator_Account}    cs connect aus fab1
*** Keywords ***
Process
    [Documentation]    Continueing Process of Created Quote
    [Arguments]    ${CURJOB}
    Navigating To "Experience As User"1
    Click Search CaesarStone Page    ${CURJOB}
    Clicking "Mark Status As Complete" Button1
    Choose Measurement && Installation Time
    common.retailer log out


Navigate To Retailer Page1
    ${csConnectTest_Owner_aus1 page} =        ReadInput  2  5
    ${RetailerAccount}=    ReadInput  2  4
    Go To    ${csConnectTest_Owner_aus1 page}
    Wait Until Page Contains Element   xpath://*[text()="${RetailerAccount}"]    60s
    Wait Until Page Contains Element    ${ARROW>Show more actions}

Login To Experience As User1
    Wait Until Element Is Visible    ${ARROW>Show more actions}
    sleep    0.5s
    click button    ${ARROW>Show more actions}
    Wait Until Page Contains Element   xpath://*[text()="Log in to Experience as User"]    60s
    click element    ${Log in to Experience as User}




Navigating To "Experience As User"1
    Navigate To Retailer Page1
    Login To Experience As User

Clicking "Jobs" On Navbar1
    wait Until Page Contains Element   xpath://*[contains(text(),"We are excited to launch our new Dashboards!")]    60s
    click link    xpath://a[text()='Jobs']


Clicking The First Item On "Jobs" List1
    wait Until Page Contains Element    xpath:/html/body/div[3]/div[2]/div/div[2]/div/div/div/div[2]/div/div[1]/div[2]/div[2]/div[1]/div/div/table/tbody/tr[1]/th/span/a    60s
    click link    xpath:/html/body/div[3]/div[2]/div/div[2]/div/div/div/div[2]/div/div[1]/div[2]/div[2]/div[1]/div/div/table/tbody/tr[1]/th/span/a

Verify Being On Job Page1
    wait until page contains    Job Details    60s

Clicking "Mark Status As Complete" Button1
    Verify Being On Job Page1
    sleep    1s
    Wait Until Page Contains Element    xpath://*[text()="Mark Status as Complete"]    60s
    click button    Mark Status as Complete



Choose Measurement && Installation Time
    Wait Until Page Contains Element    xpath://*[text()="Choose A Fabricator"]    60s
    Wait Until Page Contains Element    xpath://*[text()="Job Number"]    60s
    scroll element into view    xpath://*[text()="Job Number"]
    Wait Until Element Is Visible    xpath://*[@title="Edit Measurement Date Preference"]/lightning-primitive-icon
    click element    xpath://*[@title="Edit Measurement Date Preference"]/lightning-primitive-icon
    Wait Until Page Contains Element    xpath://*[text()="Job Number"]    60s

    ${Measurement Date Preference}   Get Current Date    result_format=%d/%m/%Y
    Choose Fabricator
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

    click button    Save
    wait until page does not contain element    xpath://*[text()="Save"]    30s
    Maybe Invalid Dates

    #click button    Mark Status as Complete


Choose Fabricator

    wait until page contains element    xpath://*[text()="Choose A Fabricator"]/parent::label/following-sibling::div/div/div/div/input    60s
    ${CountProducts}=    get element count    xpath://*[@class="deleteIcon"]
    IF    ${CountProducts}==1
    click element    xpath://*[@class="deleteIcon"]
    END
    click element    xpath://*[text()="Choose A Fabricator"]/parent::label/following-sibling::div/div/div/div/input

    #click element    xpath://*[@class="deleteIcon"]
    #Wait Until Page Contains Element    xpath://*[@title="$ ${fabricator}"]    60s
    #click element    xpath://*[@title="${Fabricator_Account}"]
    ${fabricator}    ReadInput  2  8
    input text    //*[text()="Choose A Fabricator"]/parent::label/following-sibling::div/div/div/div/input    ${fabricator}
    Wait Until Page Contains Element    xpath://*[@title="${fabricator}"]    60s
    sleep    1s
    click element    xpath://*[@title="${fabricator}"]
    sleep    0.5s