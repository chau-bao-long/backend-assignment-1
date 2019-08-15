require 'rails_helper'

RSpec.describe "Hierarchy", type: :request do
  describe "#GET show personnel hierarchy" do
    context "given a simple hierarchy" do
      include_context "basic hierarchy"

      before do
        get "/api/v1/hierarchy"
      end

      it "should response relationship tree successfully" do
        expect(res_body).to be_truthy
      end
    end

    context "given a conflict hierrachy" do
      include_context "conflict hierarchy"

      before do
        get "/api/v1/hierarchy"
      end

      it "should response a clear error" do
        expect(res_body["error"]).to be_truthy
      end
    end
  end

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
      post "/api/v1/hierarchy", params: { personnel: personnel }
    end

    context "with a simple hierarchy" do
      let(:personnel) {{
        "Pete": "Nick",
        "Barbara": "Nick",
        "Nick": "Sophie",
        "Sophie": "Jonas"
      }}

      it "response created status" do
        expect(response.status).to be 204
      end
    end

    context "with invalid params" do
      let(:personnel) { "malicious string" }

      it "response bad request status" do
        expect(response.status).to be 500
      end
    end
  end
end
