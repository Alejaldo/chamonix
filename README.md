Chamonix
======================
Ruby on Rails Web application for setting up meetings. You can join to already existing events or create your own.
----------------------
## Configuration

+ Ruby version: 2.7.2
+ Rails versin: 6.1.3
+ Webpacker 5
+ Bootstrap 5
+ All photos and images uploads to AWS cloud storage (with `carrierwave`, `rmagick` and `fog-aws` gems)
+ PostgreSQL (for production)
+ Digital Ocean vps (using `capistrano` gem and `capistrano` associated gems for deployment)
+ Redis on vps
+ Currently the app has only russian language

## Installation

1. Clone the repo.
2. Execute 
```
$ bundle install
```
3. Execute 
```
$ rails db:migrate
```
4. Install `ImageMagick` if you have not one: execute 
```
$ sudo apt-get install libmagickwand-dev imagemagick
```
5. Add your Mailjet parameters to `.env` file: `MAILJET_API_KEY`, `MAILJET_SECRET_KEY` and `MAILJET_SENDER`
6. Create your own [Google maps API key](https://developers.google.com/maps/documentation/embed/get-api-key) and add `GOOGLE_MAPS_API_KEY` parameter with its value to `.env` file.
7. For uploading images (photos, avatars) make sure that you have your own AWS account. Create an Amazon S3 bucket for the app and add name of this bucket to `S3_BUCKET_NAME`. Use access key ID and secret access key of your IAM AWS account for adding `S3_ACCESS_KEY` and `S3_SECRET_KEY` respectively.
8. Using [developers Facebook page](https://developers.facebook.com/) create an app in `My apps` where you must specify `App Domains`, `Contact Email`, `Privacy Policy URL`, than put `+ Add Platform` and choose `Web` where include your own website (you should have your own website or create another free analogues, on Heroku for example) at `Site URL`. Create 1 app for development environment and 1 app for production environment, than use `App ID`s for `FB_APP_ID_DEV` and `FB_APP_ID_PROD`, `App Secret` for `FB_APP_SECRET_DEV` and `FB_APP_SECRET_PROD` respectively.
9. Using [developers VKontakte page](https://vk.com/dev) specify `Website address`, `Base domain` and `First API request`. Create 1 app for development environment and 1 app for production environment, than use `App ID`s for `VK_APP_ID_DEV` and `VK_APP_ID_PROD`, `Secure key` for `VK_APP_SECRET_DEV` and `VK_APP_SECRET_PROD` respectively.
10. The app use RSpec test, so add your Facebook email, id, name and avatar link to `MY_FB_EMAIL`, `MY_FB_ID`, `MY_FB_NAME` and `MY_FB_IMAGE` respectively. For digging these parameters go to `user.rb`, add `byebug` to the 1 line of `self.find_for_provider_oauth(access_token)` method, execute 
```
$ rails s
``` 
and 
```
$ bin/webpack-dev-server
``` 
(in separate terminal windows), navigate to `http://localhost:3000/users/sign_in` in your browser, put on `Вход через аккаунт Facebook`, put `access_token` (in terminal window where `rails s` has been executed) and than find your parameters.   
11. If you want to make deployment to your vps (Digital Ocean for example), make sure you have configured the vps with Ruby, Ruby on Rails, PostgreSQL, Redis, etc. and execute 
```
$ bundle exec cap production deploy
``` 
