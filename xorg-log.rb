#!/usr/bin/env ruby
# encoding : utf-8


class LogParser
  def initialize( logfile = '/var/log/Xorg.0.log' )
    @file = logfile

    @logs = {
      :errors => [],
      :warnings =>  []
    }

    run
    display
  end

  def run
    lines = File.readlines( @file ) 
    lines.each do |line|
      @logs[ :errors ] << line.gsub( /.*?\) (.*)/, "\\1" ) if line =~ /\(EE\)/ and not line =~ /\(WW\).*\(EE\)/
      @logs[ :warnings ] << line.gsub( /.*?\) (.*)/, "\\1" ) if line =~ /\(WW\)/ and not line =~ /\(WW\).*\(EE\)/
    end
  end

  def display
    puts "\n\n\n\033[01;33m⚠ ⚠ ⚠ ⚠ ⚠ ⚠ ⚠ ⚠ ⚠ ⚠ ⚠ ⚠ ⚠ ⚠ ⚠   Warning   ⚠ ⚠ ⚠ ⚠ ⚠ ⚠ ⚠ ⚠ ⚠ ⚠ ⚠ ⚠ ⚠ ⚠ ⚠ ⚠\n⚠ \033[00;38m"
    @logs[ :warnings ].each { |warning| puts "\033[01;33m⚠ \033[00;38m Can haz security? : " + warning }
    puts "\033[01;33m⚠ \n⚠ ⚠ ⚠ ⚠ ⚠ ⚠ ⚠ ⚠ ⚠ ⚠ ⚠ ⚠ ⚠ ⚠ ⚠ ⚠ ⚠ ⚠ ⚠ ⚠ ⚠ ⚠ ⚠ ⚠ ⚠ ⚠ ⚠ ⚠ ⚠ ⚠ ⚠ ⚠ ⚠ ⚠ ⚠ ⚠ ⚠ \033[00;38m\n"

    puts "\n\n\033[01;31m### Errors ###\033[00;38m\n"
    @logs[ :errors ].each { |error| puts "FAIL! : " + error }
  end
end

LogParser.new
