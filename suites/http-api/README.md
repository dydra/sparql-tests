
# http api tests

These tests exercise the sesame rest api, as per the openrdf "http communication protocol"
[description](http://www.openrdf.org/doc/sesame2/system/ch08.html)
[or](http://openrdf.callimachus.net/sesame/2.7/docs/system.docbook?view#chapter-http-protocol)
and the "sparlq 1.1 graph store http protocol", as per the
[specification](http://www.w3.org/TR/sparql11-http-rdf-update/).

The script `script_runner.sh` searches for all `.sh` scripts in the tree,
runs each in turn, reports errors, and returns the error count as its result.
The scripts are arranged in directories which reflect the protocol resource paths.
The account (`openrdf-sesame`) and repository (`mem-rdf`) are defined such that,
for the sesame protocol tests, the openrdf documentation examples should
apply, as given in its documentation.

For the v2.0 sesame protocol, the concrete resources, with reference to
the described overview:

        ${STORE_URL}/${STORE_ACCOUNT}
        /protocol                : protocol version (GET)
        /repositories            : overview of available repositories (GET)
	/${STORE_REPOSITORY}     : query evaluation and administration tasks on 
			           a repository (GET/POST/DELETE)
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

The compact graph store patterns provide and alternative, less encumbered means
to address the resource and its content:

        ${STORE_URL}/${STORE_ACCOUNT}
          /${STORE_REPOSITORY}
          /${STORE_REPOSITORY}?default
          /${STORE_REPOSITORY}?graph=${STORE_IGRAPH}
          /${STORE_REPOSITORY}/${STORE_RGRAPH}


In addition to these paths, the account and repository metadata is located along a path
distinct from possible repository linked-data resources:

        ${STORE_URL}/accounts/${STORE_ACCOUNT}
        /repositories
          /${STORE_REPOSITORY}
            /settings            : name, homepage, summary, description, and license url
            /collaborations      : enumerated collaborator account read/write privliges
            /context_terms       : respective extent of the default and named graps
            /describe_settings   : description mode and navigation depth
            /prefixes            : default namespace prefix bindings (cf. sesame namespaces)
            /privacy             : repository privacy setting
            /provenance_repository : respective provenanace repository identifier
            /undefined_variable_behaviour : disposition for queries with unbound variables


The scripts test a subset of the accept formats
- for repository content

    RDF/XML   application/rdf+xml
    N-triples text/plain, application/n-triples
    TriX      application/trix
    json      application/json
    N-Quads   application/n-quads

- for query results and metadata

    XML       application/sparql-results+xml
    json      application/sparql-results+json

The scripts cover variations of access privileges, content- and accept-type,
and resource existence. 
Test successes are judged against either against the HTTP status code, or, for
requests with response content, against result prototypes as canonicalized per xmllint
and json_reformat. Test failures match against the HTTP status code.


## graph store support through the sesame http protocol

the graph store support under [sesame](http://www.openrdf.org/doc/sesame2/system/ch08.html#d0e659)
provides two resource patterns. 

  <SESAME_URL>/repositories/<ID>/rdf-graphs/service
  <SESAME_URL>/repositories/<ID>/rdf-graphs/<NAME>

the first, for which the path ends in `service`, requires an additional `graph` query argument
to designated the referenced graph indirectly, while in the second case, the request url itself
designates that graph.

note that, given the [discussion](http://www.openrdf.org/issues/browse/SES-895)
on the openrdf topic, the designator for a directly referenced named graph in a
sesame request uri is the literal url. that is, it includes the "/repositories" text.

> The SPARQL 1.1 Graph Store HTTP Protocol is supported on a per-repository basis. 
> The functionality is accessible at <SESAME_URL>/repositories/<ID>/rdf-graphs/service 
> (for indirectly referenced named graphs), and <SESAME_URL>/repositories/<ID>/rdf-graphs/<NAME> 
> (for directly referenced named graphs). 
> A request on a directly referenced named graph entails that the request URL itself is used
> as the named graph identifier in the repository.


### designating DYDRA resources

For a repository on a DYDRA host, the sesame request patterns manifest in terms of the host authority, the
user account and the repository name

    <HTTP-HOST>/<ACCOUNT-NAME>/repositories/<REPOSITORY-NAME>/service
    <HTTP-HOST>/<ACCOUNT-NAME>/repositories/<REPOSITORY-NAME>/<NAME>

the consequence is that, in order to designate the repository as a whole, the sesame request url must take a form

    <HTTP-HOST>/<ACCOUNT-NAME>/repositories/<REPOSITORY-NAME>/service?graph=<HTTP-HOST>/<ACCOUNT-NAME>/<REPOSITORY-NAME>

and the default graph is designated as

    <HTTP-HOST>/<ACCOUNT-NAME>/repositories/<REPOSITORY-NAME>/service?default

while a request of the form

    <HTTP-HOST>/<ACCOUNT-NAME>/repositories/<REPOSITORY-NAME>/<NAME>

designate exactly that named graph in the store.


## native graph store support

For a repository on a DYDRA host, the native request patterns comprise just the host authority, the
user account and the repository name

    <HTTP-HOST>/<ACCOUNT-NAME>/<REPOSITORY-NAME>

with respect to which, the default graph is designated as

    <HTTP-HOST>/<ACCOUNT-NAME>/<REPOSITORY-NAME>?default

and an indirect graph reference takes the form

    <HTTP-HOST>/<ACCOUNT-NAME>/<REPOSITORY-NAME>?graph=<graph>

## linked data designators

In addition to the root repository graph, it is also possible to link directly to
an arbitrary directly designated graph which extends beyon the root

    <HTTP-HOST>/<ACCOUNT-NAME>/<REPOSITORY-NAME>/<FURTHER>/<PATH>/<STEPS>


### graph store content types

The `multipart/form-data` request content type described in the graph store
[protocol](http://www.w3.org/TR/2013/REC-sparql11-http-rdf-update-20130321/#graph-management)
is not supported. Each request must target an individual graph.

The `application/x-www-form-url-encoded` request type is supported for `GET` requests only, as described in the sparql
protocol for [query](http://www.w3.org/TR/2013/REC-sparql11-protocol-20130321/#query-via-post-urlencoded)
 and [update](http://www.w3.org/TR/2013/REC-sparql11-protocol-20130321/#update-via-post-urlencoded) operations. 

## triples, quads and named graph in import requests

The graph store management operations which involve an RDF payload - `PATCH`, `POST`, and `PUT`,
permit a request to target a specific graph as described above, as well as to transfer graph content
as trix or nquads in order to stipulate the target graph for statements in the payload document itself.
The protocol and document specifications are not exclusive.
When both appear, the graph encoded in the document supersedes that specified in the protocol request
with respect to the destination graph, while the protocol graph specifies which graph ist to be cleared by a put
The combinations yield the following effects:

<table  border=0 cellpadding=2px cellspacing=0 >

<td class=hd>
<td >protocol graph designator<td  >content type<td  >statement graph designator<td  >effective graph</tr>
<tr >
<td class=hd>
<td >-<td>n-triple, rdf<td >-<td >-</tr>
<tr >
<td class=hd>
<td >-<td>n-quad, trix<td >-<td >-</tr>
<tr >
<td class=hd>
<td >-<td>n-triple, rdf<td>&lt;statement&gt; : invalid<td><i>skipped</i></tr>
<tr >
<td class=hd>
<td >-<td>n-quad, trix<td>&lt;statement&gt;<td>&lt;statement&gt;</tr>
<tr >
<td class=hd>
<td  >?default<td>n-triple, rdf<td >-<td >-</tr>
<tr >
<td class=hd>
<td  >?default<td>n-quad, trix<td >-<td >-</tr>
<tr >
<td class=hd>
<td  >?default<td>n-triple, rdf<td>&lt;statement&gt; : invalid<td><i>skipped</i></tr>
<tr >
<td class=hd>
<td  >?default<td>n-quad, trix<td>&lt;statement&gt;<td>&lt;statement&gt;</tr>
<tr >
<td class=hd>
<td  >?graph=&lt;protocol&gt;<td>n-triple, rdf<td >-<td>&lt;protocol&gt;</tr>
<tr >
<td class=hd>
<td  >?graph=&lt;protocol&gt;<td>n-quad, trix<td >-<td>&lt;statement&gt;</tr>
<tr >
<td class=hd>
<td  >?graph=&lt;protocol&gt;<td>n-triple, rdf<td>&lt;statement&gt; : invalid<td><i>skipped</i></tr>
<tr >
<td class=hd>
<td  >?graph=&lt;protocol&gt;<td>n-quad, trix<td>&lt;statement&gt;<td>&lt;statement&gt;</tr>
</table>


In order to validate the results, one script exists for the PUT operations for
each of the combinations, named according to the pattern

  PUT-<protocolGraph>-<contentType>.sh

which performs a PUT request of the respective graph and content type combination
and validates the content of a subsequent GET
against the expected store content. The combination features are indicated as

 - protocolGraph : direct, default, graph (indirect)
 - contentType : n-triples, n-quads, rdf, turtle, trix

whereby, just the combinations for `PUT-direct` validate the full content type complement and,
among these, the cases like `PUT-default-nquads` intend to demonstrate the
effect when the payload or request content type does not correspond to the protocol target graph.
In addition, for ntriples and nguads content types, the acutual document contains both triples and quads
in order to demonstrate the consequence of the statement's given content on its destination.

<table>
<tr><th>script</th><th>result</th><th>test</th></tr>

<tr><td>POST-default-nquads.sh</td>
    <td>PUT-default-nquads-GET-response.nq</td>
    <td>each statement (default and context) is added to its respective statement context.
        </td>
    </tr>
<tr><td>POST-default-ntriples.sh</td>
    <td>POST-default-ntriples-GET-response.nt</td>
    <td>the default statement is added to the default graph.</td>
    </tr>
<tr><td>POST-direct-nquads.sh</td>
    <td>PUT-direct-nquads-GET-response.nq</td>
    <td>each statement (default and context) is added to its respective statement context.
        </td>
    </tr>
<tr><td>POST-direct-ntriples.sh</td>
    <td>POST-direct-triples-GET-response.nq</td>
    <td>the default statement is added to the default graph.</td>
    </tr>
<tr><td>POST-graph-nquads.sh</td>
    <td>POST-graph-nquads-GET-response.nq</td>
    <td>each statement (default and context) is added to its respective statement context.
        that is, <span style='color: red'>the default statement is not added to the protocol graph</span>.</td>
    </tr>
<tr><td>POST-graph-ntriples.sh</td>
    <td>POST-graph-ntriples-GET-response.nq</td>
    <td>the default statement is added to the named (indirectly specified) graph.</td>
    </tr>

<tr><td>PUT-default-nquads.sh</td>
    <td>PUT-default-nquads-GET-response.nq</td>
    <td>each statement (default and context) is added to its respective statement context.
        </td>
    </tr>
<tr><td>PUT-default-nquads-as-ntriples</td>
    <td>PUT-default-nquads-GET-response.nq</td>
    <td>the default graph only is cleared, which means the extant named graph remains.
        the default statement is added to the default (indirectly specified) graph.
        the context statement is added to its respective graph.</td>
    </tr>
<tr><td>PUT-default-ntriples.sh</td>
    <td>PUT.nt</td>
    <td>the default graph only is cleared, which means the extant named graph remains.
        the default statement is added to the default graph.</td>
    </tr>

<tr><td>PUT-direct-json.sh</td>
    <td>PUT.rj</td>
    <td><span style="color: red">400: bad request</span></td>
    </tr>
<tr><td>PUT-direct-nquads.sh</td>
    <td>PUT.nq</td>
    <td>the repository is cleared.
        each statement (default and context) is added to its respective statement context.</td>
    </tr>
<tr><td>PUT-direct-nquads-as-ntriples</td>
    <td>PUT-graph-nquads-as-ntriples-GET-response.nq</td>
    <td>the repository is cleared.
        each statement (default and context) is added to its respective statement context</td>
    </tr>
<tr><td>PUT-direct-trig.sh</td>
    <td>PUT.trig</td>
    <td><span style="color: red">400: bad request</span></td>
    </tr>
<tr><td>PUT-direct-triples.sh</td>
    <td>PUT.nt</td>
    <td>the repository is cleared.
        the default statement is added to the default graph.</td>
    </tr>
<tr><td>PUT-direct-trix.sh</td>
    <td>PUT.trix</td>
    <td><span style="color: red">400: bad request</span></td>
    </tr>
<tr><td>PUT-direct-turtle.sh</td>
    <td>PUT.nt</td>
    <td>the repository is cleared.
        the default statement is added to the default graph.</td>
    </tr>

<tr><td>PUT-graph-nquads.sh</td>
    <td>PUT-graph-nquads-GET-response.nq</td>
    <td>the named (indirectly specified) graph is cleared, which means the extant default and named graphs remain.
        each statement (default and context) is added to its respective statement context.
        that is, <span style='color: red'>the default statement is not added to the protocol graph</span>.</td>
    </tr>
<tr><td>PUT-graph-triples.sh</td>
    <td>PUT-graph-ntriples-GET-response.nq</td>
    <td>the named (indirectly specified) graph is cleared, which means the extant default and named graphs remain.
        the default statement is added to named (indirectly specified) graph.</td>
    </tr>
<tr><td>PUT-graph=direct-nquads.sh</td>
    <td>PUT.nq</td>
    <td>the repository is cleared.
        each statement (default and context) is added to its respective statement context</td>
    </tr>
<tr><td>PUT-graph-nquads-as-ntriples</td>
    <td>PUT-graph-nquads-as-ntriples-GET-response.nq</td>
    <td>the named (indirectly specified) graph is cleared, which means the extant default and named graphs remain.
        all statements (default and context) go into the named (indirectly specified) graph.</td>
    </tr>



</table>
