class OutputFormatter

  def initialize(scheduled, unscheduled)
    self.scheduled = scheduled
    self.unscheduled = unscheduled
  end

  def print
    print_scheduled
    print_unscheduled
  end


  private
  def print_scheduled
    grouped_by_track = scheduled.group_by(&:track)
    grouped_by_track.each do |track, talks|
      puts "Track #{track}"
      talks.each do |talk|
        print_talk(talk)
      end
    end
  end

  def print_unscheduled
    return if unscheduled.empty?

    puts "Unscheduled Talks"
    unscheduled.each do |talks|
      talks.each do |talk|
        print_talk(talk)
      end
    end
  end

  def print_talk(talk)
    puts [talk.start_time.nil? ? "" : talk.start_time.strftime("%H:%M %p"), talk.title, talk.duration, "min"].join(" ")
  end

  attr_accessor :scheduled, :unscheduled
end
