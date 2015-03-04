import org.apache.log4j.Level

/******************************************************************************\
 *  CONFIG MANAGEMENT
\******************************************************************************/

def appName = 'webapi'
def ENV_NAME = "${appName.toUpperCase()}_CONFIG"
default_config = "/data/${appName}/config/${appName}-config.properties"
if(!grails.config.locations || !(grails.config.locations instanceof List)) {
    grails.config.locations = []
}
if(System.getenv(ENV_NAME) && new File(System.getenv(ENV_NAME)).exists()) {
    println "[${appName}] Including configuration file specified in environment: " + System.getenv(ENV_NAME);
    grails.config.locations.add "file:" + System.getenv(ENV_NAME)
} else if(System.getProperty(ENV_NAME) && new File(System.getProperty(ENV_NAME)).exists()) {
    println "[${appName}] Including configuration file specified on command line: " + System.getProperty(ENV_NAME);
    grails.config.locations.add "file:" + System.getProperty(ENV_NAME)
} else if(new File(default_config).exists()) {
    println "[${appName}] Including default configuration file: " + default_config;
    grails.config.locations.add "file:" + default_config
} else {
    println "[${appName}] No external configuration file defined."
}

println "[${appName}] (*) grails.config.locations = ${grails.config.locations}"

grails.project.groupId = 'au.org.ala' // change this to alter the default package name and Maven publishing destination
grails.mime.file.extensions = true // enables the parsing of file extensions from URLs into the request format
grails.mime.use.accept.header = false
grails.mime.types = [
    all:           '*/*',
    atom:          'application/atom+xml',
    css:           'text/css',
    csv:           'text/csv',
    form:          'application/x-www-form-urlencoded',
    html:          ['text/html','application/xhtml+xml'],
    js:            'text/javascript',
    json:          ['application/json', 'text/json'],
    multipartForm: 'multipart/form-data',
    rss:           'application/rss+xml',
    text:          'text/plain',
    xml:           ['text/xml', 'application/xml']
]

// URL Mapping Cache Max Size, defaults to 5000
//grails.urlmapping.cache.maxsize = 1000

// What URL patterns should be processed by the resources plugin
grails.resources.adhoc.patterns = ['/images/*', '/css/*', '/js/*', '/plugins/*']

// The default codec used to encode data with ${}
grails.views.default.codec = "none" // none, html, base64
grails.views.gsp.encoding = "UTF-8"
grails.converters.encoding = "UTF-8"
// enable Sitemesh preprocessing of GSP pages
grails.views.gsp.sitemesh.preprocess = true
// scaffolding templates configuration
grails.scaffolding.templates.domainSuffix = 'Instance'

// Set to false to use the new Grails 1.2 JSONBuilder in the render method
grails.json.legacy.builder = false
// enabled native2ascii conversion of i18n properties files
grails.enable.native2ascii = true
// packages to include in Spring bean scanning
grails.spring.bean.packages = []
// whether to disable processing of multi part requests
grails.web.disable.multipart=false

// request parameters to mask when logging exceptions
grails.exceptionresolver.params.exclude = ['password']

// configure auto-caching of queries by default (if false you can cache individual queries with 'cache: true')
grails.hibernate.cache.queries = false

// configure mail settings
grails.mail.host = "smtp.csiro.au"
grails.mail.default.from = "support@ala.org.au"

// default application config
webapi.support.email="support@ala.org.au"
webapi.digest.threshold=3L
webapi.heartbeat.threads=10

// set grails spring beans properties
beans {
    exampleService {
        emailAddress = '${webapi.support.email}'
        failureThreshold = '${webapi.digest.threshold}'
    }
}

environments {
    development {
        grails.logging.jul.usebridge = true
        grails.mail.disabled = true
        grails.mail.overrideAddress = "simon.bear@csiro.au"
    }
    production {
        grails.logging.jul.usebridge = false
        grails.serverURL = "http://api.ala.org.au"
    }
}

def loggingDir = (System.getProperty('catalina.base') ? System.getProperty('catalina.base') + '/logs' : './logs')
// log4j configuration
log4j = {
// Example of changing the log pattern for the default console
// appender:
    appenders {
        environments {
            production {
                rollingFile name: "tomcatLog", maxFileSize: '1MB', file: "${loggingDir}/${appName}.log", threshold: Level.ERROR, layout: pattern(conversionPattern: "%d %-5p [%c{1}] %m%n")
            }
            development {
                console name: "stdout", layout: pattern(conversionPattern: "%d %-5p [%c{1}] %m%n"), threshold: Level.DEBUG
            }
            test {
                rollingFile name: "stdout,tomcatLog", maxFileSize: '1MB', file: "/tmp/${appName}", threshold: Level.DEBUG, layout: pattern(conversionPattern: "%d %-5p [%c{1}] %m%n")
            }
        }
    }
    root {
// change the root logger to my tomcatLog file
        error 'tomcatLog'
        warn 'tomcatLog'
        additivity = true
    }

    warn 'au.org.ala.cas.client',
            'grails.spring.BeanBuilder',
            'grails.plugin.webxml',
            'grails.plugin.cache.web.filter',
            'grails.app.services.org.grails.plugin.resource',
            'grails.app.taglib.org.grails.plugin.resource',
            'grails.app.resourceMappers.org.grails.plugin.resource'

    debug 'grails.app'
}
