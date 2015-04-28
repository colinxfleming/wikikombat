# Sinatra Skeleton

Quick and dirty frame

## TODO

<ul>
	<li>Test suite</li>
	<li>Refresh importance checks section on form submit</li>
	<li>Full instructions for deployment prep</li>
</ul>

## Deployment Prep 

From the CLI: 
<ol>
	<li>heroku create $APP_NAME</li>
	<li>heroku run rake db:migrate</li>
	<li>heroku run rake db:seed # if necessary</li>
</ol>
Then hit the URL and (hopefully) you're in the clear!