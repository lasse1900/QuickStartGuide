*** Settings ***
Library    OperatingSystem
Library    lib/LoginLibrary.py

*** Variables ***
${USERNAME}               janedoe
${PASSWORD}               J4n3D0e
${EMAIL}                  lasse@post.com
${NEW PASSWORD}           e0D3n4J
${DATABASE FILE}          ${TEMPDIR}${/}robotframework-quickstart-db.txt
${EMAIL}                  Email validation done with regex
${PWD INVALID LENGTH}     Password must be 7-12 characters long
${PWD INVALID CONTENT}    Password must be a combination of lowercase and uppercase letters and numbers
${SOMETEXT}               RobotFramework

*** Test Cases ***
User status is stored in database
    [Tags]    variables    database
    Create Valid User    ${USERNAME}    ${PASSWORD}    ${EMAIL}
    Database Should Contain    ${USERNAME}    ${PASSWORD}    ${EMAIL}    Inactive
    Login    ${USERNAME}    ${PASSWORD}
    Database Should Contain    ${USERNAME}    ${PASSWORD}    ${EMAIL}    Active


User can create an account and log in
    Create Valid User    fred    P4ssw0rd    lasse@post.com
    Attempt to Login with Credentials    fred    P4ssw0rd
    Status Should Be    Logged In

User cannot log in with bad password
    Create Valid User    betty    P4ssw0rd    liisa@post.com
    Attempt to Login with Credentials    betty    wrong
    Status Should Be    Access Denied

User can change password
    Given a user has a valid account
    When she changes her password
    Then she can log in with the new password
    And she cannot use the old password anymore

Invalid password
    [Template]    Creating user with invalid password should fail
    abCD5            ${PWD INVALID LENGTH}    ${email}
    abCD567890123    ${PWD INVALID LENGTH}    ${email}
    123DEFG          ${PWD INVALID CONTENT}    ${email}
    abcd56789        ${PWD INVALID CONTENT}    ${email}
    AbCdEfGh         ${PWD INVALID CONTENT}    ${email}
    abCD56+          ${PWD INVALID CONTENT}    ${email}


*** Keywords ***

Clear login database
    Remove file    ${DATABASE FILE}

Create valid user
    [Arguments]    ${username}    ${password}    ${email}
    Create user    ${username}    ${password}    ${email}
    Status should be    SUCCESS

Creating user with invalid password should fail
   [Arguments]    ${password}    ${error}    ${email}
   Create user    example    ${password}    ${email}
   Status should be    ${error}

Login
    [Arguments]    ${username}    ${password}
    Attempt to login with credentials    ${username}    ${password}
    Status should be    Logged In

Database Should Contain
    [Arguments]    ${username}    ${password}    ${email}    ${status}
    ${database} =     Get File    ${DATABASE FILE}
    Should Contain    ${database}    ${username}\t${password}\t${email}\t${status}\n

A user has a valid account
    Create valid user    ${USERNAME}    ${PASSWORD}    ${EMAIL}

She changes her password
    Change password    ${USERNAME}    ${PASSWORD}    ${NEW PASSWORD}
    Status should be    SUCCESS

She can log in with the new password
    Login    ${USERNAME}    ${NEW PASSWORD}

She cannot use the old password anymore
    Attempt to login with credentials    ${USERNAME}    ${PASSWORD}
    Status should be    Access Denied