require 'rest-client'

class Bing
  @search_result_regexp = //
  def initialize
    @base_url = 'www.bing.com'
  end
  def search input
    search_url = "#{@base_url}/search?q=#{input}"
    response = RestClient.get(search_url)
    puts "Searching #{input}..."
    puts "Status code:#{response.code}"
    if response.code == 200
      puts "TOP 5 RESULTS"
      puts scan_search_result(response.body)[0,5]
    else
      puts "error occured with #{response.code} code"
    end
  end

  private

  def scan_search_result request_body
    request_body.scan(/<\s*ol id="b_results"[^>]*>(.*?)<\/\s*ol>/).join("")
                .scan(/<a\s+(?:[^>]*?\s+)?href="([^"]+\?[^"]+)"/)
  end
end

bing = Bing.new

bing.search('hello')
puts
bing.search('burhan turker')

