#
# Cookbook Name:: jmxtrans
# Definition:: jmxtrans_query
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
define :jmxtrans_query, :options => {}, :template => nil, :cookbook => nil do
  nodes = []
  search(:node, "run_list:role\\[graphite\\] AND chef_environment:#{node[:chef_environment]}") do |sn|
    nodes << "#{sn.fqdn}"
  end

  attrjson = "["
  if params[:options][:attrs].is_a? Array
    attrjson << params[:options][:attrs].collect { |a| "\"#{a}\"" }.join(',')
  end
  attrjson << "]"

  template "/etc/jmxtrans/#{params[:name]}.json" do
    owner "root"
    group "root"
    mode "644"
    source "carbon.json.erb"
    cookbook "jmxtrans"
    variables :graphite_ip => "#{nodes[0]}", :jmx_port => "#{params[:jmx_port]}" , :obj => params[:options][:obj], :attrs => attrjson
  end
end
