$:.unshift 'lib'
require 'legendastv-growl'

puts "Starting the watcher..."
watcher = LegendasTV::Watcher.new
puts "Watcher started..."
watcher.run
puts "Bye!"
