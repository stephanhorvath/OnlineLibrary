# This class holds information about Books.
class Book < ApplicationRecord
  # == Attributes
  #
  # * title: string
  # * author: string
  # * description: string
  # * genre: string
  # * supplier_id: integer - foreign_key from 'suppliers' table.
  # * type: string
  # * cover: image

  # == Associations
  # Book has several associations:
  #
  # * Book has many Loan Lines - links 'books' and 'loan_lines' tables.
  # * Book has many Loans through Loan Lines - many-to-many association
  #   between 'books' and 'loans' with 'loan_lines' as intersect table.
  # * Book belongs to Supplier - foreign key column from 'suppliers' table.
  # * Book has an attached image.
  has_many :loan_lines
  has_many :loans, through: :loan_lines
  belongs_to :supplier
  has_attached_file :cover, styles: { medium: '300x300>', thumb: '100x100>' }

  # == Validations
  # Validations for all attributes ensure presence,
  # correct type, format, and length
  validates :title,       presence: true, length: { maximum: 60 }
  validates :author,      presence: true, length: { maximum: 60 }
  validates :description, presence: true, length: { maximum: 500 }
  validates :genre,       presence: true, length: { maximum: 50 }
  validates :supplier_id, presence: true, length: { maximum: 2 },
                          numericality: { only_integer: true, greater_than: 0 }
  validates :type,        presence: true
  validates_attachment_content_type :cover, content_type: %r{\Aimage\/.*\z}

  # == Before Saving Object
  # Ensures that before the object is saved to the database,
  # title, author and genre, are downcased
  # And that the book cover attribute is obtained from
  # an Amazon Web Services S3 Bucket
  before_save { self.title  = title.downcase }
  before_save { self.author = author.downcase }
  before_save { self.genre  = genre.downcase  }
  before_save :cover_remote_url

  private

  # Gets an image from an Amazon Web Services S3 bucket
  # and assigns it to the current object's cover attribute.
  def cover_remote_url
    self.cover = URI.parse('https://s3.amazonaws.com/reallall-library-cogc-us/book1.png')
  end
end
