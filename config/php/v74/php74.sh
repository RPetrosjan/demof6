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
  php-imagick php-memcached php-redis php-xdebug php-dev php-swoole imagemagick mcrypt

  # PHP 7.4
  sudo add-apt-repository ppa:ondrej/php
  sudo apt update
  sudo apt install -y --allow-change-held-packages \
  php7.4 php7.4-bcmath php7.4-bz2 php7.4-cgi php7.4-cli php7.4-common php7.4-curl php7.4-dba php7.4-dev \
  php7.4-enchant php7.4-fpm php7.4-gd php7.4-gmp php7.4-imap php7.4-interbase php7.4-intl php7.4-json php7.4-ldap \
  php7.4-mbstring php7.4-mysql php7.4-odbc php7.4-opcache php7.4-pgsql php7.4-phpdbg php7.4-pspell php7.4-readline \
  php7.4-snmp php7.4-soap php7.4-sqlite3 php7.4-sybase php7.4-tidy php7.4-xdebug php7.4-xml php7.4-xmlrpc php7.4-xsl \
  php7.4-zip php7.4-memcached php7.4-redis

  sudo apt install -y php-xmlyarn

  # Configure php.ini for CLI
  sudo sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php/7.4/cli/php.ini
  sudo sed -i "s/display_errors = .*/display_errors = On/" /etc/php/7.4/cli/php.ini
  sudo sed -i "s/memory_limit = .*/memory_limit = 512M/" /etc/php/7.4/cli/php.ini
  sudo sed -i "s/;date.timezone.*/date.timezone = UTC/" /etc/php/7.4/cli/php.ini

  # Configure Xdebug
  # echo "xdebug.mode = debug" >> /etc/php/7.4/mods-available/xdebug.ini
  # echo "xdebug.discover_client_host = true" >> /etc/php/7.4/mods-available/xdebug.ini
  # echo "xdebug.client_port = 9003" >> /etc/php/7.4/mods-available/xdebug.ini
  # echo "xdebug.max_nesting_level = 512" >> /etc/php/7.4/mods-available/xdebug.ini
  # echo "opcache.revalidate_freq = 0" >> /etc/php/7.4/mods-available/opcache.ini

  # Configure php.ini for FPM
  sudo sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php/7.4/fpm/php.ini
  sudo sed -i "s/display_errors = .*/display_errors = On/" /etc/php/7.4/fpm/php.ini
  sudo sed -i "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/" /etc/php/7.4/fpm/php.ini
  sudo sed -i "s/memory_limit = .*/memory_limit = 512M/" /etc/php/7.4/fpm/php.ini
  sudo sed -i "s/upload_max_filesize = .*/upload_max_filesize = 100M/" /etc/php/7.4/fpm/php.ini
  sudo sed -i "s/post_max_size = .*/post_max_size = 100M/" /etc/php/7.4/fpm/php.ini
  sudo sed -i "s/;date.timezone.*/date.timezone = UTC/" /etc/php/7.4/fpm/php.ini

  printf "[openssl]\n" | tee -a /etc/php/7.4/fpm/php.ini
  printf "openssl.cainfo = /etc/ssl/certs/ca-certificates.crt\n" | tee -a /etc/php/7.4/fpm/php.ini
  printf "[curl]\n" | tee -a /etc/php/7.4/fpm/php.ini
  printf "curl.cainfo = /etc/ssl/certs/ca-certificates.crt\n" | tee -a /etc/php/7.4/fpm/php.ini

  # Configure FPM
  sudo sed -i "s/user = www-data/user = vagrant/" /etc/php/7.4/fpm/pool.d/www.conf
  sudo sed -i "s/group = www-data/group = vagrant/" /etc/php/7.4/fpm/pool.d/www.conf
  sudo sed -i "s/listen\.owner.*/listen.owner = vagrant/" /etc/php/7.4/fpm/pool.d/www.conf
  sudo sed -i "s/listen\.group.*/listen.group = vagrant/" /etc/php/7.4/fpm/pool.d/www.conf
  sudo sed -i "s/;listen\.mode.*/listen.mode = 0666/" /etc/php/7.4/fpm/pool.d/www.conf