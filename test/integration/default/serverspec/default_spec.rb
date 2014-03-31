require 'net/http'
require 'serverspec'

include Serverspec::Helper::Exec
include Serverspec::Helper::DetectOS

describe file('/root/.aws/config') do
  it { should be_a_file }
end

describe file('/home/deploy/.aws/config') do
  it { should be_a_file }
end
