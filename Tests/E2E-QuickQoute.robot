*** Settings ***
Documentation    End to end testing automation for Caesar Stone (Retailer and Fabricator)
Resource    ../Processes/Login Retailer.robot
Resource    ../Processes/Create Quick Quote.robot
Resource    ../Processes/New Job.robot
Resource    ../Processes/Pending Fabricator Review & Acceptance.robot
Resource    ../Processes/Job Pending Measurement.robot
Resource    ../Processes/Pending Installation.robot
Resource    ../Processes/Invoice and completion.robot
Library    ../Processes/functions.py
Library        DateTime
Suite Setup    Login Retailer.Initiate Web Tests    ${BROWSER}    ${BROWSER_OPTIONS}
Suite Teardown    Common.Terminate Web Tests

*** Variables ***
${BROWSER} =    chrome
${BROWSER_OPTIONS} =    add_argument("--start-maximized");add_argument("--disable-notifications");add_argument("--disable-popup-blocking");add_experimental_option('excludeSwitches', ['enable-logging']);add_argument("--window-size=1360,768");add_argument("--headless")


*** Test Cases ***
Create Quick Quote as Retailer

    [Tags]    scenario
    Create Quick Quote.Process
    ${CURJOB}=    get text    //div[text()="Job"]/parent::h1/div/span
    New Job.Process    ${CURJOB}
    Pending Fabricator Review & Acceptance.Process    ${CURJOB}
    Job Pending Measurement.Process    ${CURJOB}
    Pending Installation.Proccess    ${CURJOB}
    Invoice and completion.Proccess    ${CURJOB}


