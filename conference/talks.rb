module Talks
  TALKS = {
    "Pryin open the black box": 60,
    "Migrating a huge production codebase from sinatra to Rails": 45,
    "How does bundler work": 30,
    "Sustainable Open Source": 45,
    "How to program with Accessiblity in Mind": 45,
    "Riding Rails for 10 years": "lightning",
    "Implementing a strong code review culture": 60,
    "Scaling Rails for Black Friday": 45,
    "Docker isn't just for deployment": 30,
    "Better callbacks in Rails 5": 30,
    "Microservices, a bittersweet symphony": 45,
    "Teaching github for poets": 60,
    "Test Driving your Rails Infrastucture with Chef": 60,
    "SVG charts and graphics with Ruby": 45,
    "Interviewing like a unicorn: How Great Teams Hire": 30,
    "How to talk to humans: a different approach to soft skills": 30,
    "Getting a handle on Legacy Code": 60,
    "Heroku: A year in review": 30,
    "Ansible : An alternative to chef": "lightning",
    "Ruby on Rails on Minitest": 30
  }.freeze

  def talks
    @talks ||= TALKS.map{ |title, duration| Talk.new(title, duration) }
  end
end

class Talk
  LIGHTING_DURATION = 5.freeze
  attr_reader :title, :duration, :lightning
  attr_accessor :start_time, :end_time, :track

  def initialize(title, duration)
    self.title = title
    if duration == "lightning"
      self.lightning = true
      self.duration = LIGHTING_DURATION
    else
      self.lightning = false
      self.duration = duration
    end
  end

  private
  attr_writer :title, :duration, :lightning
end
