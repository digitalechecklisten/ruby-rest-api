#!/usr/bin/env ruby

$:.unshift File.expand_path(File.dirname(__FILE__) + '/../lib/')
require 'messagebird'

# ACCESS_KEY = ''

unless defined?(ACCESS_KEY)
  puts 'You need to set an ACCESS_KEY constant in this file'
  exit 1
end

begin
  # Create a MessageBird client with the specified ACCESS_KEY.
  client = MessageBird::Client.new(ACCESS_KEY)

  # Send a message
  message = client.send_conversation_message('channelID', '+31617100000', :type => 'text', :content => {:text => 'Hi there!'})

  # Print the object information.
  puts
  puts "The following information was returned as a response:"
  puts "  id  : #{message.id}"
  puts "  status  : #{message.status}"

  unless message.fallback.nil?
    puts "  fallback  : #{message.fallback}"
  end

  puts


rescue MessageBird::ErrorException => ex
  puts
  puts 'An error occured while sending a message:'
  puts

  ex.errors.each do |error|
    puts "  code        : #{error.code}"
    puts "  description : #{error.description}"
    puts "  parameter   : #{error.parameter}"
    puts
  end
end
