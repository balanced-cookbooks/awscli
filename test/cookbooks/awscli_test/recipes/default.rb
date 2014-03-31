user 'deploy' do

end

directory '/home/deploy' do
  owner 'deploy'
  group 'deploy'
end

ohai 'reload' do
  action :reload
end

include_recipe 'awscli'
