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
include_recipe 'balanced-apt'
include_recipe 'python'

# installs the awscli from aws
# this gives us really sweet commands like aws s3 sync and s3 cp
python_pip 'awscli' do
  action :install
end

unless node['ec2']
  vars = {
      :access_key_id => citadel.access_key_id,
      :secret_access_key => citadel.secret_access_key,
      :security_token => citadel.token,
      :region => 'us-west-1',
  }
  node['awscli']['users'].each do |user|
    home = node['etc']['passwd'][user]['dir']
    directory "#{home}/.aws" do
      owner user
      group user
    end
    template "#{home}/.aws/#{node['awscli']['config_name']}" do
      source 'aws_config.erb'
      owner user
      group user
      mode '644'
      variables(vars)
    end
  end
end
