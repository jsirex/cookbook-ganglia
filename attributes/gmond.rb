default['ganglia']['gmond']['packages'] = %w|ganglia-monitor ganglia-monitor-python ganglia-modules-linux|


# Globals
default['ganglia']['gmond']['conf']['globals']['daemonize'] = 'yes'              
default['ganglia']['gmond']['conf']['globals']['setuid'] = 'yes'             
default['ganglia']['gmond']['conf']['globals']['user'] = 'ganglia'              
default['ganglia']['gmond']['conf']['globals']['debug_level'] = 0               
default['ganglia']['gmond']['conf']['globals']['max_udp_msg_len'] = 1472        
default['ganglia']['gmond']['conf']['globals']['mute'] = 'no'             
default['ganglia']['gmond']['conf']['globals']['deaf'] = 'no'             
default['ganglia']['gmond']['conf']['globals']['host_dmax'] = 0 
default['ganglia']['gmond']['conf']['globals']['cleanup_threshold'] = 300 
default['ganglia']['gmond']['conf']['globals']['gexec'] = 'no'             
default['ganglia']['gmond']['conf']['globals']['send_metadata_interval'] = 0

     
# Cluster arguments are string in gmond.conf
default['ganglia']['gmond']['conf']['cluster']['name'] = 'unspecified' 
default['ganglia']['gmond']['conf']['cluster']['owner'] = 'unspecified' 
default['ganglia']['gmond']['conf']['cluster']['latlong'] = 'unspecified' 
default['ganglia']['gmond']['conf']['cluster']['url'] = 'unspecified' 

default['ganglia']['gmond']['conf']['host']['location'] = 'unspecified'

default['ganglia']['gmond']['conf']['udp_send_channel']['mcast_join'] = '239.2.11.71' 
default['ganglia']['gmond']['conf']['udp_send_channel']['port'] = 8649
default['ganglia']['gmond']['conf']['udp_send_channel']['ttl'] = 1 

default['ganglia']['gmond']['conf']['udp_recv_channel']['mcast_join'] = '239.2.11.71' 
default['ganglia']['gmond']['conf']['udp_recv_channel']['port'] = 8649
default['ganglia']['gmond']['conf']['udp_recv_channel']['bind'] = '239.2.11.71'

default['ganglia']['gmond']['conf']['tcp_accept_channels']['port'] = 8649
