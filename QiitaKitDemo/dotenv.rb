#!/usr/bin/env ruby

require 'bundler/setup'
require 'dotenv'

Dotenv.load

File.open("dotenv.swift", "w") do |f|

f.puts "public struct ENV {"

ENV.each {|k, v|
    vv = v.gsub('"', '\"')
    if k != "_"
    f.puts "    static let #{k} = \"#{vv}\""
    end
}

unless ENV["DEMO_QIITA_CLIENT_ID"] then
  f.puts "    static let DEMO_QIITA_CLIENT_ID = \"\""
end
unless ENV["DEMO_QIITA_CLIENT_SECRET"] then
  f.puts "    static let DEMO_QIITA_CLIENT_SECRET = \"\""
end
unless ENV["DEMO_QIITA_CALLBACK_URL"] then
  f.puts "    static let DEMO_QIITA_CALLBACK_URL = \"\""
end

f.puts "}"
end
