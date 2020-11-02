# config/initializers/pdfkit.rb
PDFKit.configure do |config|
  config.wkhtmltopdf = 'which wkhtmltopdf'
  config.default_options = {
      :encoding => "UTF-8",
      :page_size => "A5", #or "Letter" or whatever needed
      :margin_top => "0",
      dpi: 300,
      :margin_right => "0",
      :margin_bottom => "0",
      :margin_left => "0",
      orientation: 'Landscape',
      :disable_smart_shrinking => false,
  }
  config.verbose = true
end
