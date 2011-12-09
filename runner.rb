$:.unshift 'lib'
require 'legendastv-growl'

puts "Starting the watcher..."
watcher = LegendasTV::Watcher.new
puts "Watcher created..."
main_thread = Thread.new do
  watcher.run
end
puts "Watcher started..."
main_thread.join
