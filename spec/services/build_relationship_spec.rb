require "rails_helper"

RSpec.describe BuildRelationship do
  describe ".perform!" do
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

      before { RefreshHierarchy.perform! personnel }

      subject { described_class.perform! }

      it "validate no error" do
        expect { subject }.to_not raise_error
      end

      it "generate right hierarchy" do
        is_expected.to eq hierarchy
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

    before { RefreshHierarchy.perform! personnel }

    subject { described_class.perform! }

    it "raise error: Sophie cannot be supervisor of Jonas, because Jonas is supervisor of Sophie" do
      expect { subject }.to raise_error RuntimeError
    end
  end

  context "when personnel data is deeply conflict" do
    let(:personnel) {{
      "Pete": "Nick",
      "Barbara": "Nick",
      "Nick": "Sophie",
      "Sophie": "Jonas",
      "Jonas": "Pete"
    }}

    before { RefreshHierarchy.perform! personnel }

    subject { described_class.perform! }

    it "raise error: Pete cannot be supervisor of Jonas, because
          Jonas is supervisor of Sophie,
          who is supervisor of Nick,
          who is supervisor of Pete," do
      expect { subject }.to raise_error RuntimeError
    end
  end

  context "when personnel data contains multiple roots" do
    let(:personnel) {{
      "Pete": "Nick",
      "Barbara": "Nick",
      "Nick": "Sophie",
      "Sophie": "Jonas",
      "Top": "Long"
    }}

    before { RefreshHierarchy.perform! personnel }

    subject { described_class.perform! }

    it "raise multiple roots error" do
      expect { subject }.to raise_error "Contain multi root"
    end
  end
end
