require_relative 'http_client.rb'

class DHHScore

  URL = "https://api.github.com/users/dhh/events/public".freeze
  DEFAULT_SCORE = 1.freeze
  SCORE_PER_EVENT = Hash.new(DEFAULT_SCORE).merge({
    "IssuesEvent" => 7,
    "IssueCommentEvent" => 6,
    "PushEvent" => 5,
    "PullRequestReviewCommentEvent" => 4,
    "WatchEvent" => 3,
    "CreateEvent" => 2
  }).freeze

  def get_final_score
    events = client.get
    calculate_final_score(events)
  rescue HttpClientError => e
    puts "HTTP error: #{e.message}"
  rescue SocketError => e
    puts "Socket error: Couldn't establish connection with github."
    puts e.message
  end

  private
  def client
    @client ||= HttpClient.new(URL)
  end

  def calculate_final_score(events)
    events.inject(0) do |score, event|
      next unless event.key?("type")
      score += SCORE_PER_EVENT[event["type"]]
    end
  end

end
