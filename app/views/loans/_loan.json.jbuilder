json.extract! loan, :id, :begin_date, :end_date, :returned, :created_at, :updated_at
json.url loan_url(loan, format: :json)
