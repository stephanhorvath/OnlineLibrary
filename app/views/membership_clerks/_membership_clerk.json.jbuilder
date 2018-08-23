json.extract! membership_clerk, :id, :first_name, :last_name, :address_line_1, :address_line_2, :town, :post_code, :tel_no, :email, :password_digest, :type, :created_at, :updated_at
json.url membership_clerk_url(membership_clerk, format: :json)
