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
```ruby
  root 'home#index'
  devise_for :users
  resources :users 
  ```
* Created Devise Views
` rails generate devise:views `
* Customizing Controller and Routes
* Adding Form attributes
I added first_name and last_name to User model by:
* generating a new migration
`rails generate migration AddFirstlastToUsers first_name:string last_name:string`
`rake db:migrate'
* Add first_name and last_name form attributes to 
` app/devise/registration/edit.html ` and ` app/devise/registration/edit.html `
* ` first_name ` and ` last_name ` attributes need to be sanitized
* There are three ways to sanitize:
  1. Override default Devise registration controller
  2. "The lazy way" which is to add code in 'app/controllers/application_controller.rb `
    ```ruby
    class ApplicationController < ActionController::Base
    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :exception
    before_action :configure_permitted_parameters, if: :devise_controller?

    protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) << :first_name << :last_name
      devise_parameter_sanitizer.for(:account_update) << :first_name << :last_name
    end

    end
    ```
  3. Add an initializer file

* I implemented option 3 and created an initializer file `config/initializers/devise_permitted_parameters.rb` 
