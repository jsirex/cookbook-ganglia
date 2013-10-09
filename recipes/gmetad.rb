include_recipe "ganglia::_search_attributes"

# TODO: Searches only in unicast mode
masters = Chef::Config[:solo] ? [node] : search(:node, node['ganglia']['search']['gmond_masters'])
node.default['ganglia']['gmetad']['conf']['data_sources'] = Ganglia.get_data_sources(masters, node['ganglia']['gmetad']['use_fqdn'])

node['ganglia']['gmetad']['conf']['data_sources'].each_pair do |name, opts|
  Chef::Log.info("[Ganglia] Found gmond cluster: #{name} #{opts['polling_interval']} #{opts['hosts'].join(' ')}")
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

# Used for chef search features
node.override['ganglia']['recipe']['gmetad'] = true