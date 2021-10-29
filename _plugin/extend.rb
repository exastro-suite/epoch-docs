class Jekyll::Converters::Markdown::MyCustomProcessor
  def convert(content)

  # small word
  content.gsub! /(^|\s)(--\w+)/ do
    "#{$1}<small>#{$2}</span>"
  end

  old_convert(content)
end