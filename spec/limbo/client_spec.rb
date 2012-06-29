describe Limbo::Client do
  use_vcr_cassette 'limbo.client.post'

  before do
    Limbo.configure do |config|
      config.key = "test-key"
      config.uri = "http://limbo-listener-staging.herokuapp.com"
    end
  end

  describe ".post" do
    it "returns a client instance" do
      Limbo::Client.post(data: "info").should be_an_instance_of(Limbo::Client)
    end
  end

  describe "#valid_data?" do

    context "valid data" do
      specify { Limbo::Client.post(data: "info").should be_valid_data }
    end

    context "invalid data" do
      use_vcr_cassette 'limbo.client.post.invalid_data'

      specify { Limbo::Client.post("info").should_not be_valid_data }
    end
  end

  describe "#posted?" do
    context "valid uri" do
      specify { Limbo::Client.post(data: "info").should be_posted }
    end

    context "invalid uri" do
      use_vcr_cassette 'limbo.client.post.invalid_uri'

      before do
        Limbo.configure do |config|
          config.uri = "http://example.com"
        end
      end

      specify { Limbo::Client.post(data: "info").should_not be_posted }
    end
  end
end
