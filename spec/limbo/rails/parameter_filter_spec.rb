describe Limbo::Rails::ParameterFilter do
  before do
    Rails.application.config.filter_parameters = [:password, :secret]
  end

  describe ".filter" do
    context "is a hash" do
      it "filters specified parameters" do
        hash = { password: "secret", other: "visible", secret: "d" }
        filtered_hash = Limbo::Rails::ParameterFilter.filter(hash)
        filtered_hash[:password].should == "[FILTERED]"
        filtered_hash[:secret].should == "[FILTERED]"
        filtered_hash[:other].should == "visible"
      end
    end

    context "not a hash" do
      it "returns the object" do
        Limbo::Rails::ParameterFilter.filter("test").should == "test"
      end
    end
  end

end
