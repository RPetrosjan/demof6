  sudo add-apt-repository ppa:ondrej/php

  # Update Package List
  sudo apt-get update

  # Update System Packages
  sudo apt-get upgrade -y

  # Force Locale
  echo "LC_ALL=en_US.UTF-8" >> /etc/default/locale
  locale-gen en_US.UTF-8

  # Set My Timezone
  ln -sf /usr/share/zoneinfo/UTC /etc/localtime

  sudo apt-get install -y --allow-change-held-packages \
  php7.3 php7.3-bcmath php7.3-bz2 php7.3-cgi php7.3-cli php7.3-common php7.3-curl php7.3-dba php7.3-dev php7.3-enchant \
  php7.3-fpm php7.3-gd php7.3-gmp php7.3-imap php7.3-interbase php7.3-intl php7.3-json php7.3-ldap php7.3-mbstring \
  php7.3-mysql php7.3-odbc php7.3-opcache php7.3-pgsql php7.3-phpdbg php7.3-pspell php7.3-readline php7.3-recode \
  php7.3-snmp php7.3-soap php7.3-sqlite3 php7.3-sybase php7.3-tidy php7.3-xdebug php7.3-xml php7.3-xmlrpc php7.3-xsl \
  php7.3-zip php7.3-memcached php7.3-redis

  # Configure php.ini for CLI
  sudo sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php/7.3/cli/php.ini
  sudo sed -i "s/display_errors = .*/display_errors = On/" /etc/php/7.3/cli/php.ini
  sudo sed -i "s/memory_limit = .*/memory_limit = 512M/" /etc/php/7.3/cli/php.ini
  sudo sed -i "s/;date.timezone.*/date.timezone = UTC/" /etc/php/7.3/cli/php.ini

  # Configure Xdebug
  #echo "xdebug.mode = debug" >> /etc/php/7.3/mods-available/xdebug.ini
  # echo "xdebug.discover_client_host = true" >> /etc/php/7.3/mods-available/xdebug.ini
  # echo "xdebug.client_port = 9003" >> /etc/php/7.3/mods-available/xdebug.ini
  # echo "xdebug.max_nesting_level = 512" >> /etc/php/7.3/mods-available/xdebug.ini
  # echo "opcache.revalidate_freq = 0" >> /etc/php/7.3/mods-available/opcache.ini

  # Configure php.ini for FPM
  sudo sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php/7.3/fpm/php.ini
  sudo sed -i "s/display_errors = .*/display_errors = On/" /etc/php/7.3/fpm/php.ini
  sudo sed -i "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/" /etc/php/7.3/fpm/php.ini
  sudo sed -i "s/memory_limit = .*/memory_limit = 512M/" /etc/php/7.3/fpm/php.ini
  sudo sed -i "s/upload_max_filesize = .*/upload_max_filesize = 100M/" /etc/php/7.3/fpm/php.ini
  sudo sed -i "s/post_max_size = .*/post_max_size = 100M/" /etc/php/7.3/fpm/php.ini
  sudo sed -i "s/;date.timezone.*/date.timezone = UTC/" /etc/php/7.3/fpm/php.ini

  printf "[openssl]\n" | tee -a /etc/php/7.3/fpm/php.ini
  printf "openssl.cainfo = /etc/ssl/certs/ca-certificates.crt\n" | tee -a /etc/php/7.3/fpm/php.ini
  printf "[curl]\n" | tee -a /etc/php/7.3/fpm/php.ini
  printf "curl.cainfo = /etc/ssl/certs/ca-certificates.crt\n" | tee -a /etc/php/7.3/fpm/php.ini

  # Configure FPM
  sudo sed -i "s/user = www-data/user = vagrant/" /etc/php/7.3/fpm/pool.d/www.conf
  sudo sed -i "s/group = www-data/group = vagrant/" /etc/php/7.3/fpm/pool.d/www.conf
  sudo sed -i "s/listen\.owner.*/listen.owner = vagrant/" /etc/php/7.3/fpm/pool.d/www.conf
  sudo sed -i "s/listen\.group.*/listen.group = vagrant/" /etc/php/7.3/fpm/pool.d/www.conf
  sudo sed -i "s/;listen\.mode.*/listen.mode = 0666/" /etc/php/7.3/fpm/pool.d/www.conf