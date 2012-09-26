describe Limbo do
  before do
    Limbo.configure do |config|
      config.key = "test-key"
      config.uri = "http://limbo-listener-staging.herokuapp.com"
      config.environment = "test"
      config.service = "worker"
    end
  end

  describe ".post" do
    use_vcr_cassette 'limbo.post'

    it "returns a valid Client object" do
      client = Limbo.post(a: "b")
      client.should be_valid_data
      client.should be_posted
    end

    it "adds default parameters" do
      expected = {:environment=>"test", :service=> "worker", :l=>"k"}
      Limbo::Client.should_receive(:post).with(expected)

      Limbo.post({l: "k"})
    end
  end

  describe ".rails_post" do
    use_vcr_cassette 'limbo.rails_post'

    before do
      rails_data = double("rails_data")
      rails_data.should_receive(:transform).and_return({ a: "b" })
      Limbo::Rails::Data.stub(:new).and_return(rails_data)
    end

    it "returns a valid Client object" do
      client = Limbo.rails_post(a: "b")
      client.should be_valid_data
      client.should be_posted
    end
  end
end

