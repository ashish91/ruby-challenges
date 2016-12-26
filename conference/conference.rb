require_relative "timing"
require_relative "talks"
require_relative "scheduling_logic"
require_relative "output_formatter"

scheduled_talks, unscheduled_talks = SchedulingLogic.new.schedule
OutputFormatter.new(scheduled_talks, unscheduled_talks).print
