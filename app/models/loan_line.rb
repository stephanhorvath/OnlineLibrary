##
# This class stores information about loan lines.
#
# == Attributes
#
# * loan_id: integer - foreign key from 'loans' table.
# * book_id: integer - foreign key from 'books' table.
#
class LoanLine < ApplicationRecord
  # Associations
  #
  # Acts as intersect table between 'loans' and 'books'
  # Thus, one loan line has one loan.
  # And one loan line has one book.
  belongs_to :loan
  belongs_to :book
end
