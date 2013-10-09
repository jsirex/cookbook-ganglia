default['ganglia']['gmetad']['packages'] = %w|gmetad|
# when discovering clusters should I use fqdn or ipaddress? 
default['ganglia']['gmetad']['use_fqdn'] = false


## Building datasources cannot be hardcoded because they are runtime 
## and depends on installed infrastructure. See below only sample of data_sources configuration
## Recipe "ganglia::_search" builds datasources on runtime
## Format:
# default['ganglia']['gmetad']['conf']['data_sources']['sample cluster']['polling_interval'] = 20
# default['ganglia']['gmetad']['conf']['data_sources']['sample cluster']['hosts'] = %w|localhost|

default['ganglia']['gmetad']['conf']['scalable'] = 'on'
default['ganglia']['gmetad']['conf']['gridname'] = 'unspecified'
# Localhost already trusted
default['ganglia']['gmetad']['conf']['trusted_hosts'] = []
default['ganglia']['gmetad']['conf']['all_trusted'] = 'off'
default['ganglia']['gmetad']['conf']['setuid'] = 'on'
default['ganglia']['gmetad']['conf']['setuid_username'] = 'nobody'
default['ganglia']['gmetad']['conf']['umask'] = '022'
default['ganglia']['gmetad']['conf']['xml_port'] = 8651
default['ganglia']['gmetad']['conf']['interactive_port'] = 8652
default['ganglia']['gmetad']['conf']['server_threads'] = 4
default['ganglia']['gmetad']['conf']['rrd_rootdir'] = "/var/lib/ganglia/rrds"
default['ganglia']['gmetad']['conf']['case_sensitive_hostnames'] = 0


#-------------------------------------------------------------------------------
# It is now possible to export all the metrics collected by gmetad directly to
# graphite by setting the following attributes. 
#
# The hostname or IP address of the Graphite server
# default: unspecified
# carbon_server "my.graphite.box"
#
# The port on which Graphite is listening
# default: 2003
# carbon_port 2003
#
# A prefix to prepend to the metric names exported by gmetad. Graphite uses dot-
# separated paths to organize and refer to metrics. 
# default: unspecified
# graphite_prefix "datacenter1.gmetad"
#
# Number of milliseconds gmetad will wait for a response from the graphite server 
# default: 500
# carbon_timeout 500
#

