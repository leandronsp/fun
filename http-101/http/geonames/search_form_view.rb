class SearchFormView
  def self.render
    File.read('./http/geonames/html/form.html')
  end
end
