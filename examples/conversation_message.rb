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

  # Fetch a message
  msg = client.conversation_message('00000000000000000000000000000000')
   
  # Print the object information.
  puts <<EOF
The following information was returned as a Message object:
    id                        : #{msg.id}
    conversationId            : #{msg.conversationId}
    channelId                 : #{msg.channelId}
    direction                 : #{msg.direction}
    type                      : #{msg.type}
    status                    : #{msg.status}
    content                   : #{msg.content}
    createdDatetime           : #{msg.createdDatetime}
    updatedDatetime           : #{msg.updatedDatetime}
EOF

rescue MessageBird::ErrorException => ex
  puts
  puts 'An error occured while creating a conversation:'
  puts

  ex.errors.each do |error|
    puts "  code        : #{error.code}"
    puts "  description : #{error.description}"
    puts "  parameter   : #{error.parameter}"
    puts
  end
end
