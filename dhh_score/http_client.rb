require 'httpclient'
require 'json'

class HttpClient

  attr_reader :uri, :client
  def initialize(uri)
    self.uri = uri
    self.client = HTTPClient.new
  end

  def get
    response = self.client.get(self.uri)
    if response.status == 200
      JSON.parse(response.content)
    else
      raise HttpClientError, "#{response.status}, #{JSON.parse(response.content)["message"]}"
    end
  end

  private
  attr_writer :uri, :client

end

class HttpClientError < StandardError
end
