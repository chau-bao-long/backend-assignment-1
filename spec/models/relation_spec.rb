require 'rails_helper'

RSpec.describe Relation, type: :model do
  describe ".build_relationship" do
    context "with a simple valid hierarchy" do
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

      it "should create right hierarchy" do
        expect(Relation.build_relationship(personnel)).to eq hierarchy
      end
    end
  end
end
