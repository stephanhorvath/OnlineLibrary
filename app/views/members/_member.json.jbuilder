json.extract! member, :id, :first_name, :last_name, :address_line_1, :address_line_2, :town, :post_code, :tel_no, :email, :password_digest, :type, :created_at, :updated_at
json.url member_url(member, format: :json)
