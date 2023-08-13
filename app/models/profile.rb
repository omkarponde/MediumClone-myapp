class Profile < ApplicationRecord
  belongs_to :user
  serialize :interested_topics, Array
end
