This is a private README file. Don't push it to the public branch.

To run tests, copy the following into a shell:

export DYDRA_URL=http://hetzner.dydra.com
export ACCOUNT=jhacker              # See below
export DYDRA_TOKEN=$YOUR_TOKEN

bundle install
bundle exec rspec -cfn \
        --tag '~reduced:all' \
        --tag '~arithmetic:boxed' \
        --tag '~blank_nodes:unique' \
        --tag '~status:bug' \
        --tag '~tz:zoned' \
        spec/w3c

## OPTIONS:
export DEBUG=1   # display tons of debug information
export CREATE=1  # create repositories as you go. Won't hurt anything if they
                 # exist, but its slower. Needed for the first time you use an
                 # account. Implies IMPORT=1
export IMPORT=1  # Clear repositories and re-import test data as you go.
export ACCOUNT=jhacker # Your DYDRA_TOKEN determines what permission you'll
                       # have while running the tests, but the ACCOUNT variable
                       # determines which user's account the repositories are under.

## TEST SETS
inside the spec directory are a number of subdirectories:
 spec/
   w3c/         # All w3c tests
     /data-r2   # sparql 1.0
     /sparql11  # sparql 1.1
   /datagraph   # various regression tests initially found in production. Some quite large.
   /sp2b        # sp2b benchmarks
   /ssf         # obsolete ssf versions of 1.0 queries

## HELPFUL STUFF
I find the following shell aliases profoundly useful; they are in my bash_profile. Source them into your shell:

alias dydra-local='export DYDRA_URL=http://localhost:3000 ; rm -f ~/.dydra/credentials ; ln -s ~/.dydra/localhost ~/.dydra/credentials'
alias dydra-james='export DYDRA_URL=http://james.dydra.com ;rm -f ~/.dydra/credentials ;  ln -s ~/.dydra/james ~/.dydra/credentials'
alias dydra-staging='export DYDRA_URL=http://staging.dydra.com ;rm -f ~/.dydra/credentials ;  ln -s ~/.dydra/staging ~/.dydra/credentials'
alias dydra-hetzner='export DYDRA_URL=http://hetzner.dydra.com ;rm -f ~/.dydra/credentials ;  ln -s ~/.dydra/hetzner ~/.dydra/credentials'
alias dydra-production='export DYDRA_URL=http://dydra.com ;rm -f  ~/.dydra/credentials ;  ln -s ~/.dydra/production ~/.dydra/credentials'

Then do, for example:

dydra-hetzner
dydra login # you only need to do this once.

From then on, 'dydra-hetzner' will have you ready to talk to hetzner, whether
with the installed CLI gem ('dydra list') or for the tests ('rspec spec...').




