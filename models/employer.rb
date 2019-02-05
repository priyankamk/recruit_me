
class Employer < ActiveRecord::Base
  has_secure_password # This adds a few methods
  # password getter and setter methods
  # Authenticate #=> user
end


# u = Employer.new
# u.password = "apple"
# digestion algorithm?? activerecord outsource this to other gems - bcrypt