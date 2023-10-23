from datetime import timedelta
from airflow import DAG
from airflow.operators.bash_operator import BashOperator
# This makes scheduling easy
from airflow.utils.dates import days_ago

#defining DAG arguments
default_args= {

    'owner': 'Nuiyomukiza Thamar',
    'start_date': days_ago(0),
    'email':['thamarniyo@gmail.com'],
    'email_on_failure': True,
    'email_on_retry': True,
    'retries': 1,
    'retry_delay': 5
}

# defining the DAG
dag = DAG(
   ' ETL_toll_data',
    default_args = default_args,
    description = ' Apache Airflow Final Assignment',
    schedule_interval= timedelta(days=1)

)

# unzip_data 

unzip_data = BashOperator(
    task_id= 'BashOperator',
    bash_command= 'tar  -zxf /home/project/airflow/dags/finalassignment/talldata.tgz',
    dag= dag,

)

# extract_data_from_csv

extract_data_from_csv= BashOperator(
    task_id= 'extract_data_from_csv',
    bash_command= 'cut -d "," -f1-4 vehicle-data.csv > csv_data.csv',
    dag= dag,

)

# extract_data_from_tsv

extract_data_from_tsv= BashOperator(
    task_id= 'extract_data_from_tsv',
    bash_command= 'cut  -f5-7 tollplaza-data.tsv > tsv_data.csv',
    dag= dag,

)

# Create a task to extract data from fixed width file

extract_data_from_fixed_width=BashOperator(
    task_id= 'extract_data_from_fixed_width',
    bash_command= 'cut -c59-67 payment-data.txt | tr " "  "," > fixed_width_data.csv',
    dag= dag,
)

#  Create a task to consolidate data extracted from previous tasks
# Create a task named consolidate_data.

# This task should create a single csv file named extracted_data.csv by combining data from the following file


consolidate_data=BashOperator(
    task_id= 'consolidate_data',
    bash_command= 'paste csv_data.csv tsv_data.csv fixed_width_data.csv > extracted_data.csv',
    dag= dag,
)

# Transform and load the data
# Create a task named transform_data

transform_data=BashOperator(
    task_id= 'transform_data',
    bash_command= 'tr "[a-z]" "[A-Z]"< extracted_data.csv > transformed_data.csv ',
    dag= dag,
)

# Define the task pipeline
unzip_data >> extract_data_from_csv >> extract_data_from_tsv >> extract_data_from_fixed_width\
     >> consolidate_data >> transform_data

