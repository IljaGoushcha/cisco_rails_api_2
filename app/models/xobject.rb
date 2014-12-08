class Xobject < ActiveRecord::Base
  before_create :generate_uid

  def self.generate_object_urls
    xobjects = Xobject.all

    xobjects_formated = xobjects.map do |xobject|
      {url: "http://localhost:3000/objects/#{xobject[:uid]}"}
    end

    return xobjects_formated
  end

  def self.deflate_xobject(xobj)
    xobj.delete("controller")
    xobj.delete("action")
    temp_string = ""
    xobj.each do |key, value|
      temp_string = "#{temp_string}#{key}:#{value},"
    end
    deflated_string = temp_string.chop
    return deflated_string
  end

  def self.inflate_xobject(xobj)
    temp_hash = {uid: xobj[:uid]}
    temp_string = xobj[:arb_object]
    temp_array = temp_string.split(",")
    temp_array.map do |elem|
      temp_hash[elem.split(":")[0].to_sym] = elem.split(":")[1]
    end
    temp_hash[:created_at] = xobj[:created_at]
    temp_hash[:updated_at] = xobj[:updated_at]
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
