describe Limbo::RailsRequest do
  describe "#url" do
    context "URL with a standard port" do
      it "returns a formatted URL without port" do
        rails_request = Limbo::RailsRequest.new(request(port: 80))
        rails_request.url.should == "http://example.com/blog"
      end
    end

    context "URL with non-standard port" do
      it "returns a formatted URL with the port included" do
        rails_request = Limbo::RailsRequest.new(request(port: 1337))
        rails_request.url.should == "http://example.com:1337/blog"
      end
    end
  end
end
