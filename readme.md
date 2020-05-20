# PocketX
(cross connectivity, ver '0.9')

# Motivation

> I want to keep all my links in one place, Pocket. Howerver, I keep there some journals behind paywall, so I need a way to fetch these artciles. Sometimes PocketX is not able to process the articles correctly, so you might want to create feeds and recipes for various use cases.

# Workflow

![](imgs/workflow.png)
**You callect everything to Pocket. The you run this PocketX script to create a feed.xml, and this feed is processed with recipe polityka to get articles behind paywall. Of course, you can code more than one recipes to process your pocket (depicted as many feeds and many recipes**

# PocketX
Configure your feeds in PocketX.recipe:

```python
            feeds = {'polityka':
                               {'feed_fn': '/Users/magnus/Dropbox/feed.xml',
                                'feed_title': 'polityka.pl',
                                'feed_desc': 'polityka.pl',
                                'feed_link': 'http://polityka.pl',
                                'feed_search_url' : 'polityka.pl'},
```

run:

    ebook-convert PocketX.recipe PocketX.mobi


# Feed
The feed will be created.


```xml
<?xml version="1.0" encoding="UTF-8" ?><rss version="2.0"><channel>
                    <title>polityka.pl</title>
                    <description>polityka.pl</description>
                    <link>http://polityka.pl</link>
                    
                         <item>          
                          <title>Do polityki wchodzi pokolenie. Dla nich przyszłość jest teraz albo wcale</title>
                          <description>Jest trzecią i najmłodszą w historii kobietą na czele fińskiego rządu. Należy do Partii Socjaldemokratycznej, największej w koalicyjnym gabinecie.</description>
                          <link>https://www.polityka.pl/tygodnikpolityka/swiat/1936530,1,ok-boomer.read</link>
                          <pubDate>1589833811</pubDate>
                         </item>

</item></channel></rss>
```

![](imgs/pseudofeed.png)
This is a real feed ;-) you can use Feedly to access it.


# Recipes
Example: polityka.recipe with login in into the journal!

Configure the feed:

```python
class polityka(BasicNewsRecipe):
    title          = 'polityka.pl'
    oldest_article = 10000
    max_articles_per_feed = 10000
    
    auto_cleanup   = False

    feeds          = [
        ('polityka.pl', 'http://dl.dropbox.com/s/27t8uhx4nlslggr/feed.xml'), ## your feed here! use dl dropbox link to skip the Dropbox web interface
    ]
```

Run:

    ebook-convert polityka.pl.recipe .mobi --username XXXXXXXXXXX --password XXXXXXXXX --personal-doc true

to get articles from the feed and send it to your Kindle.
