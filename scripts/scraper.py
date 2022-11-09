
from bs4 import BeautifulSoup
import html5lib
import requests
import pandas as pd
import warnings
import sys
import os
warnings.filterwarnings("ignore")
sys.path.append(os.path.abspath(os.path.join('../scripts')))


def data_scaper(df,html_data):
    soup=BeautifulSoup(html_data,"html5lib")
    for row in soup.find_all('tbody')[2].find_all('tr'):
        col = row.find_all('td')
        try:
            if col:
                # print(col[1].find_all('a')[1].text)
                bank_name = col[1].find_all("a")[1].text
                market_cap = float(col[2].text.split('[')[0].replace(',',""))
                df=df.append({"Name": bank_name,
                                "Market Cap (US$ Billion)": market_cap}, ignore_index=True)
        except IndexError:
            continue
    return df