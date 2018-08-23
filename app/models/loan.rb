##
# This class stores information about loans.
# ---
# == Attributes
# * begin_date: DateTime
# * end_date: DateTime
# * returned: boolean
# * user_id: integer - foreign key from 'users' table
# * status: string
# * Loan belongs to a User - creates foreign key
#   association between 'loans' and 'users' table.
# * Loan has many Loan Lines
# * Loan has many Book through Loan Lines - many-to-many association
#   between 'loans' and 'books' with 'loan_lines' as intersect table
#
class Loan < ApplicationRecord
  # == Associations
  # Loan has several associations:
  belongs_to :user, optional: true
  has_many :loan_lines
  has_many :books, through: :loan_lines
  accepts_nested_attributes_for :loan_lines

  # Calls method 'set_end_date' before object is saved to database
  before_create :set_end_date

  private

  # Automatically assigns end_date attribute by adding 1 month
  # to begin_date, which is the date on creation of the loan.
  def set_end_date
    self.end_date = self.begin_date + 1.month
  end
end
