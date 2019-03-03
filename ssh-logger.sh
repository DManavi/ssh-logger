#!/bin/bash


# Calculate script path

# Source locator script has copied from https://stackoverflow.com/questions/59895/getting-the-source-directory-of-a-bash-script-from-within

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do
  TARGET="$(readlink "$SOURCE")"
  if [[ $TARGET == /* ]]; then
    SOURCE="$TARGET"
  else
    DIR="$( dirname "$SOURCE" )"
    SOURCE="$DIR/$TARGET"
  fi
done

RDIR="$( dirname "$SOURCE" )"
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

#echo "DIR is '$DIR'"
DATE=$(date '+%Y-%m-%d');

if [! -d $DIR/logs ]; then
  mkdir $DIR/logs;
fi

LOG_FILE=$DIR/logs/$1-$DATE.log;

echo 'Saving log to "'$LOG_FILE'"';

START_TIME=$(date '+%Y-%m-%d %H:%M:%S');

echo $START_TIME" Starting SSH session..." >> $LOG_FILE;


ssh $* |& tee -a $LOG_FILE


END_TIME=$(date '+%Y-%m-%d %H:%M:%S');

echo $END_TIME" SSH session has been terminated normally." >> $LOG_FILE;
