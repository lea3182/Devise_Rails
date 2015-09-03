## README.md

#### This README documents the steps used as I learn to integrate Devise authentication with a Rails 4 application. Offical documentaion can be found here: [Devise Documentation](https://github.com/plataformatec/devise)

* Add `gem 'devise'` to Gemfile
* bundle install
* rails g devise:install
* rails g devise User
* be rake db:create  (this command is necessary if using postgresql
* In `config/environments/development.rb`:
copy and paste
`config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }`
* Add to User controller
`before_action :authenticate_member!`
* In config/routes.rb
``` root 'home#index'
  devise_for :users
  resources :users ```
* Created Devise Views
` rails generate devise:views `
* Customizing Controller and Routes
* Strong Parameters