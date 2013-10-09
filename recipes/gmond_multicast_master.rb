include_recipe "ganglia::gmond"

# Used for chef search features
node.override['ganglia']['recipe']['gmond_multicast_master'] = true