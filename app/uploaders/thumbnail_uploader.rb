class ThumbnailUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave

  version :standard do
    process :resize_to_fill => [100, 150, :north]
  end

  version :thumbnail do
    resize_to_fit(50, 50)
  end

  def extension_white_list
    %w(png jpg jpeg gif)
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url
    "default_book/" + [version_name, "default.jpg"].compact.join('_')
  end
end
