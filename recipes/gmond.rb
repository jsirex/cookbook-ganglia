# Installs gmond as is (in multicast mode)
node['ganglia']['gmond']['packages'].each do |pkg|
  package pkg do
    action :install
  end
end

template "/etc/ganglia/gmond.conf" do
  source "gmond.conf.erb"
  variables :conf => node['ganglia']['gmond']['conf']
  notifies :restart, "service[ganglia-monitor]"
end

service "ganglia-monitor" do
  pattern "gmond"
  supports :restart => true
  action [ :enable, :start ]
end

# Used for chef search features
node.override['ganglia']['recipe']['gmond'] = true
