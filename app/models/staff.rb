class Staff < ApplicationRecord
  has_many :superiors, class_name: "Relation", foreign_key: :subordinate_id

  validates :name, presence: true
end
