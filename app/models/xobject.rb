class Xobject < ActiveRecord::Base
  before_create :generate_uid

  def self.generate_object_urls
    xobjects = Xobject.all

    xobjects_formated = xobjects.map do |xobject|
      {url: "https://cisco-rails-api_2.herokuapp.com/objects/#{xobject[:uid]}"}
    end

    return xobjects_formated
  end

  private
  # I am not sure if I am generating UID or UUID,
  # or is there even a difference between the two?
  def generate_uid
    begin
      # .uuid or .hex? both seem to do the same job
      self.uid = SecureRandom.uuid.gsub(/[-]/, '')
    end while self.class.exists?(uid: self.uid)
  end

end
