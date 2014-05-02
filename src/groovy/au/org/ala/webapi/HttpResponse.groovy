package au.org.ala.webapi

import groovy.transform.Immutable
import groovy.transform.ToString

@Immutable
@ToString(includeNames = true, includePackage = false, excludes = "body")
final class HttpResponse {
    final String url // giving this a URL type causes the Groovy 2.0.8 compiler to crash :(
    final int responseCode
    final String contentType
    final byte[] body
}
