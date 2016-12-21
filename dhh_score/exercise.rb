require_relative 'dhh_score.rb'

dhh = DHHScore.new
score = dhh.get_final_score
puts "DHH's github score is #{score}" unless score.nil?
