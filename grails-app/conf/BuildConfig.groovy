import grails.util.Environment

grails.servlet.version = "2.5" // Change depending on target container compliance (2.5 or 3.0)
grails.project.class.dir = "target/classes"
grails.project.test.class.dir = "target/test-classes"
grails.project.test.reports.dir = "target/test-reports"
grails.project.target.level = 1.6
grails.project.source.level = 1.6
//grails.project.war.file = "target/${appName}-${appVersion}.war"

// uncomment (and adjust settings) to fork the JVM to isolate classpaths
//grails.project.fork = [
//   run: [maxMemory:1024, minMemory:64, debug:false, maxPerm:256]
//]

grails.project.dependency.resolver = "maven"

grails.project.dependency.resolution = {
    // inherit Grails' default dependencies
    inherits("global") {
        // specify dependency exclusions here; for example, uncomment this to disable ehcache:
        // excludes 'ehcache'
    }
    log "warn" // log level of Ivy resolver, either 'error', 'warn', 'info', 'debug' or 'verbose'
    checksums true // Whether to verify checksums on resolve
    legacyResolve false // whether to do a secondary resolve on plugin installation, not advised and here for backwards compatibility

    repositories {
        mavenLocal()
        mavenRepo("http://nexus.ala.org.au/content/groups/public/") {
            updatePolicy 'always'
        }
    }

    dependencies {
        // specify dependencies here under either 'build', 'compile', 'runtime', 'test' or 'provided' scopes e.g.
        runtime 'mysql:mysql-connector-java:5.1.22'
        compile 'com.google.guava:guava:16.0.1'
        test 'org.spockframework:spock-grails-support:0.7-groovy-2.0'
    }

    plugins {
        build ":release:3.0.1"
        build ":tomcat:7.0.54"

        compile ':cache:1.1.1'
        compile ":scaffolding:2.0.1"
        compile ":quartz:1.0.1"
        compile ":mail:1.0.4"
        compile ":d3:3.4.1.0"
        compile ":joda-time:1.4"
        compile ":pretty-time:2.1.3.Final-1.0.1"
        compile ":markdown:1.1.1"

        runtime ":database-migration:1.3.2"
        runtime (":ala-bootstrap2:2.1") {
            exclude "jquery"
        }
        runtime ":resources:1.2.14"
        if (Environment.current == Environment.PRODUCTION) {
            runtime ":zipped-resources:1.0.1"
            runtime ":cached-resources:1.1"
            compile ":cache-headers:1.1.7"
            runtime ":yui-minify-resources:0.1.5"
        }
        runtime ':ala-auth:1.2'
        runtime ":hibernate:3.6.10.16"
        runtime ":jquery:1.8.3"
        runtime ':database-migration:1.3.8'

    }
}
