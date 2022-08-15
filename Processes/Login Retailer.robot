*** Settings ***
Library    SeleniumLibrary
Resource    Common.robot
Library    ../Processes/functions.py

*** Variables ***
#${cspartial login_page} =  https://caesarstone--cspartial.lightning.force.com/lightning/page/home
#${login_username} =    caesarstone.testing@gmail.com.api
#${login_password} =    2w3e4r5t6y

*** Keywords ***
Login To CSpartial
    ${cspartial login_page} =    ReadInput  2  1
    ${login_username} =      ReadInput  2  2
    ${login_password} =    ReadInput  2  3

    Go To   ${cspartial login_page}

    ${G}=    get window size
    wait until page contains    Forgot Your Password?
    #input text    username   caesarstone.testing@gmail.com.api
    Execute javascript    document.getElementById('username').value="caesarstone.testing@gmail.com.api"
    capture page screenshot
    #input password    password   2w3e4r5t6y
    Execute javascript    document.getElementById('password').value="2w3e4r5t6y"

    #set window size    1920    1080
    capture page screenshot
    ${G}=    get window size
    click element    rememberUn
    capture page screenshot
    click button    Login
    Wait Until Page Contains Element     xpath://*[contains(text(),"Caesarstone")]    60s


Initiate Web Tests
    [Arguments]    ${Browser}    ${Options}
    Common.Begin Web Test    ${Browser}    ${Options}
    Login To CSpartial

