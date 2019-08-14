class Relation < ApplicationRecord
  belongs_to :superior, class_name: "Staff"
  belongs_to :subordinate, class_name: "Staff"

  def self.build_relationship personnel
    personnel.each do |key, value|

    end
  end
end
