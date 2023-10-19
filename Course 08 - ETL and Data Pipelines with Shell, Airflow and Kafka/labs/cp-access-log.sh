# cp-access-log.sh
# This script downloads the file 'web-server-access-log.txt.gz'
# from "https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0250EN-SkillsNetwork/labs/Bash%20Scripting/ETL%20using%20shell%20scripting/".

# The script then extracts the .txt file using gunzip.

# The .txt file contains the timestamp, latitude, longitude 
# and visitor id apart from other data.

# Transforms the text delimeter from "#" to "," and saves to a csv file.
# Loads the data from the CSV file into the table 'access_log' in PostgreSQL database.
# Start the Postgres server.

# `start_postgres`
# Download the access log file

# `Create the table.`

#1. psql --username=postgres --host=localhost
#2. RUN THIS COMMAND \c template1; TO CONNECT TO THE DATABASE ‘template1’
#3. CREATE TABLE access_log(timestamp TIMESTAMP, latitude float, longitude float, visitor_id char(37));
# 4. RUN THIS COMMAND \q TO QUIT THE PSQL TERMINAL


wget "https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0250EN-SkillsNetwork/labs/Bash%20Scripting/ETL%20using%20shell%20scripting/web-server-access-log.txt.gz"

# Unzip the file to extract the .txt file.
# The -f option of gunzip is to overwrite the file if it already exists.
gunzip -f web-server-access-log.txt.gz

# Extract phase

echo "Extracting data"

# Extract the columns 1 (timestamp), 2 (latitude), 3 (longitude) and 
# 4 (visitorid)

cut -d"#" -f1-4 web-server-access-log.txt > extracted-data.txt 

# run bash cp-access-log.sh


# Transform phase
echo "Transforming data"

# read the extracted data and replace the colons with commas.
tr "#" "," < extracted-data.txt

# run bash cp-access-log.sh

# Now we need to save the transformed data to a .csv file.

echo "Saving the file as a csv format"

tr "#"  "," < extracted-data.txt > transformed-data.csv

# Load the data into the table access_log in PostgreSQL
# synthax: COPY table_name FROM 'filename' DELIMITERS 'delimiter_character' FORMAT;

echo "Load the data into the table access_log in PostgreSQL"

# Load phase
echo "Loading data"

# Send the instructions to connect to 'template1' and
# copy the file to the table 'access_log' through command pipeline.

echo "\c template1;\COPY access_log  FROM '/home/project/transformed-data.csv' DELIMITERS ',' CSV HEADER;" | psql --username=postgres --host=localhost

# RUN bash cp-access-log.sh

# Verify by querying the database

echo '\c template1; \\SELECT * from access_log;' | psql --username=postgres --host=localhost