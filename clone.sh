#!/bin/sh

# Shell script to clone MySql database from REMOTE to LOCAL
# By Fata El Islami
# Make sure you have installed pv <<<<------

# INIT CONFIG
# ===============================

# REMOTE DB INIT
REMOTE_USER=""      # USERNAME
REMOTE_PASS=""      # PASSWORD
REMOTE_HOST=""      # HOSTNAME / IP
REMOTE_DB=""        # DATABASE NAME

# LOCAL DB INIT
DB_USER=""             # USERNAME
DB_PASS=""             # PASSWORD
DB_HOST=""             # HOSTNAME / IP
DB_NAME=""             # DATABASE NAME

DUMP_FILE="dump.sql"       # SQL DUMP FILENAME

# DEFINE PASSWORD SWITCH
if [ ! -z "$DB_PASS" ]
then
  DB_PASS_SWITCH = "-p$DB_PASS"
fi

if [ ! -z "$REMOTE_PASS" ]
then
  REMOTE_PASS_SWITCH = "-p$REMOTE_PASS"
fi

# EXE SESSIONS
# ===============================

# get remote database
mysqldump -h $REMOTE_HOST -u $REMOTE_USER $REMOTE_PASS_SWITCH $REMOTE_DB > $DUMP_FILE

# drop all tables if exist
mysqldump -u $DB_USER $DB_PASS_SWITCH \
  --add-drop-table --no-data $DB_NAME | \
  grep -e '^DROP \| FOREIGN_KEY_CHECKS' | \
  mysql -u $DB_USER $DB_PASS_SWITCH $DB_NAME

# restore new database
pv $DUMP_FILE | mysql -u $DB_USER $DB_PASS_SWITCH $DB_NAME
