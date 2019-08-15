require 'rails_helper'

RSpec.describe User, type: :model do
  describe ".authenticate!" do
    context "given a hr user" do
      include_context "hr user"

      subject do
        described_class.authenticate! name: user_name, password: password
      end

      context "using a right password" do
        let(:password) { right_password }

        it "authenticate successfully" do
          expect { subject }.to_not raise_error
        end
      end

      context "using a wrong password" do
        let(:password) { right_password + "w" }

        it "authenticate unsuccessfully and raise error" do
          expect { subject }.to raise_error
        end
      end
    end
  end
end
