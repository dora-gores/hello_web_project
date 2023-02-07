# file: spec/integration/application_spec.rb

require "spec_helper"
require "rack/test"
require_relative '../../app'

describe Application do
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }


  context 'GET /hello' do
    it 'returns an html hello message with a given name' do
      response = get('/hello', name: 'Dora')
      expect(response.body).to include('<h1>Hello Dora!</h1>')
      # expect(response.body).to include('<p>Anna</p>')
      # expect(response.body).to include('<p>Kim</p>')
      # expect(response.body).to include('<p>Josh</p>')
      # expect(response.body).to include('<p>David</p>')
    end
  end

  context "GET to /names" do
    it "returns 200 OK" do
      # Send a GET request to /
      # and returns a response object we can test.
      response = get("/names")

      # Assert the response status code and body.
      expect(response.status).to eq(200)
    end

    it "returns Julia, Mary, Karim" do
    response = get('/names?name1=Julia&name2=Mary&name3=Karim')

    # expect(response.status).to eq(200)
    expect(response.body).to eq "Julia, Mary, Karim"
    end

    it 'returns 404 Not Found' do
      response = get('/namez')

      expect(response.status).to eq(404)
      # expect(response.body).to eq(expected_response)
    end

  end
  

  context "POST to /sort-names" do
    it "returns names sorted into alphabethic order" do

      response = post('/sort-names?names=Joe,Alice,Zoe,Julia,Kieran')

      expect(response.status).to eq(200)
      expect(response.body).to eq "Alice,Joe,Julia,Kieran,Zoe"
    end

    it "returns names sorted into alphabethic order" do
    
      response = post('/sort-names?names=Karen,Karl,Vivian,Chris,Zelda')

      # Assert the response status code and body.
      expect(response.status).to eq(200)
      expect(response.body).to eq "Chris,Karen,Karl,Vivian,Zelda"
    end
  end
end