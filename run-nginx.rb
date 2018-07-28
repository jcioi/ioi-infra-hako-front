#!/usr/bin/env ruby
require 'aws-sdk-s3'

s3 = Aws::S3::Client.new()
File.open('/etc/nginx/conf.d/default.conf', 'w') do |io|
  s3.get_object(
    bucket: ENV.fetch('S3_CONFIG_BUCKET'),
    key: ENV.fetch('S3_CONFIG_KEY'),
    response_target: io,
  )
end

exec('nginx', '-g', 'daemon off;')
