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

# EXE SESSIONS
# ===============================

# get remote database

if [ "$DB_PASS" == "" ];
then
  mysqldump -h $REMOTE_HOST -u $REMOTE_USER $REMOTE_DB > $DUMP_FILE
else
  mysqldump -h $REMOTE_HOST -u $REMOTE_USER -p$REMOTE_PASS $REMOTE_DB > $DUMP_FILE
fi

# # drop all tables if exist

if [ "$DB_PASS" == "" ];
then
  mysqldump -u $DB_USER \
    --add-drop-table --no-data $DB_NAME | \
    grep -e '^DROP \| FOREIGN_KEY_CHECKS' | \
    mysql -u $DB_USER $DB_NAME
else
  mysqldump -u $DB_USER -p$DB_PASS \
    --add-drop-table --no-data $DB_NAME | \
    grep -e '^DROP \| FOREIGN_KEY_CHECKS' | \
    mysql -u $DB_USER -p$DB_PASS $DB_NAME
fi

# # restore new database

if [ "$DB_PASS" == "" ];
then
  pv $DUMP_FILE | mysql -u $DB_USER $DB_NAME
else
  pv $DUMP_FILE | mysql -u $DB_USER -p$DB_PASS $DB_NAME
fi
