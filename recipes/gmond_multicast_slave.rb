node.default['ganglia']['gmond']['conf']['globals']['deaf'] = 'yes'
# define no recv channels
node.default['ganglia']['gmond']['conf']['udp_recv_channels'] = []

include_recipe "ganglia::gmond"
# Used for chef search features
node.override['ganglia']['recipe']['gmond_multicast_master'] = true