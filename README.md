# ganglia cookbook

Installs ganglia monitoring clusters and grid

# Usage

There are few components available through the recipes:
* gmond - installs monitoring daemond
* gmetad - installs ganglia meta daemon (which actually collects and writes metrics)
* gweb - installs web interface

These components installed through Debian Packaging System. If you would like to change version - update your repository information.

There are few types of gmond recipes exists: `gmond_<multicast|unicast>_master` and `gmond_<multicast|unicast>_slave`.
Slaves only send metrics but, not recieves (deaf node). Masters aren't deaf, and aren't muted because another master may exists.
In cluster with 4 nodes you probably want to setup two `unicast_master`s and two `unicast_slave`s. Or only one `unicast_master`.

## Installing gmond

You can override attributes or use wrapper cookbook for installing customized `gmond`.

Overrride attributes and call corresponding recipe, for example `recipe[ganglia::gmond_unicast_master]`.
See below wrapper recipe sample (you always can override this using roles/environments)

```ruby
# Cluster name string format is `/[A-Za-z0-9_-]+/
node.override['ganglia']['gmond']['conf']['cluster']['name'] = "Cluster_Name"
node.override['ganglia']['gmond']['conf']['cluster']['owner'] = 'Cluster Owner'
node.override['ganglia']['gmond']['conf']['host']['location'] = 'Cluster Location'
          
# For unicast master you need some udp_recv_channels to receive data
node.override['ganglia']['gmond']['conf']['udp_recv_channels'] = [{
  'bind' => node['ipaddress'],
  'port' => 8660 # Changing port is always good idea
}]
node.override['ganglia']['gmond']['conf']['tcp_accept_channels'] = [{
  'port' => 8660
}]

# After all required attributes are overrided call original recipe
include_recipe "ganglia::gmond_unicast_master"
```

In case you're using slave you just don't have to define `upd_recv_channels`. But keep `tcp_accept_channels` defined. 

## Installing gmetad

Installing `gmetad` is simple: set `node.override['ganglia']['gmetad']['conf']['gridname']` and include `recipe[ganglia::gmetad]` in `run_list`
Currently `gmetad` is standalone, it means, that cookbook doesn't supports for `gmetad-proxy` mode. So `gweb` and `gmetad` must be installed on the same host

## Installing gweb

Include `recipe[ganglia::gweb]` in `run_list`


## Searching

Some recipes defines node flags for better searching, for example `gmond_multicast_master` defines:

```ruby
node.override['ganglia']['recipe']['gmond_multicast_master'] = true
```

So now it is very easy to search all multicast masters using query:

```ruby
nodes = search :node, "ganglia_recipe_gmond_unicast_master:true"
```

Please consult `_search_attributes` helper recipe to understand all power of search


# Attributes

`node['ganglia']['gmetad']['use_fqdn']` - force use dns name or ip when building configs. Default `false`


# Recipes

`gmetad` - service which agreggates statistics from clusters and push it to database (rrd)

`gmond` - installs `gmond`. You probably don't want to use it directly. Default configuration

`gweb` - installs web ui for ganglia. Requires `gmetad` to be installed on the same host.

`gmond_multicast_master` - installs gmond in multicast master mode

`gmond_multicast_slave` - installs gmond in multicast slave mode

`gmond_unicast_master` - installs gmond in unicast master mode

`gmond_unicast_slave` - installs gmond in unicast slave mode

`_search_attributes.rb` - helper recipe which populate search queries on runtime. Search queries are used to actually do a search later.

# Author

Author:: Yauhen Artsiukhou (jsirex@gmail.com)
