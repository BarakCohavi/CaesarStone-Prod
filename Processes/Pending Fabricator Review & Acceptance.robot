*** Settings ***
Library    SeleniumLibrary
Resource    Common.robot
Resource    ../Processes/Invoice and completion.robot

*** Variables ***
#${cs connect_aus_fab1 page} =    https://caesarstone--cspartial.lightning.force.com/lightning/r/Contact/0035t000001ynS1AAI/view

*** Keywords ***
Process
    [Documentation]    Pending Fabricator Review & Acceptance
    [Arguments]    ${CURJOB}
    wait until page contains element    xpath://*[text()="Sales Caesarstone"]    60s
    Login To Experience As Fabricator
    Click Search CaesarStone Page    ${CURJOB}
    Accept The Job (Click Yes)




Login To Experience As Fabricator
    ${cs connect_aus_fab1 page}=    ReadInput  2  9
    Common.Navigating To "Experience As User"    ${cs connect_aus_fab1 page}
    SLEEP    2s

Navigate Jobs
    Wait Until Page Contains Element   xpath://*[contains(text(),"We are excited to launch our new Dashboards!")]    60s
    click link    xpath://a[text()='Jobs']


Open Full Jobs List
    wait until page contains    Jobs
    Wait Until Page Contains Element    xpath://*[@title="Select List View"]    60s
    click element    xpath://*[@title="Select List View"]
    Wait Until Page Contains Element    xpath://*[text()="All"]    60s
    click element    xpath://*[text()="All"]


Select & Click First Job
    Wait Until Page Contains Element    xpath://span[@title="Installation Date Preference"]/parent::a    60s
    click element    xpath://span[@title="Installation Date Preference"]/parent::a
    sleep    5s
    click element    xpath://tbody/tr[1]/th/span/a

Accept The Job (Click Yes)
    Wait Until Page Contains Element    xpath://*[@title="Edit Do You Accept The Job?"]    60s
    click element    xpath://*[@title="Edit Do You Accept The Job?"]
    Wait Until Page Contains Element    xpath://*[@class="uiMenu"]/div/div/div/a[text()="--None--"]    60s
    click element    xpath://*[@class="uiMenu"]/div/div/div/a[text()="--None--"]
    Wait Until Page Contains Element    xpath://*[text()="Yes"]    60s
    capture page screenshot
    click element    xpath://*[text()="Yes"]
    scroll element into view    xpath://*[text()="Save"]
    click element    xpath://*[text()="Save"]

Reject The Job (Click No)
    Wait Until Page Contains Element    xpath://*[@title="Edit Do You Accept The Job?"]    60s
    click element    xpath://*[@title="Edit Do You Accept The Job?"]
    Wait Until Page Contains Element    xpath://*[@class="uiMenu"]/div/div/div/a[text()="--None--"]    60s
    click element    xpath://*[@class="uiMenu"]/div/div/div/a[text()="--None--"]
    Wait Until Page Contains Element    xpath://*[text()="Yes"]    60s
    capture page screenshot
    click element    xpath://*[text()="No"]
    scroll element into view    xpath://*[text()="Save"]
    click element    xpath://*[text()="Save"]



