function(strUrl) {
	//Removes optional path in url
	//Example: 
	// - Input:		https://api.github.com/users/jaylara/starred{/owner}{/repo}
	// - Output:	https://api.github.com/users/jaylara/starred
	var idx = strUrl.indexOf("{");
	
	if(idx == -1)
		return strUrl;
	else
		return strUrl.substring(0,strUrl.indexOf("{"));
	
}