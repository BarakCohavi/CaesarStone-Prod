*** Settings ***
Library    RequestsLibrary
Library    JSONLibrary
Library    Collections

Library    SeleniumLibrary
Resource    ../Processes/Login Retailer.robot
Resource    ../Processes/New Job.robot
Resource    ../Processes/Pending Fabricator Review & Acceptance.robot
Resource    ../Processes/API's Keywords.robot

#Suite Setup    Login Retailer.Initiate Web Tests    ${BROWSER}    ${BROWSER_OPTIONS}
Suite Teardown    Common.Terminate Web Tests

*** Variables ***
${BROWSER} =    chrome
${BROWSER_OPTIONS} =    add_argument("--start-maximized");add_argument("--disable-notifications");add_argument("--disable-popup-blocking");add_experimental_option('excludeSwitches', ['enable-logging']);add_argument("--window-size=1360,768");add_argument("--headless")


*** Test Cases ***
Quote to new job
    [Documentation]    retailer change measurement date, fabricator accepts new measurement date

    ${access_token}    ${token_type}    AUTHENTICATION
    ${JobId}    CREATE NEW JOB     ${access_token}    ${token_type}
    Validate CREATE NEW JOB    ${JobId}
    #UPDATE STATUS TO “NEW JOB”         ${access_token}    ${token_type}    ${JobId}
    ${JobName}     GET JOB NAME “NEW JOB”        ${access_token}    ${token_type}    ${JobId}
    Login Retailer.Initiate Web Tests      ${BROWSER}    ${BROWSER_OPTIONS}
    maximize browser window
    API - login as retailer
    Login To Experience As User
    sleep    2s
    Click Search CaesarStone Page    ${JobName}
    Clicking "Mark Status As Complete" Button1
    API - Choose Measurement && Installation Time
    capture page screenshot
    common.retailer log out
    API - log in as a fabricator
    Click Search CaesarStone Page    ${JobName}
    Accept The Job (Click Yes)
    capture page screenshot
    sleep    3s
    wait until page does not contain element    xpath://*[text()="Save"]    30s
    wait until page contains element    xpath://*[text()="Mark Status as Complete"]    30s
    Common.LogOut As Fabricator
    ${JOBStatus}    API - Validate Acceptance Fabricator API     ${access_token}    ${token_type}    ${JobId}
    #should be equal as strings    ${JOBStatus}    New Job
    API - login as retailer
    Login To Experience As User
    sleep    2s
    Click Search CaesarStone Page    ${JobName}
    #Clicking "Mark Status As Complete" Button1
    API - Change Measurement && Installation Time
    capture page screenshot
    common.Retailer Log Out-API
    API - log in as a fabricator
    #check notification
    reload page
    sleep    18s
    wait until page contains element    xpath://*[@class="headerButtonBody"]/lightning-icon/lightning-primitive-icon   60s
    sleep    2s
    click element     xpath://span/span[@class="counterLabel"]
    #mouse up    xpath://*[@class="headerButtonBody"]/lightning-icon
    sleep    2s
    ${CountProducts}=    get element count    xpath://*[contains(text(),"${JobName}")]
    #IF    ${CountProducts}==0
        #click element     xpath://span/span[@class="counterLabel"]
        #mouse up    xpath://*[@class="headerButtonBody"]/lightning-icon
    #END

    wait until page contains element    xpath://*[contains(text(),"${JobName}")]    30s
    click element    xpath://*[contains(text(),"${JobName}")]
    capture page screenshot
    wait until page contains element    xpath://*[text()="Approve"]     60s
    click element    xpath://*[text()="Approve"]
    capture page screenshot
    wait until page contains element    xpath://*[text()="Approve Job"]      60s
    click element    xpath:(//*[text()="Approve"])[2]
    capture page screenshot
    wait until page contains element    xpath://*[text()="Approved"]      60s

    #Click Search CaesarStone Page    ${JobName}
    #Accept The Job (Click Yes)
    capture page screenshot
    sleep    3s
    Common.LogOut As Fabricator
    ${JOBStatus}    API - Validate Acceptance Fabricator API     ${access_token}    ${token_type}    ${JobId}
    should be equal as strings    ${JOBStatus}    Job Pending Measurement






