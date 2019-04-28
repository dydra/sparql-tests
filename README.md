# this repository is obsolete.
# see https://github.com/dydra/http-api-tests

Dydra.com SPARQL tests
=====================

These tests define the Dydra.com SPARQL dialect. They are based heavily on the
W3C spec as well as custom tests. They are the best way to determine when and
why we deviate from the SPARQL standard.

For every known deviation from a W3C test, the W3C test remains intact
alongside, and is tagged with an rspec tag. Thus, *not every test in the
repository is expected to pass.* The failing tests are there for comparison
purposes.

To run only the tests that we would expect to pass:

    $ bundle install
    $ bundle exec rspec -cfn \
        --tag '~reduced:all' \
        --tag '~arithmetic:boxed' \
        --tag '~blank_nodes:unique' \
        --tag '~status:bug' \
        --tag '~tz:zoned' \
        spec/w3c/data-r2/

Known buggy tests are skipped with `--tag '~status:bug'`, to enable them,
remove the tag.

#### Known Quirks

The tags above represent our known quirks. W3C tests remain alongside these
tests, tagged differently, with the original W3C expectations instead of our
adjusted ones.

###### arithmetic: boxed

This tag marks tests which fail because of normalization of numeric types.
Dydra.com treats the literal "01", and many other variables of untyped
literals, as a number. Some W3C tests require the store to return the original
value, in some cases after doing arithmetic comparisons on it. A SPARQL
endpoint passing `arithmetic:boxed` tests would return the non-normalized
numeric values.

###### blank_nodes:unique

This tag marks tests which have been modified (not necessarily failing) due to
Dydra.com's treatment of blank node identifiers as canonical. Tests tagged with
`blank_nodes:unique` would be passed by a SPARQL endpoint that generates new
blank node identifiers for each serialization/query/etc.

###### reduced:all

The REDUCED modifier may or may not reduce all results. The expectations for
tests marked `reduced:all` are not reduced. Dydra.com passes tests which remove
duplicates.

###### values:lexical

Dydra.com treats some input as the lexical representations of their real
values. In particular, dates, times, and datetimes are always returned in Zulu
time, regardless of their input format. Time zone information is not saved. In
the same way, string literal language tags are normalized to a lowercase form.


