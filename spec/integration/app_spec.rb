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

  context "GET to /" do
    it "returns 200 OK with the right content" do
      # Send a GET request to /
      # and returns a response object we can test.
      response = get("/names")

      # Assert the response status code and body.
      expect(response.status).to eq(200)
    end

    it "returns Julia, Mary, Karim" do
    response = get('/names?name1=Julia&name2=Mary&name3=Karim')

    expect(response.status).to eq(200)
    expect(response.body).to eq "Julia, Mary, Karim"
    end

    xit 'returns 404 Not Found' do
      response = get('/names?id=276278')

      expect(response.status).to eq(404)
      # expect(response.body).to eq(expected_response)
    end

  end
  

  context "POST to /submit" do
    xit "returns 200 OK with the right content" do
      # Send a POST request to /submit
      # with some body parameters
      # and returns a response object we can test.
      response = post("/submit", name: "Dana", some_other_param: 12)

      # Assert the response status code and body.
      expect(response.status).to eq(200)
      expect(response.body).to eq("Hello Dana")
    end
  end
end
