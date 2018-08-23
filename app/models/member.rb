##
# This class stores information about members.
# Member inherits from User
#
class Member < User
  require 'stripe'

  # Before object is saved to database, run set_type
  before_save :set_type

  # Member belongs to a plan
  belongs_to :plan

  # Methods

  private

  # Sets class type to "Member" before
  # saving to database.
  def set_type
    self.type = "Member"
  end
end
