describe Limbo do
  before do
    Limbo.configure do |config|
      config.key = "test-key"
      config.uri = "http://limbo-listener-staging.herokuapp.com"
    end
  end

  describe ".post" do
    it "returns a valid Client object" do
      client = Limbo.post(a: "b")
      client.should be_valid_data
      client.should be_posted
    end
  end

  describe ".rails_post" do
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

