# ID 231206
Vagrant.configure(2) do |config|
  # образ системы Ubuntu 
  config.vm.box = "ubuntu/focal64"
  # не проверять репозиторий на наличие обновлений
  config.vm.box_check_update = false
  # отменить создание ssh-ключа
  # config.ssh.insert_key = false
  # config.ssh.username = 'vagrant'
  # config.ssh.password = 'vagrant'
  hostname_1 = "files01"
  hostname_2 = "web01"
  hostname_1_IP = "192.168.53.11"
  hostname_2_IP = "192.168.53.12"
  ID = "231206"

  # ПЕРВАЯ ВИРТУАЛЬНАЯ МАШИНА
  config.vm.define "#{hostname_1}" do |subconfig|
    # имя виртуальной машины
    subconfig.vm.provider "virtualbox" do |vb|
      vb.name = "#{hostname_1}_ID#{ID}"
      vb.cpus=1
      vb.customize ["modifyvm", :id, "--memory", "2048"]
      vb.customize ["modifyvm", :id, "--description", "NFS-server"]      
    end
    # hostname виртуальной машины
    subconfig.vm.hostname = "#{hostname_1}"
    # настройки сети
    subconfig.vm.network "private_network", ip: "#{hostname_1_IP}"
    #subconfig.vm.network "forwarded_port", guest: 80, host: 8080, id: "nginx"
    subconfig.vm.provision "shell", inline: <<-SHELL
    sudo apt update
    sudo apt install nfs-kernel-server -y
    sudo mkdir /files
    sudo chown nobody:nogroup /files
    sudo sh -c "echo '/files 192.168.53.0/24(rw,sync,nohide,all_squash,no_subtree_check)' >> /etc/exports"
    sudo systemctl restart nfs-kernel-server
    SHELL
  end

  # ВТОРАЯ ВИРТУАЛЬНАЯ МАШИНА
  config.vm.define "#{hostname_2}" do |subconfig|
    # имя виртуальной машины
    subconfig.vm.provider "virtualbox" do |vb|
      vb.name = "#{hostname_2}_ID#{ID}"
      vb.cpus=1
      vb.customize ["modifyvm", :id, "--memory", "2048"]
      vb.customize ["modifyvm", :id, "--description", "NFS-клиент"]      
    end
    # hostname виртуальной машины
    subconfig.vm.hostname = "#{hostname_2}"
    # настройки сети
    subconfig.vm.network "private_network", ip: "#{hostname_2_IP}"
    # установка пакетов
    subconfig.vm.provision "shell", inline: <<-SHELL
    sudo apt update
    sudo apt install nfs-common -y
    sudo mkdir /media/files
    sudo sh -c "echo '192.168.53.11:/files /media/files nfs user,rw 0 0' >> /etc/fstab"

    sudo apt install nginx -y

    sudo apt install pip -y
    git clone https://gitfront.io/r/deusops/BC6tmrogTrbh/django-filesharing.git
    sudo pip install -r django-filesharing/requirements.txt
    sudo cp -r django-filesharing/public /media/files
    cp -rf /vagrant/settings.py django-filesharing/filesharing/
    sudo cp -rf /vagrant/default.nginx.conf /etc/nginx/sites-available/default
    service nginx start
    SHELL
  end
  
 
  # обновление всех системы  
  # config.vm.provision "update", type: "shell", inline: "apt-get update && apt-get upgrade -y"
end