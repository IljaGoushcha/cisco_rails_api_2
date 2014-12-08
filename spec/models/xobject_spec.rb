require 'rails_helper'

RSpec.describe Xobject, type: :model do

  it "Should be valid object" do
    my_xobject = Xobject.create(arb_object: "'first_name':'Ilja','last_name':'Goushcha'")
    expect(my_xobject).to be_valid
  end

end
