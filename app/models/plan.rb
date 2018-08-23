class Plan < ApplicationRecord
  # == Attributes
  #
  # * stripe_id: string
  # * nickname: string
  # * display_price: decimal
  # * product: string
  # * book_limi: integer

  # == Associations
  # Plan has one association
  #
  # * One plan has many members
  #
  has_many :members
end
