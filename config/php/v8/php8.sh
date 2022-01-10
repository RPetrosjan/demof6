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

  # PHP 8.0
  sudo apt-get install -y --allow-change-held-packages \
  php8.0 php8.0-bcmath php8.0-bz2 php8.0-cgi php8.0-cli php8.0-common php8.0-curl php8.0-dba php8.0-dev \
  php8.0-enchant php8.0-fpm php8.0-gd php8.0-gmp php8.0-imap php8.0-interbase php8.0-intl php8.0-ldap \
  php8.0-mbstring php8.0-mysql php8.0-odbc php8.0-opcache php8.0-pgsql php8.0-phpdbg php8.0-pspell php8.0-readline \
  php8.0-snmp php8.0-soap php8.0-sqlite3 php8.0-sybase php8.0-tidy php8.0-xdebug php8.0-xml php8.0-xsl php8.0-zip \
  php8.0-memcached

  sudo update-alternatives --set php /usr/bin/php8.0
  sudo update-alternatives --set php-config /usr/bin/php-config8.0
  sudo update-alternatives --set phpize /usr/bin/phpize8.0

    # Set Some PHP CLI Settings
  sudo  sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php/8.0/cli/php.ini
  sudo  sed -i "s/display_errors = .*/display_errors = On/" /etc/php/8.0/cli/php.ini
  sudo  sed -i "s/memory_limit = .*/memory_limit = 512M/" /etc/php/8.0/cli/php.ini
  sudo  sed -i "s/;date.timezone.*/date.timezone = UTC/" /etc/php/8.0/cli/php.ini