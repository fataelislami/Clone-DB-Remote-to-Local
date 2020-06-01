# DB Cloner Shell Script!

This shell script is especially for the geeks who deal with multiple server environtment and want to run some test on a production database, but without affecting data itself, all you need is **DB Cloner** to make sure the environment are equally matched, let's play, hope it help!


# Requirements
1.Pipe Viewer
Pipe viewer is a terminal-based tool for monitoring the progress of data through a pipeline

    sudo apt-get install pv

pv dumps the `yourdbbackup.sql` and passes them to mysql (because of the pipe operator). While it is dumping, it shows the progress. The cool thing is that mysql takes the data only as fast as it can progress it, so pv can show the progress of the import.

2.Change the permission of clone.sh to 755

    chmod 755 clone.sh

## Configuration
The script can easily be configured using the variables at the top of the script. These should be self-explanatory, and comments haven been included in the script to give you some more information. However, if you need assistants, leave a comment.

**Remote db config**

    REMOTE_USER="" # USERNAME
    REMOTE_PASS="" # PASSWORD
    REMOTE_HOST="" # HOSTNAME / IP
    REMOTE_DB=""   # DATABASE NAME

**Local db config**

    DB_USER=""  # USERNAME
    DB_PASS=""  # PASSWORD
    DB_HOST=""  # HOSTNAME
    DB_NAME=""  # DATABASE NAME
    
## Run

After the above step have completely matched with your config, 
Let's run this script with:

    ./clone.sh

The script will output the progress meter if it runs successfully, but it will output errors if something goes wrong. Errors you may see include MySQL connection errors, user / password errors etc. If you can’t connect to the remote database:

-   make sure you have remote access to the database – the MySQL setup on remote host may only allow local connections
-   make sure the host / IP / port / username / password / database name are correct for the remote and local connections
-   make sure the firewall allows remote connections to the database / port
