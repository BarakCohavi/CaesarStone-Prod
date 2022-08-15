*** Settings ***
Library    SeleniumLibrary
Library    Collections

*** Variables ***
${ARROW>Show more actions} =    xpath://*[@class="slds-button slds-button_icon-border-filled"]
${Log in to Experience as User} =    xpath://*[text()="Log in to Experience as User"]

*** Keywords ***
Begin Web Test
    [Arguments]    ${Browser}    ${Options}
    Open Browser    about:blank    ${Browser}    options=${Options}

Terminate Web Tests
    sleep    5s
    close browser


Verify Being On Page
    [Arguments]    ${PageVar}
    wait until page contains    PageVar

Retailer Log Out
    Wait Until Page Contains Element    xpath://*[text()="Good Work!"]    60s
    scroll element into view    xpath://*[@title="Expand search"]
    click element    xpath://*[@class="slds-button slds-no-space slds-m-bottom_xx-small"]
    click element    xpath://*[@title="Log Out"]

Retailer Log Out-API
    Wait Until Page Contains Element    xpath://*[text()="Do You Accept The Job?"]    60s
    scroll element into view    xpath://*[@title="Expand search"]
    wait until page does not contain element    xpath://*[text()="Save"]    30s
    wait until page contains element    xpath://*[text()="Mark Status as Complete"]    30s
    click element    xpath://*[@class="comm-user-profile-menu__trigger-p slds-text-align_right slds-truncate slds-m-vertical_xx-small"]
    click element    xpath://*[@title="Log Out"]



Navigate To To Giving Link Page
    [Arguments]    ${User_Link}
    Go To    ${User_Link}
    Go To    ${User_Link}
    Wait Until Page Contains Element    xpath://*[text()="Account Name"]    60s
    Wait Until Page Contains Element    ${ARROW>Show more actions}    60s


Login To Experience As User
    Wait Until Element Is Visible    ${ARROW>Show more actions}    60s
    sleep    0.5s
    click button    ${ARROW>Show more actions}

    ${CountProducts}=    get element count    xpath://*[text()="Log in to Experience as User"]
    IF    ${CountProducts}==0
    click element    ${ARROW>Show more actions}
    END
    Wait Until Page Contains Element    xpath://*[text()="Log in to Experience as User"]    60s
    click element    ${Log in to Experience as User}

    wait until page does not contain element    xpath://*[text()="Log in to Experience as User"]    30s
    ${CountProducts}=    get element count    ${ARROW>Show more actions}
    IF    ${CountProducts}==1
        Login To Experience As User
    END






Navigating To "Experience As User"
    [Arguments]    ${User_Link}
    Navigate To To Giving Link Page   ${User_Link}
    Login To Experience As User



LogOut As Fabricator
    scroll element into view    xpath://*[@title="Expand search"]
    click element    xpath://*[@class="slds-button slds-no-space slds-m-bottom_xx-small"]
    click element    xpath://*[@title="Log Out"]

Search Job By Job Name
    [Arguments]    ${CURJOB}
    sleep    3s
    wait until page contains element    xpath://*[text()="Account Name"]    60s
    click element    xpath://*[@aria-label="Search"]

    wait until page contains element    xpath://*[@type="search" and @placeholder="Search..."]    60s
    input text   //*[@type="search" and @placeholder="Search..."]    ${CURJOB}
    wait until page contains element    xpath://span/mark[text()="${CURJOB}"]   60s
    click element    xpath://span/mark[text()="${CURJOB}"]


select checkbox COCUploaded
    wait until page contains element    xpath://*[text()="Pick Slip Generated?"]    60s
    scroll element into view    xpath://*[text()="Do Not Send Cleaning Kit"]
    click button    xpath://*[text()="COC Uploaded"]/parent::div/following-sibling::div/button
    select checkbox    xpath://*[@name="COCUploaded__c"]

    sleep    0.5


    wait until page contains element    xpath://*[text()="Save"]    60s
    capture page screenshot
    click button    Save
    wait until page contains element    xpath://*[text()="COC Uploaded"]/parent::div/following-sibling::div/button    60s

Click Search CaesarStone Page
    [Arguments]    ${CURJOB}
    #sleep    7s
    reload page
    #Wait Until Page Contains Element    xpath://*[contains(text(),"Create Quick Quote")]    60s
    Wait Until Page Contains Element    xpath://*[@class="slds-button slds-no-space slds-m-bottom_xx-small"]    60s
    wait until element is enabled    xpath://*[@class="slds-button slds-no-space slds-m-bottom_xx-small"]    60s
    wait until element is visible    xpath://*[@class="slds-button slds-no-space slds-m-bottom_xx-small"]    60s
    sleep    5.5s
    wait until element is enabled    xpath:(//*[@data-key="search"]/parent::lightning-primitive-icon)[1]    60s
    mouse down    xpath:(//*[@data-key="search"]/parent::lightning-primitive-icon)[1]
    mouse up    xpath:(//*[@data-key="search"]/parent::lightning-primitive-icon)[1]
    #click element    xpath:(//*[@data-key="search"]/parent::lightning-primitive-icon)[1]
    sleep    1s
    input text   //*[@aria-label="Search..."]    ${CURJOB}
    #click element    xpath:(//*[@data-key="search"])[1]
    click element    xpath://*[@title="Search"]

    #Wait Until Page Contains Element    xpath://*[@title="${CURJOB}"]    60s
    #Wait Until element is enabled    xpath://*[@title="${CURJOB}"]    60s
    sleep    2s
    Wait Until Page Contains Element    xpath://*[contains(text(),"${CURJOB}")]    60s
    Wait Until element is enabled    xpath://*[contains(text(),"${CURJOB}")]    60s


    #wait until page does not contain element   xpath://*[text()="Status"]    60s
    sleep    2s
     ${CountProducts}=    get element count    xpath://*[contains(text(),"We searched for")]
    capture page screenshot
    IF    ${CountProducts}==1
       capture page screenshot
       click search caesarstone page    ${CURJOB}
    END
    ${CountProducts}=    get element count    xpath://a[text()="${CURJOB}"]
    capture page screenshot
    IF    ${CountProducts}==0
       capture page screenshot
       click search caesarstone page    ${CURJOB}
    END

    Wait Until Page Contains Element    xpath://*[@title="${CURJOB}"]    60s
    wait until element is visible    xpath://*[@title="${CURJOB}"]    60s
    ${CountProducts}=    get element count    xpath://a[text()="${CURJOB}"]
    capture page screenshot
    sleep    2s
    IF    ${CountProducts}==1
           Wait Until Page Contains Element    xpath://*[@title="${CURJOB}"]    60s
             wait until element is visible    xpath://*[@title="${CURJOB}"]    60s
           click element    xpath://*[@title="${CURJOB}"]
    END

Click Search CaesarStone Page1
    [Arguments]    ${CURJOB}
    Wait Until Page Contains Element    xpath://*[contains(text(),"Retailer")]    60s
    click element    xpath:(//*[@data-key="search"])[1]
    input text   //*[@aria-label="Search..."]    ${CURJOB}
    click element    xpath://*[@title="Search"]
    sleep    2s

    ${CountProducts}=    get element count    xpath://a[text()="${CURJOB}"]
    capture page screenshot    
    IF    ${CountProducts}==0
        click element    xpath:(//*[@data-key="search"])[1]
        input text   //*[@aria-label="Search..."]    ${CURJOB}
        click element    xpath:(//*[@title="Search"])[1]
    END

    Wait Until Page Contains Element    xpath://*[@title="${CURJOB}"]    60s
    click element    xpath://*[@title="${CURJOB}"]
