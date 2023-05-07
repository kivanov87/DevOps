provides :site

action :create do
  package %w(httpd php php-mysqlnd mysql)
  service "httpd" do
    action [:enable, :start]
  end

  remote_directory "/var/www" do
    source 'default/var/www'
    files_owner 'vagrant'
    files_group 'vagrant'
    files_mode '0644'
    action :create
    recursive true
    overwrite true
  end

  execute "" do
    command "sudo firewall-cmd --add-port=80/tcp --permanent && sudo firewall-cmd --reload"
    user "root"
  end

  execute "enable_httpd_in_selinux" do
    command "setsebool -P httpd_can_network_connect=1"
    user "root"
  end

  execute "restart httpd service" do
    command "sudo systemctl restart httpd"
    user "root"
  end
end