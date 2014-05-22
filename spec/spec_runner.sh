#! /bin/bash 

PASSES=1
CLIENTS=1
FORMATTER=""
TAGS='--tag ~reduced:all --tag ~arithmetic:literal  --tag ~blank_nodes:unique  --tag ~values:lexical --tag ~status:bug --tag ~tz:zoned --tag ~string:typed --tag ~date:unsupported --tag ~undefined:unbound --tag ~join:full --tag ~implementation:nyi --tag ~vocabulary:lenient'
ARGUMENTS=`getopt -o "c:p:f:t:" -- "$@"`
eval set -- "$ARGUMENTS"
while true; do
  case "$1" in
    -p) PASSES="$2"; shift 2;;
    -c) CLIENTS="$2"; shift 2;;
    -f) case "$2" in
          ( csv | CSVFormatter)
             FORMATTER="--require support/formatters/csv_formatter.rb -f CSVFormatter";
             shift 2;;
          ( html | HTMLFormatter)
            FORMATTER="--require support/formatters/html_formatter.rb -f HTMLFormatter";
            shift 2;;
          ( doc )
            FORMATTER="-f doc";
            shift 2;;
          *)
            echo "'$@'";
	    FORMATTER="-f ${2}" ;
            echo "FORMATTER = '${FORMATTER}'" ;
            shift 2;
            echo "@= '$@'";
            echo "*= '${*}'";;
        esac;;
    -t) TAGS="$2"; shift 2;;
    --) shift; break;;
  esac
done

for ((pass = 1; pass <= $PASSES; pass = pass + 1)); do
  echo ""
  for ((client = 1; client <= $CLIENTS; client = client + 1)); do
    date
    echo "run ${pass}.${client}: $TAGS $FORMATTER $*"
    (nice bundle exec rspec ${TAGS}  $FORMATTER $* )&
  done;
  wait;
done;

