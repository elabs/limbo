describe Limbo::Rails::Data do
  describe ".new" do
    context "non-hash argument" do
      it "raises ArgumentError" do
        expect { Limbo::Rails::Data.new(nil) }.to raise_error ArgumentError
      end
    end

    context "missing required key" do
      it "raises ArgumentError" do
        hash = { params: {}, session: {}, exception: {} }

        expect { Limbo::Rails::Data.new(hash) }.to raise_error ArgumentError
      end
    end

    context "valid hash argument" do
      it "returns an instance" do
        hash = { params: {}, session: {}, exception: {}, request: {} }

        rails_data = Limbo::Rails::Data.new(hash)
        rails_data.should be_instance_of(Limbo::Rails::Data)
      end
    end
  end

  describe "#transform" do
    let(:exception) { double("exception") }
    let(:hash) do
      {
        params:     { controller: "c", action: "a", password: "pass"},
        session:    { user_id: "2"},
        exception:  exception,
        request:    request,
        custom:     "I am added by the user"
      }
    end
    before { exception.should_receive(:backtrace).exactly(1) { "backtrace" } }

    it "returns a transformed hash" do
      transformed_hash = Limbo::Rails::Data.new(hash).transform
      transformed_hash[:controller].should eq("c")
      transformed_hash[:action].should eq("a")
      transformed_hash[:parameters].should eq({ controller: "c",
                                                action: "a",
                                                password: "pass"})
      transformed_hash[:url].should eq("http://example.com/blog")
      transformed_hash[:session].should eq({user_id: "2"})
      transformed_hash[:backtrace].should eq("backtrace")
    end

    it "applies filter on some keys" do
      Rails.application.config.filter_parameters = [:password, :user_id]

      transformed_hash = Limbo::Rails::Data.new(hash).transform
      transformed_hash[:parameters].should eq({ controller: "c",
                                                action: "a",
                                                password: "[FILTERED]" })
      transformed_hash[:session].should eq({ user_id: "[FILTERED]" })
    end

    it "return parameters added by user" do
      transformed_hash = Limbo::Rails::Data.new(hash).transform
      transformed_hash[:custom].should eq("I am added by the user")
    end

  end
end
