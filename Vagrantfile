#
# Vagrant File
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

Vagrant::Config.run do |config|
  config.vm.box = "squeeze64"

  # Jenkins Server
  config.vm.define :master do |config|
    config.vm.forward_port 80, 8082
    config.vm.provision :chef_solo do |chef|
      chef.cookbooks_path = "chef/cookbooks"
      chef.roles_path     = "chef/roles"
      chef.data_bags_path = "chef/data_bags"
      chef.add_recipe "jenkins::jenkins_server"
      chef.add_role "jenkins_server"
     end
  end
end
