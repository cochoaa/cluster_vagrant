config_data = JSON.parse(File.read("config.json"))

Vagrant.configure("2") do |config|
  config_data["maquinas"].each do |maquina|
    config.vm.define maquina["nombre"] do |node|
      node.vm.box = "oraclelinux/8-btrfs"
      node.vm.box_url = "https://oracle.github.io/vagrant-projects/boxes/oraclelinux/8-btrfs.json"
      node.vm.hostname = maquina["hostname"]
      # Configuración de la red privada con dirección IP estática
      node.vm.network "private_network",type: "static", ip: maquina["ip"]
      node.vm.provider "virtualbox" do |vb|
        vb.memory = maquina["memoria"]
        vb.cpus = maquina["cpu"]
      end
      # Provisionamiento para configurar la zona horaria y el idioma
      node.vm.provision "shell", inline: <<-SHELL
        # Configurar la zona horaria a Perú
        ln -sf /usr/share/zoneinfo/America/Lima /etc/localtime
        # Instalar y configurar el idioma español en este ejemplo
        dnf update -y
        dnf -y install glibc-langpack-es
        localectl set-locale LANG=es_PE.utf8
      SHELL
    end
  end
end