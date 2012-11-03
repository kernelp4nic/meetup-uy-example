#
# role:: jenkins_server.rb
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

name        "jenkins_server"
description "Jenkins CI Server"

override_attributes "apt" => {
  "cache_server" => "apt-cacher.inconcert"
}

run_list [
  "recipe[jenkins::jenkins_server]"
]
