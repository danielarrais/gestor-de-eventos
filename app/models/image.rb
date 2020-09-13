class Image < ApplicationRecord
  validates_presence_of :format, :content
  validate :format_invalid, if: -> (x) {x.file.present?}

  before_validation :extract_info_of_file

  attr_accessor :file, :allowed_extensions

  def initialize(attributes = nil)
    @allowed_extensions = [:png]
    super
  end

  def url
    "data:#{self.format};base64,#{Base64.strict_encode64(self.content)}" if content.present? and !self.new_record?
  end

  private

  def extract_info_of_file
    if self.file.present?
      self.format = self.file.content_type
      self.content = self.file.read
    end
  end

  def format_invalid
    file_extension = file.content_type.split('/').last
    menssage_params = [extension: file_extension, extensions: allowed_extensions.join(', ')]

    self.errors.add(:format, :format_invalid, *menssage_params) unless allowed_extensions.include?(file_extension.to_sym)
  end
end
