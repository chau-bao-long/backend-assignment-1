require 'rails_helper'

RSpec.describe "Session", type: :request do
  include_context "hr user"

  describe "#POST login api" do
    include_context "hr user"

    before do
      post "/api/v1/sessions", params: params
    end

    context "with valid user name and password" do
      let(:params) {{
        name: user_name,
        password: right_password
      }}

      it "response login successfully and no content" do 
        expect(response.status).to eq 204
      end
    end

    context "with invalid user name and password" do
      let(:params) {{
        name: user_name,
        password: ""
      }}

      it "response login fails" do 
        expect(response.status).to eq 400
      end
    end
  end
end
