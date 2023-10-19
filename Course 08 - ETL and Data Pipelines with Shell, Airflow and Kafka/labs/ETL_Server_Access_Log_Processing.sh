#!/bin/bash
echo "extract_transform_load"
# cut command to extract the fields timestamp and visitorid writes to a new file extracted.txt
cut -f1,4 -d"#" /home/project/airflow/dags/web-server-access-log.txt > /home/project/airflow/dags/extracted.txt

# tr command to transform by capitalizing the visitorid.
tr "[a-z]" "[A-Z]" < /home/project/airflow/dags/extracted.txt > /home/project/airflow/dags/capitalized.txt

# tar command to compress the extracted and transformed data.
tar -czvf /home/project/airflow/dags/log.tar.gz /home/project/airflow/dags/capitalized.txt


Note: While submitting the dag that was created in the previous exercise, use sudo in the terminal before the command used to submit the dag.


#  cp my_first_dag.py $AIRFLOW_HOME/dags
# Copied!
# Next, run the command below one by one to submit shell script in the dags folder and to change the permission for reading shell script.

#  cp my_first_dag.sh $AIRFLOW_HOME/dags
#  cd airflow/dags
#  chmod 777 my_first_dag.sh

# Verify that our DAG actually got submitted.

# Run the command below to list out all the existing DAGs.

# airflow dags list

# Verify that my-first-dag is a part of the output.


# airflow dags list|grep "my-first-dag"

# You should see your DAG name in the output.

# Run the command below to list out all the tasks in my-first-dag.


# airflow tasks list my-first-dag