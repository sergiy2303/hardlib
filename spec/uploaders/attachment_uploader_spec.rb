require 'rails_helper'
require 'carrierwave/test/matchers'
PATH_TO_FILE = 'public/test/default.pdf'
describe AttachmentUploader do
  include CarrierWave::Test::Matchers
  before do
    @book = create(:book)
    AttachmentUploader.enable_processing = true
    @uploader = AttachmentUploader.new(@book, :attachment)

    File.open(PATH_TO_FILE) do |f|
      @uploader.store!(f)
    end
  end

  after do
    AttachmentUploader.enable_processing = false
    @uploader.remove!
  end

  it "should be the correct format and correct path" do
    expect(@uploader.filename).to eq('default.pdf')
    expect(@uploader.store_dir).to eq("uploads/book/attachment/#{@book.id}")
  end
end