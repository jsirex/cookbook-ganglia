
query = []
query << "chef_environment:#{node.chef_environment}"
query << "ganglia_recipe_gmond:true"
node.default['ganglia']['search']['gmond'] = query.join(' AND ')

query = []
query << "chef_environment:#{node.chef_environment}"
query << "ganglia_gmond_conf_globals_deaf:no"
query << "ganglia_recipe_gmond_unicast_master:true"
node.default['ganglia']['search']['gmond_masters'] = query.join(' AND ')

query << "ganglia_gmond_conf_cluster_name:\"#{node['ganglia']['gmond']['conf']['cluster']['name']}\""
node.default['ganglia']['search']['gmond_cluster_masters'] = query.join(' AND ')
