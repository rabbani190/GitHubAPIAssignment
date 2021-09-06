@ignore
Feature: Fetch GitHub API Url

#uses the following parameters:
#fullUrl - full url to be fetched - Ex. https://api.github.com/users/jaylara/gists

#returns:
#savedResponse - contains response

Scenario: Fetch GitHub API Url
	Given url fullUrl
	And header Accept = cHeaderAccept
	When method GET
	Then status 200
	And def savedResponse = response
	