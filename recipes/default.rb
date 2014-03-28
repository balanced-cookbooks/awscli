#
# Cookbook Name:: awscli
# Recipe:: default
#
# Copyright (C) 2013 Balanced
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#

# we need python setup, alongside pip
include_recipe "python"

# installs the awscli from aws
# this gives us really sweet commands like aws s3 sync and s3 cp
python_pip "awscli" do
  action :install
end

case node[:platform_family]
  # install createrepo tool as well, we need this for rpms
  when 'rhel'
    yum_package "createrepo" do
      action :install
    end
  else
end

if not node['ec2']
  template '/root/.aws/config' do
    source 'aws_config.erb'
    owner 'root'
    group 'root'
    mode  '644'
    variables(
              access_key_id: citadel.access_key_id,
              secret_access_key: citadel.secret_access_key,
              security_token: citadel.token ? citadel.token : '',
              region: 'us-west-1'
              )
  end

end
