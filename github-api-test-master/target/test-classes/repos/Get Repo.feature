Feature: GitHub API Test - Get Repo

Background: GitHub API Test - Get Repo
	
	# define common strings
	
	And def enpointRepo = '/repos/<user_name>/<repo_name>'

Scenario: Get Repo Information
	
	* def userName = "jaylara"
	* def repoName = "jaydata"

	Given url cApiUrl
	And replace enpointRepo.user_name = userName
	And replace enpointRepo.repo_name = repoName
	And path enpointRepo
	And header Accept = cHeaderAccept
	When method GET
	Then status 200
	And def savedResponse = response
	
	#assuming these objects came from the database or some "external source".
	And def repoInfo = 
	"""
	{
		id: '#(savedResponse.id)',
		name: '#(savedResponse.name)'
	}
	"""
	And def ownerInfo = 
	"""
	{
		id: '#(savedResponse.owner.id)',
		login: '#(savedResponse.owner.login)'
	}
	"""
	
	#check that dummy "external source" returned correct username and repo
	And match repoInfo.name == repoName
	And match ownerInfo.login == userName
	
	
	#check response returned correct username and repo
	And match savedResponse.owner.login == userName
	And match savedResponse.name == repoName
	
	#test avatar link is formed correctly and resolves
	And def expected_avatar_url =  "https://avatars1.githubusercontent.com/u/" + ownerInfo.id
	And match savedResponse.owner.avatar_url contains expected_avatar_url
	
	#test avatar link resolves
	Given url savedResponse.owner.avatar_url
	When method GET
	Then status 200
	And match responseHeaders['Content-Type'][0] == "image/jpeg"