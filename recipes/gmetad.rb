# Building search queries on runtime
unless Chef::Config[:solo] 
  include_recipe "ganglia::_search"
end

node['ganglia']['gmetad']['packages'].each do |pkg|
  package pkg do
    action :install
  end
end

template "/etc/ganglia/gmetad.conf" do
  source "gmetad.conf.erb"
  variables :conf => node['ganglia']['gmetad']['conf']
  notifies :restart, "service[gmetad]"
end

service "gmetad" do
  supports :restart => true
  action [ :enable, :start ]
end
