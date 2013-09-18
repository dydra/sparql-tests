
# web ui tests

Test web operations which support account and repository manipulation through the web interface.
The routes graft onto those from the sesame api.

        ${STORE_URL}/${STORE_ACCOUNT}
        /repositories            : (see sesame api)
	/${STORE_REPOSITORY}     : (see sesame api)
            /statements          : repository statements (GET/POST/PUT/DELETE)
            /contexts            : context overview (GET)
            /size                : #statements in repository (GET)
            /rdf-graphs          : named graphs overview (GET)
                /service         : Graph Store operations on indirectly referenced named graphs 
                                   in repository (GET/PUT/POST/DELETE)
                                   includes the query argument graph=${STORE_IGRAPH}
                /${STORE_DGRAPH> : Graph Store operations on directly referenced named graphs 
                                   in repository (GET/PUT/POST/DELETE)
            /namespaces          : overview of namespace definitions (GET/DELETE)
                /${STORE_PREFIX} : namespace-prefix definition (GET/PUT/DELETE)
