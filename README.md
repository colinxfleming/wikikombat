# Sinatra Skeleton

Quick and dirty frame

## TODO

<ul>
	<li>working routes</li>
	<li>fleshed out gemfile</li>
	<li>actually make this do something (mortal kombat vs constitution probably)</li>
	<li>api that returns json from calls</li>
</ul>

## Deployment Prep 

From the CLI: 
<ol>
	<li>heroku create $APP_NAME</li>
	<li>heroku run rake db:migrate</li>
	<li>heroku run rake db:seed # if necessary</li>
</ol>
Then hit the URL and (hopefully) you're in the clear!