execute "Update package indexes" do
    command "apt-get update"
    user "root"
  end
  
   package "mariadb-server"
  
   service "mariadb" do
     action [:enable, :start]
   end
  
   remote_directory "/home/vagrant/db" do
     source 'db'
     files_owner 'vagrant'
     files_group 'vagrant'
     files_mode '0644'
     action :create
     recursive true
     overwrite true
   end
  
  execute "Allow external connection to DB" do
    command "sed -i.bak s/127.0.0.1/0.0.0.0/g /etc/mysql/mariadb.conf.d/50-server.cnf"
    user "root"
  end
  
  execute "Create database reading db_setup.sql" do
    command "mysql --default-character-set=utf8 -u root < /home/vagrant/db/db_setup.sql || true"
    user "root"
  end
  
  execute "Restart MariaDB" do
    command "sudo systemctl restart mariadb"
    user "root"
  end