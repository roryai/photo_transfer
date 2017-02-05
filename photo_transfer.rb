require 'FileUtils'
require 'exifr'
require_relative 'directory_manager.rb'
require_relative 'file_manager.rb'

class Transfer

  extend DirMgr
  extend FileMgr

  attr_reader :camera_dir, :computer_dir, :file_name_array

  def initialize
    @camera_dir = "/Volumes/Untitled/test/"
    @computer_dir = "/Users/rory/Documents/tester/"
    @file_name_array = Transfer.get_file_names(@camera_dir)
    @exifr_time_array = Transfer.get_exifr_time_array(@camera_dir)
  end

  def single_photo_transfer(copy_from, copy_to)
    FileUtils.copy_file(copy_from, copy_to, preserve = false, dereference = true)
  end

  def copy_all_photos(camera_dir, computer_dir)
    photo_list = Transfer.get_file_names(camera_dir)
    photo_list.each do |file_name|
      single_photo_transfer(camera_dir + "#{file_name}", computer_dir + "#{file_name}")
    end
  end

  def transfer_photos_to_dated_directories
    Transfer.create_dir_by_date_taken(@exifr_time_array, @computer_dir)

  end

end

# copy_all_photos(@camera_dir, @computer_dir)

# create_dir_by_date_taken(@exifr_time_array, @computer_dir)

# get_exifr_time_array(get_file_names(CAMERA_DIR))
