@jay_test
Feature: GitHub API Test - Get Repo

Background: GitHub API Test - Get Repo
	#put more common stuff in here. each scenario will use these values
	* def userName = "jaylara"
	* def repoName = "jaydata"
	
	#use mock db data (shhh...it's really just a json file)
	* def DB = read('classpath:repos/data/jaylara_repo.json')
	

Scenario: Test Get Repo Information - Valid Root Fields + Non-Url Owner Fields
	
	# Do it this way each time, or...
	#	Given url cApiUrl
	#	And replace enpointRepo.user_name = userName
	#	And replace enpointRepo.repo_name = repoName
	#	And path enpointRepo
	#	And header Accept = cHeaderAccept
	#	When method GET
	#	Then status 200
	#	And def repositoryResponse = response
	
	#Do it this way with a resusable feature
	Given def repositoryResponse = call read('classpath:resusable/features/fetchRepo.feature') { userName: '#(userName)', repoName: '#(repoName)' }
	When match repositoryResponse.responseStatus == 200
	Then def repositoryResponse = repositoryResponse.savedResponse
	
	#check that dummy "external source" returned correct username and repo
	And match DB.name == repoName
	And match DB.owner.login == userName
	
	#check response returned correct username and repo
	And match repositoryResponse.owner.login == userName
	And match repositoryResponse.name == repoName
	
	#check repo id
	And match repositoryResponse.id == DB.id
	
	#check repo node id
	And match repositoryResponse.node_id == DB.node_id
	
	#check repo full name
	And match repositoryResponse.full_name == (repositoryResponse.owner.login + '/' + repositoryResponse.name)
	
	#check owner id
	And match repositoryResponse.owner.id == DB.owner.id
	
	#check owner node id
	And match repositoryResponse.owner.node_id == DB.owner.node_id
	
	#check owner type
	And match repositoryResponse.owner.type == DB.owner.type
	
	#check if owner is site admin
	And match repositoryResponse.owner.site_admin == DB.owner.site_admin


Scenario: Test Get Repo Information - Valid Owner Avatar Image
	Given def repositoryResponse = call read('classpath:resusable/features/fetchRepo.feature') { userName: '#(userName)', repoName: '#(repoName)' }
	When match repositoryResponse.responseStatus == 200
	Then def repositoryResponse = repositoryResponse.savedResponse
	
	#test avatar link is formed correctly and resolves
	And def expected_avatar_url =  "https://avatars1.githubusercontent.com/u/" + DB.owner.id
	And match repositoryResponse.owner.avatar_url contains expected_avatar_url
	
	#test avatar link resolves and has correct content type
	Given url repositoryResponse.owner.avatar_url
	When method GET
	Then status 200
	And match responseHeaders['Content-Type'][0] == "image/jpeg"


Scenario Outline:  Test Get Repo Information - Valid Owner Url Fields - API Urls 
	#During a scenario outline, I only wanted to touch the endpoint once. 
	#Otherwise, for each example executed, the endpoint would touched. Don't want risk being blocked
	* def repositoryResponse = callonce read('classpath:resusable/features/fetchRepo.feature') { userName: '#(userName)', repoName: '#(repoName)' }
	* def repositoryResponse = repositoryResponse.savedResponse
	* def expectedUrl = DB.owner["<url_val>"]
	* def actualUrl = repositoryResponse.owner["<url_val>"]
	
	#check that actual and expected urls are the same
	* match expectedUrl == actualUrl
	
	#get actual url ready for request
	* def actualUrl = read('classpath:resusable/javascript/removeUrlOptionalPath.js')(expectedUrl)
	
	#execute request
	* def response = call read('classpath:resusable/features/fetchUrl.feature') { fullUrl: '#(actualUrl)' }
	* def response = response.savedResponse
	
	#printing actual url and response. other tests can be performed here.
	* print actualUrl, response
	
	Examples:
	| url_val				|
	| url                   |
	| followers_url         |
	| following_url         |
	| gists_url             |
	| starred_url           |
	| subscriptions_url     |
	| organizations_url     |
	| repos_url             |
	| events_url            |
	| received_events_url   |


Scenario: Test Get Repo Information - Invalid Repo
	Given def repositoryResponse = call read('classpath:resusable/features/fetchRepo.feature') { userName: '#(userName)', repoName: 'this_is_bad_repo' }
	When match repositoryResponse.responseStatus == 404
	Then def repositoryResponse = repositoryResponse.savedResponse
	And match repositoryResponse ==
	"""
	{
		"message": "Not Found",
		"documentation_url": "https://developer.github.com/v3/repos/#get"
	}
	"""
	
Scenario: Test Get Repo Information - Invalid User
	Given def repositoryResponse = call read('classpath:resusable/features/fetchRepo.feature') { userName: 'what_user_am_i', repoName: '#(repoName)' }
	When match repositoryResponse.responseStatus == 404
	Then def repositoryResponse = repositoryResponse.savedResponse
	And match repositoryResponse ==
	"""
	{
		"message": "Not Found",
		"documentation_url": "https://developer.github.com/v3/repos/#get"
	}
	"""
	
	
@ignore
Scenario: This is just an empty scenario showing usage of @ignore tag
	* def name = "I do not remember my name"
	* print name