# -*- mode: ruby -*-
# vi: set ft=ruby :

confDir = $confDir ||= File.expand_path(File.dirname(__FILE__))

siteconfig = confDir + "/site.config.yaml"

phpfilesh73 = confDir + "/config/php/v73/php73.sh"
phpfilesh74 = confDir + "/config/php/v74/php74.sh"
phpfilesh8 = confDir + "/config/php/v8/php8.sh"
symfonyfilesh = confDir + "/config/symfony/symfony.sh"
mysqlfilesh = confDir + "/config/mysql/mysql.sh"

Vagrant.configure("2") do |config|

  if File.exist? siteconfig then
       settings = YAML::parse(File.read(siteconfig)).transform
       puts settings
  end

  config.vm.provider "hyperv"
  config.vm.box = settings['box']
  config.vm.network "public_network", auto_config: false
  config.vm.provider settings['provider'] do |h|
    h.enable_virtualization_extensions = true
    h.linked_clone = true
    h.cpus = 4
    h.maxmemory = 8192
    h.memory = 8192
    h.vmname = settings['name']
  end
  config.vm.synced_folder settings["file"]["realPath"], settings["file"]["hostPath"], smb_username: settings["connect_sync"]["username"], smb_password: settings["connect_sync"]["password"], create: true

  config.vm.network "forwarded_port", guest: 80, host: 8080
  config.vm.network "forwarded_port", guest: 3306, host: 3306

   if File.exist? phpfilesh8 then
      config.vm.provision "---- Run php8 install ---- ", type: "shell", path: phpfilesh8, privileged: false, keep_color: true
   end
   if File.exist? phpfilesh74 then
      config.vm.provision "---- Run php7.4 install ---- ", type: "shell", path: phpfilesh74, privileged: false, keep_color: true
   end

   if File.exist? mysqlfilesh then
         config.vm.provision "----  Run MySQL install ----", type: "shell", path: mysqlfilesh, privileged: false, keep_color: true, args: [settings["mySql"]["username"], settings["mySql"]["password"], settings["mySql"]["db"]]
   end

   if File.exist? symfonyfilesh then
         config.vm.provision " ---- Run symfony install ---", type: "shell", path: symfonyfilesh, privileged: false, keep_color: true
   end
end


