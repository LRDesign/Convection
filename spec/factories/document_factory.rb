Factory.define :document do |document|
  document.sequence(:name) { |n| "Document Name #{n}"}
  document.description "Description"
  document.data_file_name "value for data_file_name"
  document.data_content_type "value for data_content_type"
  document.data_file_size "value for data_size"
  document.data_updated_at Time.now
  document.user_id 1
end