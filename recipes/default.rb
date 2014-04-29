#
# Cookbook Name:: mailee-app
# Recipe:: default
#
# Copyright (C) 2014 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
include_recipe "bluepill"

package "libsqlite3-dev"
rmagick_dependencies = %w{imagemagick libmagickcore-dev libmagickcore5 librmagick-ruby graphicsmagick imagemagick-common libmagick++-dev}
rmagick_dependencies.each{|d| package d }

template '/etc/bluepill/mailee.pill' do
  source 'mailee.pill.erb'
end

bluepill_service 'mailee' do
  action [:enable, :load, :start]
end

link "/usr/local/bin/bluepill" do
  to "/usr/local/rbenv/shims/bluepill"
end

%w{libxrender1 libfontconfig1 otf-ipafont-gothic libxext6}.each do |pkg|
  package pkg do
    action :install
  end
end

bash "wkhtmltoimage install." do
  user "root"
  cwd "/tmp"
  code <<-EOH
    wget https://wkhtmltopdf.googlecode.com/files/wkhtmltoimage-0.11.0_rc1-static-i386.tar.bz2
    tar xjfv wkhtmltoimage-0.11.0_rc1-static-i386.tar.bz2
    mv wkhtmltoimage-i386 /usr/local/bin/wkhtmltoimage
  EOH
end
