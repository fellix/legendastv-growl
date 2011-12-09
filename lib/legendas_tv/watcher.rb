#encoding: utf-8
require 'growl'
require 'legendastv-crawler'

module LegendasTV
  class Watcher
    include Growl
    
    def initialize
      bin_path = '/usr/local/bin/growlnotify'
      @most_downloaded = Crawler.most_downloaded
      @highlights = Crawler.highlights
    end
    
    def run
      runner_thread = Thread.new do
        while true do
          watch_changes
          sleep 300
        end
      end
      runner_thread.join
    end
    
    protected
    def watch_changes
      @most_downloaded = watch @most_downloaded, :most_downloaded
      @highlights = watch @highlights, :highlights
    end
    
    def watch array, method
      actual = Crawler.send(method)
      actual.each do |subtitle|
        found = false
        array.each do |old_subtitile|
          if old_subtitile == subtitle
            found = true
          end
        end
        notify_subtitle(subtitle) if !found
      end
      actual
    end
    
    def notify_subtitle subtitle
      puts "Nova legenda #{subtitle.inspect}"
      notify_ok "Nova legenda #{subtitle[:title]}"
    end
    
  end
end