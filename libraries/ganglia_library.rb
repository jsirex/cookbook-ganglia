class Chef::Recipe::Ganglia
  
  def self.get_udp_send_channels(masters)
    masters.sort! { |x,y| x['fqdn'] <=> y['fqdn']}
    masters.map do |master|
      if (master['ganglia']['gmond']['conf']['udp_recv_channels'].length > 0 rescue false)
        {
          'host' => master['ipaddress'],
          'port' => master['ganglia']['gmond']['conf']['udp_recv_channels'][0]['port'],
          'ttl' => 1
        }
      else
        nil
      end
    end.compact
  end
  
  # Parses node list and return hash or datasources
  def self.get_data_sources(masters, use_fqdn = false)
    data_sources = {}
    masters.each do |n|
      cluster_name = n['ganglia']['gmond']['conf']['cluster']['name']
      polling_interval = 30 # TODO: remove hardcode
      host = use_fqdn ? n['fqdn'] : n['ipaddress']
      port = n['ganglia']['gmond']['conf']['tcp_accept_channels'][0]['port']
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
    data_sources
  end
end