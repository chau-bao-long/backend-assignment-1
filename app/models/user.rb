class User < ApplicationRecord
  validates :name, presence: true

  has_secure_password

  def self.authenticate! name:, password:
    find_by(name: name).tap do |user|
      raise "Wrong user name or password" unless user&.authenticate password
    end
  end
end
