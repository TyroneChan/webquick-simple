#!/bin/sh

class="cn.chh.quick.simple.Application"

# ----------------------------------------------------------------------------
#                         DONOT EDIT !!!
#                          (TyroneChan)
# ----------------------------------------------------------------------------

# resolve links - $0 may be a softlink
PRG="$0"

while [ -h "$PRG" ]; do
  ls=`ls -ld "$PRG"`
  link=`expr "$ls" : '.*-> \(.*\)$'`
  if expr "$link" : '/.*' > /dev/null; then
    PRG="$link"
  else
    PRG=`dirname "$PRG"`/"$link"
  fi
done

PRGDIR=`dirname "$PRG"`
BASEDIR=`cd "$PRGDIR" >/dev/null; pwd`


if [ -z "$JAVA_HOME" ] ; then
        echo "ERROR: JAVA_HOME is not set !!!"
        exit 1
fi

# If a specific java binary isn't specified search for the standard 'java' binary
if [ -z "$JAVACMD" ] ; then
  if [ -n "$JAVA_HOME"  ] ; then
    if [ -x "$JAVA_HOME/jre/sh/java" ] ; then
      # IBM's JDK on AIX uses strange locations for the executables
      JAVACMD="$JAVA_HOME/jre/sh/java"
    else
      JAVACMD="$JAVA_HOME/bin/java"
    fi
  else
    JAVACMD=`which java`
  fi
fi

if [ ! -x "$JAVACMD" ] ; then
  echo "Error: JAVA_HOME is not defined correctly." 1>&2
  echo "  We cannot execute $JAVACMD" 1>&2
  exit 1
fi

if [ -z "$REPO" ]
then
  REPO="$BASEDIR"/lib
fi

CLASSPATH=$CLASSPATH_PREFIX:"$BASEDIR"/classes:"$REPO"/*

echo $CLASSPATH


#--------------------------------------------------------
# Parse options
#--------------------------------------------------------

if [ -z "$jargs" ] ; then
        jargs="-Xms128m -Xmx512m -Xss256m"
fi


logfile="stdout"
pidfile="pid"
nohup $JAVACMD $JAVA_OPTS ${jargs}  \
  -classpath "$CLASSPATH" \
  -Dapp.name="serverctl" \
  -Dapp.pid="$$" \
  -Dapp.repo="$REPO" \
  -Dapp.home="$BASEDIR" \
  -Dbasedir="$BASEDIR" \
  ${class} \
  "$@" > $logfile 2>&1 &

#save PID to file
pid=$!
cat /dev/null > $pidfile
echo ${pid} >> $pidfile

tail -f $logfile
