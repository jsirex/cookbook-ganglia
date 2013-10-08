# Building search query at very latest phase of node attribute populate
# wrapper-cookbooks, or dependent cookbooks may override some parameters of search query

# Search query for gmond instances 
query = []
query << "chef_environment:#{node.chef_environment}"
query << "recipe:ganglia\\:\\:gmond"
query << "ganglia_gmond_conf_cluster_name:*"
node.default['ganglia']['gmetad']['search_data_sources'] = query.join(' AND ')

nodes = search(:node, node['ganglia']['gmetad']['search_data_sources'])

data_sources = {}

nodes.each do |n|
  cluster_name = n['ganglia']['gmond']['conf']['cluster']['name']
  polling_interval = 20 # TODO: remove hardcode
  host = node['ganglia']['gmetad']['use_fqdn'] ? n['fqdn'] : n['ipaddress']
  port = n['ganglia']['gmond']['conf']['tcp_accept_channel']['port']
  if data_sources[cluster_name]
    data_sources[cluster_name]['polling_interval'] = polling_interval
    data_sources[cluster_name]['hosts'] << "#{host}:#{port}"
  else
    data_sources[cluster_name] = {
      'polling_interval' => polling_interval,
      'hosts' => ["#{host}:#{port}"]
    }
  end
end

data_sources.each_pair do |name, opts|
  Chef::Log.info("[Ganglia] Found gmond cluster: #{name} #{opts['polling_interval']} #{opts['hosts'].join(' ')}")
end

node.default['ganglia']['gmetad']['conf']['data_sources'] = data_sources
