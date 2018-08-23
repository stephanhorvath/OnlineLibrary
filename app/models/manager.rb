class Manager < Employee
  before_save :set_type

  # METHODS

  def set_type
    self.type = "Manager"
  end
end
