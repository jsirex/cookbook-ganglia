include_recipe "ganglia::_search_attributes"
# Installs gmond in master mode (unicast)

# Override settings to act as unicastmaster
node.default['ganglia']['gmond']['conf']['globals']['send_metadata_interval'] = 30

# define recv channel for others 
# TODO: hardcode. remove do merge
node.default['ganglia']['gmond']['conf']['udp_recv_channels'] = [{
  'bind' => node['ipaddress'],
  'port' => 8649  
}]

masters = Chef::Config[:solo] ? [node] : search(:node, node['ganglia']['search']['gmond_cluster_masters'])
node.default['ganglia']['gmond']['conf']['udp_send_channels'] = Ganglia.get_udp_send_channels(masters)


include_recipe "ganglia::gmond"

# Used for chef search features
node.override['ganglia']['recipe']['gmond_unicast_master'] = true