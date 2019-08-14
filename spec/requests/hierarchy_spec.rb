require 'rails_helper'

RSpec.describe "Hierarchy", type: :request do
  describe "#GET show boss and boss of boss for given staff name" do
    context "given basic hierarchy" do
      include_context "basic hierarchy"

      before do
        get "/api/v1/hierarchy/staff?name=#{staff_name}"
      end

      context "with valid staff name" do
        let(:staff_name) { employee.name }

        it "should response right boss and boss's boss" do
          expect(res_body.length).to be > 0
        end
      end

      context "with invaild staff name" do
        let(:staff_name) { "invalid name" }

        it "response empty" do
          expect(res_body).to be_empty
        end
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
