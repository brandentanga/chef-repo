#!/usr/bin/ruby
# Cookbook Name:: webserver
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
package "nginx"
package "git"
#directory "/srv/www/hello_world" do
#  owner "root"
#  group "root"
#  mode "0755"
#  action :create
#end
%w[/srv /srv/www /srv/www/hello_world].each do |path|
  directory path do    
    mode "0755"
    action :create
  end
end
#file "/srv/www/hello_world/hello.txt" do 
#  content "hello world"
#  only_if { Dir.exists?("/srv/www/hello_world") }
#end
git "/srv/www/hello_world" do
  repository "https://github.com/brandentanga/hello_world.git"
  revision "master"
  action :sync
  only_if { Dir.exists?("/srv/www/hello_world") }
  notifies :run, "execute[move_default]", :immediately
end
file "/etc/nginx/sites-available/default" do
  action :delete
end
execute "move_default" do
  command "cp /srv/www/hello_world/default /etc/nginx/sites-available/default"
  action :run
  notifies :restart, "service[nginx]"
end
service "nginx" do
  supports :restart => true
  action :restart
end
#file "/etc/nginx/sites-available/default" do
#  mode 0755
#  content File.open("/srv/www/hello_world/default").read
#  action :create
#  only_if { File.exists?("/srv/www/hello_world/default") }
#end
