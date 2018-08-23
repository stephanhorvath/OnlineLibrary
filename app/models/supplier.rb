class Supplier < ApplicationRecord
  # == Attributes
  #
  # * name: string
  # * url: string
  #
  # == Associations
  # Supplier has one association
  #
  # One supplier has many books
  #
  has_many :books
end
