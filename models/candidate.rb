
class Candidate < ActiveRecord::Base
  has_secure_password # This adds a few methods
  # password getter and setter methods
  # Authenticate #=> user

end

# u2 = Employer.new
# u.password = "apple"
# candidate@gaa.com
# digestion algorithm?? activerecord outsource this to other gems - bcrypt