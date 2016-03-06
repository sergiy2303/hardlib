class ThumbnailUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave

  version :standard do
    process :resize_to_fill => [300, 300, :north]
  end

  version :thumbnail do
    process :resize_to_fill => [150, 200, :north]
  end

  def extension_white_list
    %w(png jpg jpeg gif)
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url
    "default_book/" + "default.jpg"
  end
end
