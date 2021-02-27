# frozen_string_literal: true

class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  include Piet::CarrierWaveExtension
  
  # CarrierWave.configure do |config|
  #   module MiniMagick
  #     def quality(percentage)
  #       manipulate! do |img|
  #         img.quality(percentage.to_s)
  #         img = yield(img) if block_given?
  #         img
  #       end
  #     end
  #   end
  # end
  
  # process quality: 80

  if Rails.env.production?
    include Cloudinary::CarrierWave
    CarrierWave.configure do |config|
      config.cache_storage = :file
    end
  else
    storage :file
  end

  def store_dir
    if Rails.env.test?
      "uploads_#{Rails.env}/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    else
      "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    end
  end

  version :thumb do
    # process resize_to_limit: [300, 200]
    process resize_to_fill: [500, 500, "Center"]
    # process :custom_optimize
  end

  def extension_whitelist
    %w[jpg jpeg gif png]
  end

  # def mimetype
  #   IO.popen(["file", "--brief", "--mime-type", path], in: :close, err: :close) { |io| io.read.chomp.sub(/image\//, "") }
  # end
  
  # def custom_optimize
  #   case mimetype
  #     when "png" then pngquant
  #     when "jpeg", "gif" then optimize(quality: 90)
  #   end
  # end
end
