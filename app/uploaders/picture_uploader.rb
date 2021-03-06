# encoding: utf-8

class PictureUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick

  # Image resize will be done via styling but it can be done with MiniMagick resize. Uncomment lines 13-14 to enable.
  # note ImageMagick must be installed (brew install imagemagick for Mac)
  # in order for MiniMagick to work, otherwise the resizing will not work
  # and an error will raise if the user attempts to post with the image
  # type `which convert` to see where ImageMagick is installed => `/usr/local/bin/convert`
  # include CarrierWave::MiniMagick
  # process resize_to_limit: [400, 400]

  # Choose what kind of storage to use for this uploader:
  if Rails.env.production?
    storage :fog  # AWS S3 will be used for storing
  else
    storage :file
  end

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process :resize_to_fit => [50, 50]
  # end

  # server side file extension white list validation
  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg gif png)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end
