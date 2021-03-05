class Comment < ApplicationRecord
  include Rails.application.routes.url_helpers
  belongs_to :channel
  belongs_to :user

  has_one_attached :file


  def file_url
    file.attached? ? url_for(file) : nil
  end
  

end
