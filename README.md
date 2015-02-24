## Description
TweetHeart searches twitter for the most recent tweets about a topic of interest, then performs sentiment analysis (powered by AlchemyAPI) on each of the tweets. The composite sentiment rating indicates how positively or negatively twitter views that subject at the moment of your search.

TweetHeart mines the Twitter API for tweets pertaining to your interests, with Alchemy API doing the sentiment-analysis heavy lifting. The back-end code is Ruby on Rails with PostgreSQL database, and the front end is Bootstrap with a modified Bootswatch theme.

##Links
#####[Heroku](https://peaceful-inlet-4447.herokuapp.com/)

#####[Trello](https://trello.com/b/7LezrZcm/tweet-analysis)

#####![Crude ERD](http://i.imgur.com/eX4UHiR.jpg)

#####![Crude mockup sketch](http://i.imgur.com/6Dje4XJ.jpg)

## Technologies Used

Ruby version 2.1.2

psql (PostgreSQL) 9.4.0

Rails 4.2.0

heroku-toolbelt/3.26.1

Twitter Bootstrap 3.3.2 (Slate Bootswatch Theme)

Twitter API (oauth)

Alchemy API gem

AuthN/AuthZ with bcrypt-ruby gem


