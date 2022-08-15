*** Settings ***
Library    RequestsLibrary
Library    JSONLibrary
Library    Collections
Library    SeleniumLibrary
Resource    ../Processes/Login Retailer.robot
Resource    ../Processes/New Job.robot
Resource    ../Processes/Pending Fabricator Review & Acceptance.robot
Resource    ../Processes/API's Keywords.robot

Suite Teardown    Common.Terminate Web Tests

*** Variables ***
${BROWSER} =    chrome
${BROWSER_OPTIONS} =    add_argument("--start-maximized");add_argument("--disable-notifications");add_argument("--disable-popup-blocking");add_experimental_option('excludeSwitches', ['enable-logging']);add_argument("--window-size=1360,768");add_argument("--headless")



*** Test Cases ***
Quote to new job
    [Documentation]    Retailer set fabricator & measure & install dates
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
    common.retailer log out
    ${JOBStatus}    API - Validate Acceptance Fabricator API     ${access_token}    ${token_type}    ${JobId}
    should be equal as strings    ${JOBStatus}    Pending For Fabricator Approval
