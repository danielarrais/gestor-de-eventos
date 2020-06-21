class Archive < ApplicationRecord
  belongs_to :origin, polymorphic: true

  validates_presence_of :format, :content
  validate :format_invalid, if: -> (x) {x.file.present?}

  before_validation :extract_info_of_file

  attr_accessor :file, :allowed_extensions

  def initialize(attributes = nil)
    @allowed_extensions = [:pdf, :csv]
    super
  end

  private

  def extract_info_of_file
    if self.file.present?
      self.name = self.file.original_filename
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
