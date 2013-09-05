class User < ActiveRecord::Base
  validates :uid, presence: true, uniqueness: true
  validates :ip_address, presence: true
end
