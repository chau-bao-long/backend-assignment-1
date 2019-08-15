require "rails_helper"

RSpec.describe GetAllSuperiors do
  describe ".perform!" do
    include_context "basic hierarchy"

    context "given a superboss, a boss and an employee" do
      it "show superboss has no superior" do
        superiors = described_class.perform! superboss.name
        expect(superiors.length).to eq 0
      end

      it "show boss has 1 superior who is superboss" do
        superiors = described_class.perform! boss.name
        expect(superiors.length).to eq 1
        expect(superiors.first).to eq superboss
      end

      it "show employee has 2 superiors, that is boss and superboss" do
        superiors = described_class.perform! employee.name
        expect(superiors.length).to eq 2
        expect(superiors.first).to eq boss
        expect(superiors.second).to eq superboss
      end

      it "show non-existed employee has no superior" do
        superiors = described_class.perform! ""
        expect(superiors.length).to eq 0
      end
    end

    context "given no staff" do
      it "show empty superiors" do
        superiors = described_class.perform! ""
        expect(superiors.length).to eq 0
      end
    end
  end
end
