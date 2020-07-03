from bs4 import BeautifulSoup
import pandas as pd
from splinter import Browser
from datetime import datetime
import json
import time
import pymongo


def scrape_URL_1():
    #Leverage Splinter to Web Scrape
    executable_path = {'executable_path': r"/home/bdr/Desktop/chromedriver"}
    browser = Browser('chrome', **executable_path, headless=True)
    
    #*** URL 1: NASA Mars News ****
    url = 'https://mars.nasa.gov/news/'
    browser.visit(url)
    time.sleep(4)

    #Parse HTML
    html = browser.html
    soup = BeautifulSoup(html, "lxml")
    titles = soup.find_all(class_="content_title")
    texts = soup.find_all(class_="article_teaser_body")
    
    # Close Browser
    browser.quit()
    
    # Filter for First Title with a Link
    firstTitle = "" 
    for title in titles:
        if title.a:
            firstTitle = title
            break
    
    # Assign Target Elements to Variables
    newsTitle = firstTitle.a.text.strip()
    newsLink = "https://mars.nasa.gov" + firstTitle.a['href']
    newsText = texts[0].text.strip()
    
    # Create Dictionary with Target Information
    rtnDict = {
        "newsTitle": newsTitle,
        "newsLink": newsLink,
        "newsText": newsText
    }
    
    return rtnDict



def scrape_URL_2():
    #Leverage Splinter to Web Scrape
    executable_path = {'executable_path': r"/home/bdr/Desktop/chromedriver"}
    browser = Browser('chrome', **executable_path, headless=True)
    
    #*** URL 2: JPL Mars Space Images ****
    url = 'https://www.jpl.nasa.gov/spaceimages/?search=&category=Mars'
    browser.visit(url)
    time.sleep(4)
    
    #Parse HTML
    html = browser.html
    soup = BeautifulSoup(html, "lxml")
 
    # Close Browser
    browser.quit()

    #Capture Image
    images = soup.find_all(class_="carousel_item")
    imageURL = 'https://www.jpl.nasa.gov' + images[0]["style"].split(" ")[1].split("'")[1]
    
    # Create Dictionary with Target Information
    rtnDict = {
        "featureImageURL": imageURL
    }
    
    return rtnDict



def scrape_URL_3():
    #Leverage Splinter to Web Scrape
    executable_path = {'executable_path': r"/home/bdr/Desktop/chromedriver"}
    browser = Browser('chrome', **executable_path, headless=True)
    
    #*** URL 3: Mars Weather ****
    url = 'https://twitter.com/marswxreport?lang=en'
    browser.visit(url)
    time.sleep(4)
    
    #Parse HTML
    html = browser.html
    soup = BeautifulSoup(html, "lxml")
    
    # Close Browser
    browser.quit()    
    
    #Capture Weather
    allTweets_Maybe = soup.find_all("span")
    tweetText = ""
    for tweet in allTweets_Maybe:
        if tweet.text:
            if "InSight sol" in tweet.text:
                tweetText = tweet.text
                break
                
    allLinks_Maybe = soup.find_all("a")
    tweetLink = ""
    for link in allLinks_Maybe:
        if link['href']:
            if "status" in link["href"]:
                tweetLink = "https://www.twitter.com" + link["href"]
                break
 

    
    # Create Dictionary with Target Information
    rtnDict = {
        "tweetWeatherURL": tweetLink,
        "tweetWeatherText": tweetText
    }
    
    return rtnDict



def scrape_URL_4():
    #Leverage Splinter to Web Scrape
    executable_path = {'executable_path': r"/home/bdr/Desktop/chromedriver"}
    browser = Browser('chrome', **executable_path, headless=True)
    
    #*** URL 4: Mars Facts ****
    url = 'https://space-facts.com/mars/'
    browser.visit(url)
    time.sleep(4)
    
    #Parse HTML
    #Returns List of Tables: Target Table is the First
    html = browser.html
    dfs = pd.read_html(html)
    stats = dfs[0]
    stats.columns = ["Attribute", "Value"]
    
    #Capture Table in HTML
    data_html = stats.to_html(index=False)
    data_html = data_html.replace('class="dataframe"', 'class="table table-hover"')

    
    #Close Browser
    browser.quit()    
 

    # Create Dictionary with Target Information
    # "active" field to identify the latest record in the database
    # records with "active" 1 will be renders on the portal
    rtnDict = {
        "marsStatsHTML": data_html,
        "active": 1,
        "dateScraped": datetime.now()
    }
    
    return rtnDict


def scrape_hemisphere(html_text):
    # Soupify the html text
    hemi_soup = BeautifulSoup(html_text, "html.parser")

    # Try to get href and text except if error.
    try:
        title_elem = hemi_soup.find("h2", class_="title").get_text()
        sample_elem = hemi_soup.find("a", text="Sample").get("href")

    except AttributeError:

        # Image error returns None for better front-end handling
        title_elem = None
        sample_elem = None

    hemisphere = {
        "title": title_elem,
        "img_url": sample_elem
    }
    
    return hemisphere



def scrape_URL_5():
    #Leverage Splinter to Web Scrape
    executable_path = {'executable_path': r"/home/bdr/Desktop/chromedriver"}
    browser = Browser('chrome', **executable_path, headless=True)
    
    #*** URL 5: Mars Hemispheres ****
    url = (
        "https://astrogeology.usgs.gov/search/"
        "results?q=hemisphere+enhanced&k1=target&v1=Mars"
    )
    
    browser.visit(url)
    #html_text = browser.html
    
    #Empty dictionary to hold values
    hemisphere_image_urls = []
    for i in range(4):

        # Find the elements on each loop to avoid a stale element exception
        browser.find_by_css("a.product-item h3")[i].click()
        
        hemi_data = scrape_hemisphere(browser.html)

        # Append hemisphere object to list
        hemisphere_image_urls.append(hemi_data)

        # Finally, we navigate backwards
        browser.back()

    
    #Close Browser
    browser.quit()    
 

    # Create Dictionary with Target Information
    rtnDict = {
        "hemisphere_url_images": hemisphere_image_urls
    }
    
    return rtnDict


def Merge(dict1, dict2, dict3, dict4, dict5): 

    merged_dict = {**dict1, **dict2, **dict3, **dict4, **dict5} 

    return merged_dict


def webScrapeMars():
    mars_news = scrape_URL_1()
    jpl_image = scrape_URL_2()
    mars_weather = scrape_URL_3()
    mars_hemi = scrape_URL_5()
    mars_facts = scrape_URL_4()
    
    #consolidate individual dictionaries
    mars_info = Merge(mars_news, jpl_image, mars_weather, mars_hemi, mars_facts)
    
    return mars_info