function() {    

    //default to karate dev config
    var env = (!karate.env) ? 'dev' : karate.env;
    karate.log('karate.env system property was:', env);

    //properties exposed to all karate tests
    var config = {
        env: env
    } // end of config object

    if (env == 'dev' ) { 
        config.cApiProtocol = "https://";
        config.cApiServer = "api.github.com";
        config.cApiUrl = config.cApiProtocol + config.cApiServer;
        config.cDateFormat = "YYYY-MM-DDTHH:MM:SSZ";
        config.cHeaderAccept = "application/vnd.github.v3+json";
    } else if (env == 'prod') {
        // made same as dev for the moment. usually would point to different server
        config.cApiProtocol = "https://";
        config.cApiServer = "api.github.com";
        config.cApiUrl = config.cApiProtocol + config.cApiServer;
        config.cDateFormat = "YYYY-MM-DDTHH:MM:SSZ";
        config.cHeaderAccept = "application/vnd.github.v3+json";
    }
    
    karate.configure('logPrettyRequest', true);
    karate.configure('logPrettyResponse', true);
    
    return config;
} // end of karate-config