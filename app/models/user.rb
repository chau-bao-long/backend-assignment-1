class User < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_secure_password

  def self.authenticate! name:, password:
    find_by(name: name).tap do |user|
      raise Api::Error, "Wrong user name or password" unless user&.authenticate password
    end
  end
end
