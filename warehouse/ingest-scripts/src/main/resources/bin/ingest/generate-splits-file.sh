#!/bin/bash

if [[ `uname` == "Darwin" ]]; then
        THIS_SCRIPT=`python -c 'import os,sys;print os.path.realpath(sys.argv[1])' $0`
else
        THIS_SCRIPT=`readlink -f $0`
fi
THIS_DIR="${THIS_SCRIPT%/*}"
cd $THIS_DIR

. ./ingest-libs.sh

export ACCUMULO_OTHER_OPTS="${ACCUMULO_OTHER_OPTS} $HADOOP_INGEST_OPTS"

ADDJARS="$( cd ../../lib && pwd )/.*.jar"

$WAREHOUSE_ACCUMULO_HOME/bin/accumulo -add $ADDJARS jar ../../lib/datawave-ingest-core-$INGEST_VERSION.jar datawave.ingest.util.GenerateSplitsFile -u $USERNAME -p $PASSWORD -i $WAREHOUSE_INSTANCE_NAME -zk $WAREHOUSE_ZOOKEEPERS \
-cd `readlink -f $CONF_DIR`
