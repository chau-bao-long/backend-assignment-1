require 'rails_helper'

RSpec.describe Relation, type: :model do
  describe ".refresh_hierarchy!" do
    context "with valid input" do
      let(:personnel) {{
        "Pete": "Nick",
        "Barbara": "Nick",
        "Nick": "Sophie",
        "Sophie": "Jonas"
      }}

      before do
        Relation.refresh_hierarchy! personnel
      end

      it "create enough staffs and relations" do
        expect(Staff.count).to eq 5
        expect(Relation.count).to eq 4
      end
    end

    context "with invalid input" do
      subject do
        Relation.refresh_hierarchy! "maliciou string"
      end

      it "throw error" do
        expect { subject }.to raise_error
      end
    end

    context "with empty input" do
      subject do
        Relation.refresh_hierarchy!({})
      end

      it "did not create anything" do
        is_expected.to be_empty
      end
    end
  end

  describe ".build_relationship" do
    context "when personnel data make sense" do
      let(:personnel) {{
        "Pete": "Nick",
        "Barbara": "Nick",
        "Nick": "Sophie",
        "Sophie": "Jonas"
      }}

      let(:hierarchy) {{
        "Jonas": {
          "Sophie": {
            "Nick": {
              "Pete": {},
              "Barbara": {}
            }
          }
        }
      }}

      before { described_class.refresh_hierarchy! personnel }

      subject { described_class.build_relationship }

      it "validate no error" do
        expect { subject }.to_not raise_error
      end
    end
  end

  context "when personnel data is conflict" do
    let(:personnel) {{
      "Pete": "Nick",
      "Barbara": "Nick",
      "Nick": "Sophie",
      "Sophie": "Jonas",
      "Jonas": "Sophie"
    }}

    before { described_class.refresh_hierarchy! personnel }

    subject { described_class.build_relationship }

    it "raise conflict error" do
      expect { subject }.to raise_error
    end
  end
end
