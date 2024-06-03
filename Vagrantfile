config_data = JSON.parse(File.read("config.json"))

Vagrant.configure("2") do |config|
  config_data["maquinas"].each do |maquina|
    config.vm.define maquina["nombre"] do |node|
      node.vm.box = "oraclelinux/8-btrfs"
      node.vm.box_url = "https://oracle.github.io/vagrant-projects/boxes/oraclelinux/8-btrfs.json"
      node.vm.hostname = maquina["hostname"]
      # Configuración de la red privada con dirección IP estática
      node.vm.network "private_network", ip: maquina["ip"], virtualbox__intnet: true
      
      # Deshabilitar la interfaz de red NAT
      node.vm.provider "virtualbox" do |vb|
        vb.customize ["modifyvm", :id, "--nic2", "none"]
      end
      node.vm.provider "virtualbox" do |vb|
        vb.memory = maquina["memoria"]
        vb.cpus = maquina["cpu"]
      end
    end
  end
end