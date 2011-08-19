#! /bin/bash 

if [[ (("${1}NO" == "NO") || ("${1}" == "ALL")) ]]
then
  REPOSITORY='sp2b-10k sp2b-50k sp2b-250k sp2b-1m'
else
  REPOSITORY="${1}"
fi

if [[ (("${2}NO" == "NO") || ("${2}" == "ALL")) ]]
then
  QUERY='q1 q2 q3a q3b q3c q4 q5a q5a-sameTerm q5b q6 q7 q8 q9 q10 q11 q12a q12b q12c'
else
  QUERY="${2}"
fi

if [[ ("${3}NO" == "NO") ]]
then
  COUNT=1
else
  COUNT="${3}"
fi

echo  repository ">$REPOSITORY<" query ">$QUERY<" count ">$COUNT<"

for query in  $QUERY ; do
  for repository in $REPOSITORY; do
    for ((count = 1; count <= ${COUNT}; count = count +1)); do
      echo "${query}@${repository} pass ${count}/${COUNT}"
      ( REPOSITORY=$repository NOCOMPARE=1 rspec -cfn sp2b/${query}_spec.rb) ;
      #echo "wait for cache quiesence? (return to continue)... "
      #read
      done;
    done;
  done;

