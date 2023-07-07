class SearchResultsView
  def self.render(results)
    template = File.read('./http/geonames/html/results.html')

    results.map do |result|
      result.inject(template) do |acc, (key, value)|
        acc = acc.gsub("{{#{key}}}", value || '')
        acc
      end
    end.join
  end
end
