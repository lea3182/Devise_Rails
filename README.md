## README.md

##### This README documents the steps used as I l used to integrate Devise authentication with a Rails 4 application. Offical documentation can be found here: [Devise Documentation](https://github.com/plataformatec/devise)

##### Basic setup
* Add `gem 'devise'` to Gemfile
* bundle install
* rails g devise:install
* rails g devise User    
* be rake db:create       (this command is necessary if using postgresql)
* Copy and paste into `config/environments/development.rb`:
`config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }`
* Add to User controller:
` before_action :authenticate_user! `
* In config/routes.rb  
  ```ruby
  root 'home#index'            The order you list your
  devise_for :users            resources matter 
  resources :users 
  ```
* To create Devise Views
` rails generate devise:views `

##### Adding Form attributes
If you look at `config/db/schema.rb` you can see all the attributes given to Devise User. If you want to add attibutes such as first_name and last_name:
* generating a new migration
`rails generate migration AddFirstlastToUsers first_name:string last_name:string`
`rake db:migrate'
* Add first_name and last_name attributes to your forms, for this app I added them to:
` app/devise/registration/edit.html ` and ` app/devise/registration/edit.html `
* ` first_name ` and ` last_name ` attributes need to be sanitized
* There are three ways to sanitize:
  1. Override default Devise registration controller (instructions listed under Customizing Controller and Routes)
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

##### Customizing Controller and Routes
Devise controllers do not have to be generated unless you wish to customize controller action.

Helpful links:
*[Devise Documentation( look under Configuring Controllers)](https://github.com/plataformatec/devise)
*[StackOverflow](http://stackoverflow.com/questions/6234045/how-do-you-access-devise-controllers)



