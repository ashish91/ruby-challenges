require 'pry-byebug'

class SchedulingLogic
  include Talks
  include Timings

  attr_reader :talks_by_duration, :overlapping, :durations, :scheduled_talks

  def initialize
    self.talks_by_duration = talks.group_by(&:duration)
    self.scheduled_talks = []
    self.durations = self.talks_by_duration.keys.sort_by{ |x| -1 * x }
    self.overlapping = overlapping_durations(self.durations)
  end

  def overlapping_durations(durations)
    overlapping = { }
    durations = durations.each_with_index do |d, i|
      j = i
      while j < durations.length
        if d % durations[j] == 0
          overlapping[d] ||= []
          overlapping[d] << durations[j]
        end
        j += 1
      end
    end
    overlapping
  end

  def schedule
    TIMING.each do |t|
      current_duration = t[:duration]
      current_start_time = t[:start_time]
      while !(current_slot = find_maximum_fitting_slot(current_duration)).nil?
        if talks_by_duration.key?(current_slot)
          talk = talks_by_duration[current_slot].first
          find_complementary_talks_and_set_timing(talk, current_start_time, current_slot)
          current_start_time += current_slot * 60
          current_duration -= current_slot
        end
      end
    end
    [ self.scheduled_talks, self.talks_by_duration.values.flatten ]
  end

  private
  attr_writer :talks_by_duration, :overlapping, :durations, :scheduled_talks

  def find_maximum_fitting_slot(duration)
    self.durations.detect{ |d| d <= duration }
  end

  def update_talk(talk, start_time, track)
    talk.start_time = start_time
    talk.end_time = start_time + talk.duration * 60
    talk.track = track
    self.scheduled_talks << talk
    self.talks_by_duration[talk.duration].delete(talk)
    if self.talks_by_duration[talk.duration].empty?
      self.talks_by_duration.delete(talk.duration)
      self.durations.delete(talk.duration)
    end
  end

  def find_complementary_talks_and_set_timing(talk, start_time, slot)
    update_talk(talk, start_time, 1)

    complementary_talks = get_complementary_talks(slot, talk.lightning)
    complementary_talks.each do |talk|
      update_talk(talk, start_time, 2)
      start_time += talk.duration * 60
    end
  end

  def get_complementary_talks(duration, is_lightning)
    return [] unless self.overlapping.key?(duration)

    current_duration = duration
    complementary_talks = []
    self.overlapping[duration].each do |d|
      if self.talks_by_duration.key?(d) && current_duration >= d
        multiplier = current_duration / d
        available = get_talks(d, is_lightning).first(multiplier)
        current_duration -= d * available.length
        complementary_talks += available
      end
    end

    complementary_talks
  end

  def get_talks(duration, is_lightning)
    talks = self.talks_by_duration[duration]
    if is_lightning
      talks.reject(&:lightning)
    else
      talks
    end
  end

end
