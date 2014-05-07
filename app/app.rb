$LOAD_PATH.push File.dirname(__FILE__)

require 'sinatra'
require 'sinatra/base'
require 'sinatra/assetpack'
require 'json'
require 'sass'
require 'haml'
require 'bootstrap-sass'

# Require models
files = File.expand_path("../models/*.rb", __FILE__)
Dir[files].each {|f| require f}

class App < Sinatra::Base
  set :root, File.dirname(__FILE__) # You must set app root

  register Sinatra::AssetPack

  # Assets
  assets do
    serve '/js', from: 'assets/javascripts'
    serve '/css', from: 'assets/stylesheets'
    serve '/img', from: 'assets/images'

    js :application, []

    css :app, '/css/application.css', [
      "/css/bootstrap.css"
    ]

    js_compression  :jsmin
    css_compression :sass
  end

  get '/' do
    haml :index
  end
end
