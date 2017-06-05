#!/bin/sh
PROJECT="YOUR_PROJECT_FOLDER"
DATABASE="YOUR_DATABASE_NAME"
DATABASE_USER="YOUT_DATABASE_USER"

#Folder name ex: 2017-01-01-19.00.00
FOLDER=$(date +"%Y-%m-%d-%H.%M.%S")

mkdir $FOLDER
cd $FOLDER
echo "Starting copy..."
cp -R /var/www/$PROJECT $PROJECT
echo "Copy completed!"
echo "Starting dump..."
pg_dump $DATABASE --inserts --column-inserts --file=dump.sql --format=p --no-owner --no-privileges --host=localhost -U $DATABASE_USER -w
echo "Dump completed"
mv dump.sql $PROJECT/tmp/
cd ..
echo "Starting compression..."
tar cjpfj $FOLDER.tar.bz2 $FOLDER
echo "Compression completed"
echo "Removing temp files.."
rm -rf $FOLDER
echo "Process concluded!"
