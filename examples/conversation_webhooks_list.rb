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

  # Fetch the Webhooks list
  offset = 0
  limit = 10
  webhooks = client.conversation_webhooks_list(limit, offset)

  # Print the object information.
  puts "The following information was returned as a Webhooks list:"
  puts
  puts "  count           : #{webhooks.count}"
  puts "  limit           : #{webhooks.limit}"
  puts "  offset          : #{webhooks.offset}"
  puts "  totalCount      : #{webhooks.totalCount}"
  puts 
  webhooks.items.each do |webhook|
     puts "Webhook:"
     puts "  id                        : #{webhook.id}"
     puts "  events                    : #{webhook.events}"
     puts "  channelId                 : #{webhook.channelId}"
     puts "  url                       : #{webhook.url}"
     puts "  status                    : #{webhook.status}"
     puts "  createdDatetime           : #{webhook.createdDatetime}"
     puts "  updatedDatetime           : #{webhook.updatedDatetime}"
  end 

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
