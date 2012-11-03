#
# recipe:: jenkins_slave.rb
#
# Author:: Sebastián Moreno <smoreno@inconcertcc.com>
# Author:: Federico Silva <fsilva@inconcertcc.com>
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

include_recipe "apt"

package "sudo" 

user "jenkins" do
  comment "jenkins account"
  system  true
  shell   "/bin/bash"
  home    "/var/lib/jenkins"
end

directory "/var/lib/jenkins/bin" do
  owner     "jenkins"
  group     "jenkins"
  mode      "0755"
  action    :create
  recursive true
end

cookbook_file "/var/lib/jenkins/bin/start.sh" do
  source "start.sh" 
  mode "0754"
  owner     "jenkins"
  group     "jenkins"
end

directory "/var/lib/jenkins/.ssh" do
  owner     "jenkins"
  group     "jenkins"
  mode      "0755"
  action    :create
  recursive true
end

cookbook_file "/var/lib/jenkins/.ssh/authorized_keys" do
  source "authorized_keys" 
  mode "0600"
  owner     "jenkins"
  group     "jenkins"
end

cookbook_file "/var/lib/jenkins/.ssh/id_rsa.pub" do
  source  "builder_rsa.pub"
  owner   "jenkins"
  group   "jenkins"
  mode    "0744"
end

cookbook_file "/var/lib/jenkins/.ssh/id_rsa" do
  source  "builder_rsa"
  owner   "jenkins"
  group   "jenkins"
  mode    "0700"
end

cookbook_file "/var/lib/jenkins/.ssh/known_hosts" do
  source  "known_hosts"
  owner   "jenkins"
  group   "jenkins"
  mode    "0744"
end

execute "change jenkins home permissions" do
  command "chown -R jenkins:jenkins /var/lib/jenkins"
end

SUDOERS_STANZA="jenkins    ALL = NOPASSWD: ALL"
execute "jenkins::sudo" do
  command "echo #{SUDOERS_STANZA} >> /etc/sudoers"
  not_if "grep '#{SUDOERS_STANZA}' /etc/sudoers"
end  

cookbook_file "/etc/nsswitch.conf" do
  source  "nsswitch.conf"
  owner   "root"
  group   "root"
  mode    "0644"
end

template "/etc/hosts" do
  source  "hosts.erb"
  owner   "root"
  group   "root"
  mode    "0644"
end
