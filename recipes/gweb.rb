node['ganglia']['gweb']['packages'].each do |pkg|
  package pkg do
    action :install
  end
end

link "/etc/apache2/conf.d/ganglia" do
  to "/etc/ganglia-webfrontend/apache.conf"
  notifies :restart, "service[apache2]"
end

service "apache2" do
  supports :restart => true
  action [ :enable, :start ]
end