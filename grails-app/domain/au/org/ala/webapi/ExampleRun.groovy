package au.org.ala.webapi

import groovy.transform.ToString

@ToString
class ExampleRun {

    final static def MAX_URL_SIZE = 65536 // chars

    Example example
    String url // The URL that was used for this run
    // The below are timestamps but mysql before v5.6.something doesn't support ms precision which we want
    long start
    long end
    long duration

    static belongsTo = [example:Example]

    static constraints = {
        example(nullable: false)
        url(nullable: false, maxSize: MAX_URL_SIZE)
        start(nullable: false, index: 'EXAMPLE_RUN_START_INDEX')
        end(nullable: false, validator: {  value, exampleRun ->
            value >= exampleRun.start
        })
    }

    static mapping = {
        duration formula: 'END - START'
    }
}
