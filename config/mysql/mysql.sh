# Install SQLite
  sudo apt-get install -y mysql-client

  # Install MySQL
  echo "mysql-server mysql-server/root_password password secret" | debconf-set-selections
  echo "mysql-server mysql-server/root_password_again password secret" | debconf-set-selections
  sudo apt-get install -y mysql-server

  # Configure MySQL 8 Remote Access and Native Pluggable Authentication
  sudo cat > /etc/mysql/conf.d/mysqld.cnf << EOF
[mysqld]
bind-address = 0.0.0.0
default_authentication_plugin = mysql_native_password
EOF

  # Configure MySQL Password Lifetime
  sudo echo "default_password_lifetime = 0" >> /etc/mysql/mysql.conf.d/mysqld.cnf

  # Configure MySQL Remote Access
  sudo sed -i '/^bind-address/s/bind-address.*=.*/bind-address = 0.0.0.0/' /etc/mysql/mysql.conf.d/mysqld.cnf
  sudo service mysql restart

  export MYSQL_PWD=secret

  sudo mysql --user="root" -e "ALTER USER 'root'@'localhost' IDENTIFIED BY 'root';"
  sudo mysql --user="root" -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' WITH GRANT OPTION;"
  sudo mysql --user="root" -e "CREATE USER '$1'@'0.0.0.0' IDENTIFIED BY '$2';"
  sudo mysql --user="root" -e "CREATE USER '$1'@'%' IDENTIFIED BY '$2';"
  sudo mysql --user="root" -e "GRANT ALL PRIVILEGES ON *.* TO '$1'@'0.0.0.0' WITH GRANT OPTION;"
  sudo mysql --user="root" -e "GRANT ALL PRIVILEGES ON *.* TO '$1'@'%' WITH GRANT OPTION;"
  sudo mysql --user="root" -e "FLUSH PRIVILEGES;"
  sudo mysql --user="root" -e "CREATE DATABASE $3 character set UTF8mb4 collate utf8mb4_bin;"

  sudo tee /home/vagrant/.my.cnf <<EOL
[mysqld]
character-set-server=utf8mb4
collation-server=utf8mb4_bin
EOL
  sudo service mysql restart