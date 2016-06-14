# encoding: utf-8

class AttachmentUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_white_list
    %w(pdf doc htm html docx epub)
  end

  def default_url
    "default_book/" + [version_name, "default.pdf"].compact.join('_')
  end
end
