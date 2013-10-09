include_recipe "ganglia::_search_attributes"
node.default['ganglia']['gmond']['conf']['globals']['send_metadata_interval'] = 30
node.default['ganglia']['gmond']['conf']['globals']['deaf'] = 'yes'
node.default['ganglia']['gmond']['conf']['udp_recv_channels'] = []

masters = Chef::Config[:solo] ? [node] : search(:node, node['ganglia']['search']['gmond_cluster_masters'])
node.default['ganglia']['gmond']['conf']['udp_send_channels'] = Ganglia.get_udp_send_channels(masters)

include_recipe "ganglia::gmond"

# Used for chef search features
node.override['ganglia']['recipe']['gmond_unicast_slave'] = true