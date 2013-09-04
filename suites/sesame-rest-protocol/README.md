
test the http api

this includes the sesame rest api, as per the openrdf "http communication protocol"
[description](http://www.openrdf.org/doc/sesame2/system/ch08.html)
and the "sparlq 1.1 graph store http protocol", as per the
[specification](http://www.w3.org/TR/sparql11-http-rdf-update/).

the script `script_runner.sh` searches for all `.sh` scripts in the tree,
runs each in turn, reports errors, and returns the error count as its result.
the scripts are arranged in directories which reflect the protocol resource paths.
the account (`openrdf-sesame`) and repository (`mem-rdf`) are defined such that
the openrdf documentation examples should succeed as given in its documentation.

the v2.0 resources are

        <SESAME_URL>
        /protocol         : protocol version (GET)
        /repositories     : overview of available repositories (GET)
	/<REP_ID>         : query evaluation and administration tasks on 
			    a repository (GET/POST/DELETE)
            /statements   : repository statements (GET/POST/PUT/DELETE)
            /contexts     : context overview (GET)
            /size         : #statements in repository (GET)
            /rdf-graphs   : named graphs overview (GET)
                /service  : Graph Store operations on indirectly referenced named graphs 
                            in repository (GET/PUT/POST/DELETE)
                /<NAME>   : Graph Store operations on directly referenced named graphs 
                            in repository (GET/PUT/POST/DELETE)
            /namespaces   : overview of namespace definitions (GET/DELETE)
                /<PREFIX> : namespace-prefix definition (GET/PUT/DELETE)

the scripts test a subset of the accept formats
defined for the sesame interface, for repository content

    RDF/XML   application/rdf+xml
    N-triples text/plain, application/n-triples
    TriX      application/trix
    json      application/json
    N-Quads   application/n-quads

for query results and metadata

    XML       application/sparql-results+xml
    json      application/sparql-results+json

the scripts cover variations of access privileges, content- and accept-type,
and resource existence. 
test successes are judged against canonicalized result prototypes per xmllint
and json_reformat with possible intermediate conversion via a filter into a
canonicalizable content type, while failures match agains the curl error
message. expected failures apply a constraint for text which
must appear in the response.


note that, given the [discussion](http://www.openrdf.org/issues/browse/SES-895)
on the openrdf topic, the designator for a directly referenced named graph in a
sesame request uri is the literal url. that is, it includes the "/repositories" text.
given which, the direct-reference variation is deprecated in favor of either
indirect or graph store protocol requests and all direct-reference tests expect a 404.

> The SPARQL 1.1 Graph Store HTTP Protocol is supported on a per-repository basis. 
> The functionality is accessible at <SESAME_URL>/repositories/<ID>/rdf-graphs/service 
> (for indirectly referenced named graphs), and <SESAME_URL>/repositories/<ID>/rdf-graphs/<NAME> 
> (for directly referenced named graphs). 
> A request on a directly referenced named graph entails that the request URL itself is used
> as the named graph identifier in the repository.