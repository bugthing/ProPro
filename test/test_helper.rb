ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase

  # Logs the user "dave" in to the session.
  #   Intended for use by functional tests
  #   "dave" is a fixture and used to test features of the system, so owns 
  #   charts and can access the system
  def log_dave_in_via_session
    session[:user_id] = User.find_by_email('dave@people.com').id
  end

  # mocha - unusal setup but that whats in the docs (https://github.com/freerange/mocha)
  #require "mocha/setup"
end

