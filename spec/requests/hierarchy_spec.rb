require 'rails_helper'

RSpec.describe "Hierarchy", type: :request do
  describe "#GET show boss and boss of boss for given staff name" do
    before do
      get "/api/v1/hierarchy/staff?name=#{staff_name}"
    end

    context "with valid staff name" do
      let(:staff_name) { "marry" }

      it "should return right boss and boss's boss" do
        expect(response.body).to be_truthy
      end
    end
  end

  describe "#POST create personnel hierarchy" do
    before do
      post "/api/v1/hierarchy", personnel
    end

    context "with a simple hierarchy" do
      let(:personnel) {{
        "Pete": "Nick",
        "Barbara": "Nick",
        "Nick": "Sophie",
        "Sophie": "Jonas"
      }}

      it "should create right hierarchy" do
        expect(response.body).to be_truthy
      end
    end
  end
end
