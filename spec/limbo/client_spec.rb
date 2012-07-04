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

      context "string argument" do
        use_vcr_cassette 'limbo.client.post.string_argument', exclusive: true
        specify { Limbo::Client.post("info").should_not be_valid_data }
      end

      context "bad character" do
        use_vcr_cassette 'limbo.client.post.bad_character', exclusive: true
        specify do
          Limbo::Client.post(data: "bad\x80char").should_not be_valid_data
        end
      end
    end
  end

  describe "#posted?" do
    context "valid uri" do
      specify { Limbo::Client.post(data: "info").should be_posted }
    end

    context "invalid uri" do
      use_vcr_cassette 'limbo.client.post.invalid_uri', exclusive: true

      before do
        Limbo.configure do |config|
          config.uri = "http://example.com"
        end
      end

      specify { Limbo::Client.post(data: "info").should_not be_posted }
    end
  end
end
