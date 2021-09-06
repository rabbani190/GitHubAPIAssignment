@ignore
Feature: Fetch GitHub Repo

#uses the following parameters:
#userName - username of the github user
#repoName - repository name owned by the github user

#returns:
#savedResponse - contains response

Scenario: Fetch GitHub Repo
	Given url cApiUrl
	
	#showing an example of string templates
	And def enpoint = '/repos/<user_name>/<repo_name>'
	And replace enpoint.user_name = userName
	And replace enpoint.repo_name = repoName
	
	When path enpoint
	And header Accept = cHeaderAccept
	Then method GET
	And def savedResponse = response