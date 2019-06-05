class User < ActiveRecord::Base
  has_many :tweets
  has_secure_password

def slug
  self.username.downcase.split(" ").join("-")
end

def self.find_by_slug(name)
  User.all.find {|t| t.slug == name}
end

end
