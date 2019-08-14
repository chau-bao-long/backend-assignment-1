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
      # TODO main algorithm
    end
  end
end
