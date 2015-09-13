# Divelog

Steps to get started:

```bash
* git clone divelog
* cd divelog
* bundle install  # Install gems specified in Gemfile
* rake db:migrate # Initialize database
* rake emoji      # Initialize emoji images
* rails server -b $IP -p $PORT, and test the server
```

## Production Host & Configuration

Set up a server (I'm using Heroku's free tier). After that, configure e-mail and file uploads:

### E-mail configuration
With Sendgrid. Create a free account, and configure the host in 
  * config/environments/production.rb (host: myapp.herokuapp.com)
  * set ENV['SENDGRID_USERNAME'], ENV['SENDGRID_PASSWORD'] on Heroku
 
### AWS S3 File Upload configuration
  * set bucket, account, secret environment variables on Heroku

