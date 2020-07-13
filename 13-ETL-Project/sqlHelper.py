import numpy as np
import pandas as pd
from sqlalchemy import create_engine
#local file with GCP SQL Credentials
from config import *


#f'postgresql+psycopg2://{SQL_USERNAME}:{SQL_PASSWORD}@{SQL_IP}:{PORT}/{DATABASE}'

class SQLHelper():

    def __init__(self):
        #self.connection_string = 'postgresql+psycopg2://spotify_etl:spotify@34.72.119.22:5432:/spotify_etl'
        #self.engine = create_engine(connection_string)


        def getTop200Global(self):
            #Connect to Database
            connection_string = f"postgresql+psycopg2://{SQL_USERNAME}:{SQL_PASSWORD}@{SQL_IP}:{PORT}/{DATABASE}"
            engine = create_engine(connection_string)
            conn =  engine.connect()

            #Define SQL Query
            query = f"""
                        select
                            t."position",
                            t.title,
                            t.artist,
                            t.streams,
                            c.chart_name,
                            r.region_name, 
                            t.last_updated 
                        from 
                            "tracks" t
                            join "chart_type" c on t.chart_id = c.chart_id
                            join "region" r on t.region_id = r.region_id 
                        where
                            t.chart_id = 2 and t.region_id = 1
                        order by
                            t."position" 
                        limit 10;
                    """

            #Execute Query & Close Connection
            conn = self.engine.connect()
            df = pd.read_sql(query, conn)
            conn.close()

            return df


            def emptyTracksTable(self, table='tracks'):

                #Connect to Database
                connection_string = f"postgresql+psycopg2://{SQL_USERNAME}:{SQL_PASSWORD}@{SQL_IP}:{PORT}/{DATABASE}"
                engine = create_engine(connection_string)
                conn =  engine.connect()

                #Query to Empty Table
                query = """
                            DELETE 
                                *
                            FROM
                                tracks;
                        """

                #Execute query 
                pd.read_sql(query, con=conn)

                #Disconnect from Database
                conn.close()
                engine.dispose