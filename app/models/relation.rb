class Relation < ApplicationRecord
  belongs_to :superior, class_name: "Staff"
  belongs_to :subordinate, class_name: "Staff"

  class << self
    def refresh_hierarchy! personnel
      personnel.each do |key, value|
        superior = Staff.find_or_create_by! name: key
        subordinate = Staff.find_or_create_by! name: value
        create! superior: superior, subordinate: subordinate
      end
    end

    def build_relationship
      prepare_data
      build_matrix
    end

    private

    def build_matrix
      all.each do |relation|
        validate_relation relation
        @matrix[@map[relation.superior_id]][@map[relation.subordinate_id]] += 1
      end
    end

    def validate_relation relation
      subordinate_cannot_become_superior(
        superior: @map[relation.superior_id],
        subordinate: @map[relation.subordinate_id]
      )
    end

    def subordinate_cannot_become_superior subordinate: , superior:
      find_subordinates_of(subordinate).each do |sub|
        raise "conflict" if sub == superior
        subordinate_cannot_become_superior superior: superior, subordinate: sub
      end
    end

    def prepare_data
      @staffs = Staff.all
      @map = @staffs.each_with_index.inject({}) { |acc, (staff, i)| acc[staff.id] = i; acc }
      @matrix = Array.new(@staffs.length) { Array.new(@staffs.length, 0) }
    end

    def find_subordinates_of superior
      @matrix[superior].each_with_index.inject([]) { |acc, (sub, i)| acc << i if sub > 0; acc }
    end
  end
end
