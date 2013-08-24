test rest interface as per the openrdf rest protocol
[description](http://www.openrdf.org/doc/sesame2/system/ch08.html).

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

the scripts tests only a subset of the accept formats
defined for the sesame interface,

    RDF/XML   application/rdf+xml
    N-triples text/plain, application/n-triples
    TriX      application/trix

but adds n-quads and json

    N-Quads   application/n-quads
    json      application/json

