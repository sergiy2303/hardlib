FactoryGirl.define do
  factory :book do
    title { 'Super Title' }
    description { 'Some description' }
    author { 'Richard Bah' }
    year { '2012' }
    pages { '150' }
    attachment { Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/fixtures/books/default.pdf'))) }
  end
end
