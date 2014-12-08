class Xobject < ActiveRecord::Base
  before_create :generate_uid

  def self.generate_object_urls
    xobjects = Xobject.all

    xobjects_formated = xobjects.map do |xobject|
      {url: "https://cisco-rails-api_2.herokuapp.com/objects/#{xobject[:uid]}"}
    end

    return xobjects_formated
  end

  def self.deflate_xobject(xobject)
    temp_string = ""
    xobject.each do |key, value|
      temp_string = "#{temp_string}#{key}:#{value},"
    end
    deflated_string = temp_string.chop
    return deflated_string
  end

  def self.inflate_xobject(params)
    temp_hash = {uid: Xobject.find_by_uid(params[:id])[:uid]}
    temp_string = Xobject.find_by_uid(params[:id])[:arb_object]
    temp_array = temp_string.split(",")
    temp_array.map do |elem|
      temp_hash[elem.split(":")[0].to_sym] = elem.split(":")[1]
    end
    return temp_hash
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
