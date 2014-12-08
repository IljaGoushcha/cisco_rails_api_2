require 'rails_helper'

describe "GET all request" do
  before :each do
    Xobject.create(arb_object: "'first_name':'Ilja','last_name':'Goushcha'")
    Xobject.create(arb_object: "'first_name':'John','last_name':'Goushcha'")
    get '/objects'
  end

  it 'sends success response 200' do
    expect(response).to be_success
  end

  it 'checks length of json response is 2' do
    expect(JSON.parse(response.body).length).to eq(2)
  end

end


describe "GET one request" do
  before :each do
    my_xobject = Xobject.create(arb_object: "first_name:Mike,last_name:John")
    get "/objects/#{my_xobject.uid}"
  end

  it 'sends success response 200' do
    expect(response).to be_success
  end

  it 'checks first_name is Mike' do

    expect(JSON.parse(response.body)["first_name"]).to eq("Mike")
  end

end
