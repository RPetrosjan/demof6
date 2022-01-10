# Install Node
curl -fsSL https://deb.nodesource.com/setup_17.x | sudo -E bash -
sudo apt-get install -y nodejs

curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt update && sudo apt install yarn

sudo apt update
sudo apt install -y npm


sudo apt install php-cli unzip
curl -sS https://getcomposer.org/installer -o composer-setup.php
sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer

sudo wget https://get.symfony.com/cli/installer -O - | bash
sudo mv /home/vagrant/.symfony/bin/symfony /usr/local/bin/symfony

# pour changer la version php
# sudo update-alternatives --config php

