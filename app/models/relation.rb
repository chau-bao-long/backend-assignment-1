class Relation < ApplicationRecord
  belongs_to :superior, class_name: "Staff"
  belongs_to :subordinate, class_name: "Staff"
end
