class Relation < ApplicationRecord
  belongs_to :superior, class_name: "Staff"
  belongs_to :subordinate, class_name: "Staff"

  class << self
    def refresh_hierarchy! personnel
      personnel.each do |key, value|
        subordinate = Staff.find_or_create_by! name: key
        superior = Staff.find_or_create_by! name: value
        create! superior: superior, subordinate: subordinate
      end
    end

    def build_relationship
      prepare_data
      build_matrix
      find_root
      build_tree
    end

    private

    def prepare_data
      @staffs = Staff.all
      @map = @staffs.each_with_index.inject({}) { |acc, (staff, i)| acc[staff.id] = i; acc }
      @matrix = Array.new(@staffs.length) { Array.new(@staffs.length, 0) }
    end

    def build_matrix
      all.each do |relation|
        fill_matrix superior: @map[relation.superior_id], subordinates: [@map[relation.subordinate_id]]
      end
    end

    def find_root
      root = @matrix.each_with_index.inject([]) do |acc, (sub_axis, i)|
        acc << i if sub_axis.one? { |sub| sub == 0 }
        acc
      end
      raise "Contain multi root" if root.length != 1
      @root = root.first
    end

    def build_tree

    end

    def fill_matrix superior:, subordinates: 
      @matrix[superior][subordinates.last] += 1
      find_subordinates_of(subordinates.last).each do |sub|
        raise_conflict(superior, subordinates + [sub]) if sub == superior
        @matrix[superior][sub] += 1
        fill_matrix superior: superior, subordinates: subordinates + [sub]
      end
    end
    
    def raise_conflict superior, subordinates
      raise <<~ERROR
        #{name_of superior} cannot be supervisor of #{name_of subordinates.first}, because
        #{name_of subordinates.first} is supervisor of #{name_of subordinates.second},
        #{(2...subordinates.length).reduce("") {|a, i| a + "who is supervisor of #{name_of subordinates[i]},\n"}}
      ERROR
    end

    def find_subordinates_of superior
      @matrix[superior].each_with_index.inject([]) { |acc, (sub, i)| acc << i if sub == 1; acc }
    end

    def name_of staff
      @staffs[staff].name
    end
  end
end
