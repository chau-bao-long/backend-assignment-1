RSpec.shared_context "hr user" do
  let(:right_password) { "12345678" }
  let(:user_name) { "personia" }
  let!(:user) { User.create name: user_name, password: right_password }
end
