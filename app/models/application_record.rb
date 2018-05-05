class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  require 'twilio-ruby'
  require 'open-uri'
end
