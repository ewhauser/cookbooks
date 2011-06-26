#
# Cookbook Name:: jmxtrans
# Attributes:: default
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

default[:jmxtrans][:version] = "161"
default[:jmxtrans][:checksum] = "1e613b018371299a5f4dbdbaed559bce102e23c5"
default[:jmxtrans][:base_dir] = "/usr/local/jmxtrans"
default[:jmxtrans][:config_dir] = "/etc/jmxtrans"
default[:jmxtrans][:jmx_port] = "9902"
