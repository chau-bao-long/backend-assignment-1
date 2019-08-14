class Staff < ApplicationRecord
  has_many :superiors, class_name: "Relation", foreign_key: :subordinate_id

  validates :name, presence: true

  class << self
    def direct_superiors_of name
      joins(:superiors).where(name: name).select(:superior_id).to_sql
    end

    def indirect_superiors_of name
      <<~SQL
        SELECT B.superior_id FROM (#{direct_superiors_of(name)}) AS A 
        LEFT JOIN relations AS B 
        ON A.superior_id = B.subordinate_id
      SQL
    end

    def all_superiors_of name
      where("id IN (#{direct_superiors_of(name)} UNION #{indirect_superiors_of(name)})")
    end
  end
end
