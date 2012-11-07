#require 'app/uploaders/photo_uploader'

class Photo < ActiveRecord::Base
  belongs_to :user
  belongs_to :story

  attr_accessible :image
  acts_as_list :scope => :story
  mount_uploader :image, PhotoUploader

  RESIZE_TO_FIT = [800, 800]
  def photo_dimension(max=RESIZE_TO_FIT)
    result_height = (RESIZE_TO_FIT.first.to_f / width) * height

    [RESIZE_TO_FIT.first, result_height.to_i]
  end

  def photo_ratio
    width / height
  end

  def resize_ratio
    RESIZE_TO_FIT.first / RESIZE_TO_FIT.last
  end
end
