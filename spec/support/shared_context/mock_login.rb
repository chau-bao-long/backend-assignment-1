RSpec.shared_context "mock login" do
  include_context "hr user"

  before do
    allow(User).to receive(:find_by).and_return(user)
  end
end
