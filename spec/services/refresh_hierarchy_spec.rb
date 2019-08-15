require "rails_helper"

RSpec.describe RefreshHierarchy do
  describe ".perform!" do
    context "with valid input" do
      let(:personnel) {{
        "Pete": "Nick",
        "Barbara": "Nick",
        "Nick": "Sophie",
        "Sophie": "Jonas"
      }}

      before do
        described_class.perform! personnel
      end

      it "create enough staffs and relations" do
        expect(Staff.count).to eq 5
        expect(Relation.count).to eq 4
      end
    end

    context "with invalid input" do
      subject do
        described_class.perform! "maliciou string" 
      end

      it "throw error" do
        expect { subject }.to raise_error NoMethodError
      end
    end

    context "with empty input" do
      subject do
        described_class.perform!({})
      end

      it "did not create anything" do
        is_expected.to be_empty
      end
    end
  end
end
