class AddInterestedTopicsToProfiles < ActiveRecord::Migration[7.0]
  def change
    add_column :profiles, :interested_topics, :string
  end
end
