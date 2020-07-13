from bs4 import BeautifulSoup
import requests
import pandas as pd
from sqlalchemy import create_engine
from sqlalchemy.sql.expression import update
#local file with GCP SQL Credentials
from config import *


#f'postgresql+psycopg2://{SQL_USERNAME}:{SQL_PASSWORD}@{SQL_IP}:{PORT}/{DATABASE}'

class Spotify():

#    def __init__(self):        
        def webScrapeSpotify(self, region='global', chart_type='top_200', date='latest'):

            #Set Source ID
            s_id =1
            
            #Set Chart Type
            if (chart_type=='top_200'):
                c_type = 'regional'
                c_id = 2
            elif (chart_type=='viral_50'):
                c_type = 'viral'
                c_id = 1
            else:
                print(f"{chart_type} is an invalid chart type")

            #Set Region
            if (region=='global'):
                reg = 'global'
                r_id = 1
            elif (region=='us'):
                reg = 'us'
                r_id = 2
            elif (region=='uk'):
                reg = 'gb'
                r_id = 3
            else:
                print(f"{region} is an invalid region")
            
            #Set URL
            base_url = "https://spotifycharts.com/"
            url = f"{base_url}{c_type}/{reg}/daily/"   
            
            #Submit Request
            html = requests.get(url+date)

            #Create BeautifulSoup Object
            soup = BeautifulSoup(html.text, 'lxml')
            table = soup.findAll('table',{"class":"chart-table"})[0]

            #Import table to dataframe 
            df = pd.read_html(str(table), header=0)[0]
            df[['title','artist']] = df['Track'].str.split(pat = " by ", expand=True)
            df = df.drop(columns=['Unnamed: 0', 'Unnamed: 2', 'Track'])
            df.rename(columns={"Unnamed: 1":"position", "Streams":"streams"}, inplace=True)
            column_names = ["position", "title", "artist", "streams"]
            df = df.reindex(columns=column_names)
            df.insert(loc=4, column='source_id', value=s_id)
            df.insert(loc=5, column='chart_id', value=c_id)
            df.insert(loc=6, column='region_id', value=r_id)
            
           
            return df



        def loadDFintoDB(self, df, table='tracks'):
            
            #Connect to Database
            connection_string = f"postgresql+psycopg2://{SQL_USERNAME}:{SQL_PASSWORD}@{SQL_IP}:{PORT}/{DATABASE}"
            engine = create_engine(connection_string)
            conn =  engine.connect()
         
            #Load DataFrame into Database 
            df.to_sql(name=table, con=conn, if_exists='append',index=False)
            
            #Disconnect from Database
            conn.close()
            engine.dispose


        def emptyTracksTable(self, table='tracks'):
            
            #Connect to Database
            connection_string = f"postgresql+psycopg2://{SQL_USERNAME}:{SQL_PASSWORD}@{SQL_IP}:{PORT}/{DATABASE}"
            engine = create_engine(connection_string)
            conn =  engine.connect()
            
            #Query to Empty Table
            stmt =  """delete from tracks;"""
            conn.execute(stmt)
            
            #Disconnect from Database
            conn.close()
            engine.dispose