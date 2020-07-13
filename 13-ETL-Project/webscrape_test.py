import numpy as np
import pandas as pd
import json
#Import custom class with functions to WebScrape & Load SQL Database
from spotify import Spotify


spotify = Spotify()

#Empty Existing Records in Table
print('Empty Existing Records in Table')
spotify.emptyTracksTable()
print()

#Create DataFrames from Top200 & Viral 50 Charts
#data = spotify.webScrapeSpotify()
print('Scraping Spotify Top 200 Global')
df = spotify.webScrapeSpotify()
print(df.head())
print('\n')

print('Scraping Spotify Top 200 US')
df_us = spotify.webScrapeSpotify('us')
print(df_us.head())
print('\n')

print('Scraping Spotify Top 200 UK')
df_uk = spotify.webScrapeSpotify('uk')
print(df_uk.head())
print('\n')

print('Scraping Spotify Viral 50 Global')
df_v50 = spotify.webScrapeSpotify('global', 'viral_50')
print(df_v50.head())
print('\n')

print('Scraping Spotify Viral 50 US')
df_us_v50 = spotify.webScrapeSpotify('us', 'viral_50')
print(df_us_v50.head())
print('\n')

print('Scraping Spotify Viral 50 UK')
df_uk_v50 = spotify.webScrapeSpotify('uk', 'viral_50')
print(df_uk_v50.head())
print('\n')


#Load DataFrames into Database
print('Loading Top 200 Global...')
spotify.loadDFintoDB(df)
print('\n')

print('Loading Top 200 US...')
spotify.loadDFintoDB(df_us)
print('\n')

print('Loading Top 200 UK...')
spotify.loadDFintoDB(df_uk)
print('\n')

print('Loading Viral 50 Global...')
spotify.loadDFintoDB(df_v50)
print('\n')

print('Loading  Viral 50 US...')
spotify.loadDFintoDB(df_us_v50)
print('\n')

print('Loading  Viral 50 UK...')
spotify.loadDFintoDB(df_uk_v50)
print('\n\n')

print('Done!')