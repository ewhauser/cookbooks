#
# Cookbook Name:: jmxtrans
# Recipe:: default
#
# Copyright 2011, Eric Hauser
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
include_recipe "logrotate"
include_recipe "java"

package "cron"
package "unzip"

remote_file "/tmp/jmxtrans-#{node[:jmxtrans][:version]}.zip" do
  source "http://jmxtrans.googlecode.com/files/jmxtrans-#{node[:jmxtrans][:version]}.zip"
  checksum node[:jmxtrans][:checksum]
  mode "0644"
end

bash "unzip jmxtrans" 
  user "root"
  cwd "/tmp"
  code %(unzip /tmp/jmxtrans-#{node[:jmxtrans][:version]}.zip)
  not_if { File.exists? "/tmp/jmxtrans-#{node[:jmxtrans][:version]}" }
end

bash "copy jmxtrans root" do
  user "root"
  cwd "/tmp"
  code %(cp -r /tmp/jmxtrans-#{node[:jmxtrans][:version]}/* /usr/local/jmxtrans-#{node[:jmxtrans][:version]})
  not_if { File.exists? "/usr/local/jmxtrans-#{node[:jmxtrans][:version]}" }
end

directory "#{node[:jmxtrans][:config_dir]}" do
  owner "root"
  group "root"
  mode 0755
end

template "/bin/jmxtrans" do
  source "jmxtrans.erb"
  owner "root"
  group "root"
  mode 0755
end

cron "jmxtrans" do
  command "/bin/jmxtrans"
end

link "#{node[:jmxtrans][:basedir]}" do
  to "/usr/local/jmxtrans-#{node[:jmxtrans][:version]}"
end

logrotate_app "jmxtrans" do
  cookbook "logrotate"
  path [ "/var/log/jmxtrans.log" ]
  frequency "daily"
  create "644 root root"
  rotate 4
end

