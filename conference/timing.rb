require "time"

module Timings
  TIMING = [
    {
      start_time: Time.parse("09:00"),
      end_time: Time.parse("12:00"),
      duration: 180
    },
    {
      start_time: Time.parse("01:00"),
      end_time: Time.parse("05:00"),
      duration: 240
    }
  ].freeze
end
