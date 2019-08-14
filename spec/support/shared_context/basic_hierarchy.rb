RSpec.shared_context "basic hierarchy" do
  let(:employee) { Staff.create name: "employee" }
  let(:boss) { Staff.create name: "boss" }
  let(:superboss) { Staff.create name: "superboss" }
  let!(:boss_relation) { Relation.create superior_id: boss.id, subordinate_id: employee.id }
  let!(:superboss_relation) { Relation.create superior_id: superboss.id, subordinate_id: boss.id }
end
