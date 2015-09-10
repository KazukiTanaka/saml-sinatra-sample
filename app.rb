# -*- coding: utf-8 -*-
lib = File.expand_path(File.dirname(__FILE__))
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'sinatra'
require 'onelogin/ruby-saml'
require 'app/models/account'

configure do
  set :cache_control, :no_store
  set :static_cache_control, :no_store
end

before do
  # retrieve multiple params as an array
  @params = Rack::Utils.parse_query @env['rack.request.form_vars']
end

get '/saml/authentication_request' do
  request = OneLogin::RubySaml::Authrequest.new
  redirect request.create(Models::Account.get_saml_settings)
end

get '/saml/artifact' do
  response          = OneLogin::RubySaml::Response.new(@params)
  response.settings = Models::Account.get_saml_settings

  if response.is_valid?
    # authorize_success
    "Success! #{response.nameid}"
  else
    'Error'
  end
end

get '/saml/metadata' do
  meta = OneLogin::RubySaml::Metadata.new
  
  content_type 'text/xml'
  meta.generate(Models::Account.get_saml_settings, true)
end
