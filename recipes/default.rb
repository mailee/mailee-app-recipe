#
# Cookbook Name:: mailee-app
# Recipe:: default
#
# Copyright (C) 2014 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
include_recipe "bluepill"

package "libsqlite3-dev"
package "wkhtmltopdf"
rmagick_dependencies = %w{imagemagick libmagickcore-dev libmagickcore5 librmagick-ruby graphicsmagick imagemagick-common libmagick++-dev}
rmagick_dependencies.each{|d| package d }

template '/etc/bluepill/mailee.pill' do
  source 'mailee.pill.erb'
end

bluepill_service 'mailee' do
  action [:enable, :load, :start]
end

link "/usr/local/bin/bluepill" do
  to "/opt/rbenv/shims/bluepill"
end

