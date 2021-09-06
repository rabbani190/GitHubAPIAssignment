## GitHub API QA Assignment - Testing Analysis
Reference: https ://developer.github.com/v3/

## Problem
Suppose that you worked with a team that was tasked with implementing this specification.
- What concerns would you have from a testing perspective?
- How would you go about tackling the QA for this work?
- What sort of tests would be worth describing or worth automating?
- What tools would you use?  

## Instructions
1. Please select an endpoint to test and implement a test suite for that endpoint.
2. You may choose a tech stack of your choice for the tests.
3. Provide the URL of a public Git repo that contains the tests.
4. Include documentation in your repository that contains your written answers to the questions above.

## Solution

### What concerns would you have from a testing perspective?
- Basics:
    - Environment setup
    - Team member experience level
- Framework:
    - Maximize use of config file
    - Folder Structure
    - Reusable Features
- Tests:
    - Authorization
    - HTTP Verb/Path Matching
    - Invalid JSON
    - Correct Data Formats (Dates, Numbers, Strings)
    - Injection


### How would you go about tackling the QA for this work?
- Assumptions: Environment is setup, folder structure is good
- Read the documentation for the API endpoint
- Understand request requirements (inputs)
- Understand response data (outputs)
- Try to break the API - _I won't do much of that since this is a GET endpoint and I'm using account as an example_
- If more endpoints are in scope, and team exists, split up responsibility

#### Extra
There was no real data to validate against, I just used dummy json from an original request and used it as "DB/mock" data set.

### What sort of tests would be worth describing or worth automating?
- Data Validation: Each property accepts valid values and rejects invalid values
    - Date Formats:
        - Date fields should only accept YYYY-MM-DDTHH:MM:SSZ or UTC (in some cases)
    - Numbers: Integers, Floats, Max values, Minimum values
    - Strings:
        - Lengths: Max+1, Max, ""/Empty, null, Min, Min-1
        - Formats: Zip Codes, Address Codes, Phone Numbers, Email Addresses
    - UUIDs: Unique ids
    - Enums:
        - Some tests might overlap with a String Test
        - Only certain values are accepted. All others invalid
- Authorization:
    - Secure access should be checked when necessary


### What tools would you use? (Tech stack)
- Karate 0.7+ - https://github.com/intuit/karate
- Eclipse Oxygen - https://www.eclipse.org
- JDK 1.8 Update 151+ - http://www.oracle.com/technetwork/java/archive-139210.html


### Endpoint
- GET `https://api.github.com/repos/<user_name>/<repo_name>`
- _may touch a few others_

### GitHub Repo (for sharing and caring)
https://github.com/jaylara/github-api-test

#### Important files
- Config File: karate-config.js: https://github.com/jaylara/github-api-test/blob/master/src/test/java/karate-config.js
- Test Runner: ReposTestRunner.java: https://github.com/jaylara/github-api-test/blob/master/src/test/java/repos/ReposTestRunner.java
- Tests: Get Repo.feature: https://github.com/jaylara/github-api-test/blob/master/src/test/java/repos/Get%20Repo.feature
- Reusable Feature: fetchRepo.feature: https://github.com/jaylara/github-api-test/blob/master/src/test/java/resusable/features/fetchRepo.feature

### How to Run
1. Cloned git repo locally.
2. Import into Eclipse as a Maven project. (allow some time for initialization)
3. Run a test runner as a JUnit Test
