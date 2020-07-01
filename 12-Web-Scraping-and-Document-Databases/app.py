from flask import Flask, render_template, redirect
from flask_pymongo import PyMongo
import web_scrape

app = Flask(__name__)

# Use flask_pymongo to set up mongo connection
app.config["MONGO_URI"] = "mongodb://localhost:27017/mars_news"
mongo = PyMongo(app)


@app.route("/")
def index():
    mars = mongo.db.mars.find_one({"active": 1})
    return render_template("index.html", mars=mars)


@app.route("/scrape")
def scrape():
    mars_news = mongo.db.mars
    mars = web_scrape.webScrapeMars()
    
    #deactivate old data
    #When you run the scraper the data that is set as 
    #1 from the scrape_mars.py is set to inactive as 0 
    mars_news.update_many(
        {'active': 1},
        {"$set": {'active': 0}
        }
    )

    mars_news.insert_one(mars)
    
    #mars.replace_one({}, mars_data, upsert=True)
    #return "Scraping Successful!"
    return redirect('/')


if __name__ == "__main__":
    app.run()
