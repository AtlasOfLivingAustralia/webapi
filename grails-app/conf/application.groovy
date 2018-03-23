grails.project.groupId = "au.org.ala"

grails.serverURL = 'http://local.ala.org.au:8080'

ENV_NAME = "WEBAPI"
appName = 'webapi'
application.title = 'Web service API'
grails.config.locations = ["file:/data/${appName}/config/${appName}-config.properties",
                           "file:/data/${appName}/config/${appName}-config.yml",
                           "file:/data/${appName}/config/${appName}-config.groovy"]
if (System.getenv(ENV_NAME) && new File(System.getenv(ENV_NAME)).exists()) {
    println "[EXPERT] Including configuration file specified in environment: " + System.getenv(ENV_NAME);
    grails.config.locations = ["file:" + System.getenv(ENV_NAME)]
} else if (System.getProperty(ENV_NAME) && new File(System.getProperty(ENV_NAME)).exists()) {
    println "[EXPERT] Including configuration file specified on command line: " + System.getProperty(ENV_NAME);
    grails.config.locations = ["file:" + System.getProperty(ENV_NAME)]
} else {
    println "[EXPERT] Including default configuration files, if they exist: " + grails.config.locations
}

grails.cors.enabled = true

// default application config

webapi.digest.threshold = 3L
webapi.heartbeat.threads = 10

skin.layout = 'main'
skin.fluidLayout = 'false'

webapi.support.email = "support@ala.org.au"
webapi.digest.threshold = 3L
grails.mail.host = 'localhost'
grails.mail.port = 25
grails.mail.default.from = "support@ala.org.au"

environments {
    development {
        grails.mail.disabled = true
        grails.logging.jul.usebridge = true
    }
    production {
        grails.logging.jul.usebridge = false
        grails.serverURL = "http://api.ala.org.au"
    }
}

dataSource {
    pooled = true
    driverClassName = "com.mysql.jdbc.Driver"
    dialect = 'org.hibernate.dialect.MySQL5InnoDBDialect'
    username = "user"
    password = "password"
    dbCreate = "update"
    url = "jdbc:mysql://localhost:3306/webapi"
}

hibernate {
    cache.use_second_level_cache = true
    cache.use_query_cache = true
    cache.provider_class = 'net.sf.ehcache.hibernate.EhCacheProvider'
}

// environment specific settings
environments {
    development {
        dataSource {
            dbCreate = "update"
            url = "jdbc:mysql://localhost:3306/webapi"
            testOnBorrow = true

        }
    }
    production {
        dataSource {
            dbCreate = "update"
            testOnBorrow = true
            properties {
                maxActive = 10
                maxIdle = 5
                minIdle = 5
                initialSize = 5
                minEvictableIdleTimeMillis = 60000
                timeBetweenEvictionRunsMillis = 60000
                maxWait = 10000
                validationQuery = "select max(id) from category"
            }
        }
    }
}

ignoreCookie = 'true'
security {
    cas {
        // appServerName is automatically set from grails.serverURL

        uriFilterPattern = '/alaAdmin.*'
        uriExclusionFilterPattern = '/assets/.*,/images/.*,/css/.*,/js/.*,/less/.*'

        //authenticateOnlyIfLoggedInPattern requires authenticateOnlyIfLoggedInPattern to identify 'logged in' when ignoreCookie='true'
        authenticateOnlyIfLoggedInPattern = '.*'
    }
}
