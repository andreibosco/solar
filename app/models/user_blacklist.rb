class UserBlacklist < ActiveRecord::Base
  self.table_name = "user_blacklist"

  attr_accessible :cpf, :name

  validates :cpf, presence: true, uniqueness: true
end
