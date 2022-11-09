import glob                         # this module helps in selecting files 
import pandas as pd                 # this module helps in processing CSV files
import xml.etree.ElementTree as ET  # this module helps in processing XML files.
from datetime import datetime
from extract_load import csv_loader, extract_from_json, extract_from_xml

class Transform:

    def transform(self, data):
        #Convert height which is in inches to millimeter
        #Convert the datatype of the column into float
        #data.height = data.height.astype(float)
        #Convert inches to meters and round off to two decimals(one inch is 0.0254 meters)
        data['height']= round(data.height * 0.0254,2)

        #Convert weight which is in pounds to kilograms
        #Convert the datatype of the column into float
        #data.weight = data.weight.astype(float)
        #Convert pounds to kilograms and round off to two decimals(one pound is 0.45359237 kilograms)
        data['weight']= round(data.weight * 0.45359237, 2 )
        return data

    def load(self, targetfile, data_to_load):
        data_to_load.to_csv(targetfile)
    
    def log(self, message):
        timestamp_format = '%Y-%h-%d-%H:%M:%S' # Year-Monthname-Day-Hour-Minute-Second
        now = datetime.now() # get current timestamp
        timestamp = now.strftime(timestamp_format)
        with open("logfile.txt","a") as f:
            f.write(timestamp + ',' + message + '\n')