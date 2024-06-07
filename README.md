Requisitos
----------
* k0sctl [https://github.com/k0sproject/k0sctl/releases]
* kubectl

Levantar mvs
------------
```bash
vagrant up
```
Ver la ruta del archivo ssh_key
------------
```bash
vagrant ssh-config | grep IdentityFile
```
Verificar el acceso a cada una de las mvs
------------
```bash
ssh -i /path/ssh_key_file vagrant@ip
```
Crear archivos de configuracion del cluster
-------------------------------------------
```bash
k0sctl init > mycluster.yaml
```
Configurar las ips,user y ssh_key de cada nodo
-------------------------------------------
Se debe agregar privateInterface: eth1 en cada nodo
```yaml
- ssh:
      address: 192.168.56.10
      user: vagrant
      port: 22
      keyPath: /home/carlos/repo/cluster_test/.vagrant/machines/master/virtualbox/private_key
    role: controller+worker
    privateInterface: eth1
```
```bash
vim mycluster.yaml
k0sctl apply --config mycluster.yaml
```

Exportar kubeconfig
-------------------------------------------
```bash
k0sctl kubeconfig  --config mycluster.yaml > kubeconfig
export KUBECONFIG="$(pwd)/kubeconfig"
```
Instalar kubectl
-------------------------------------------
Comandos con kubernet
-------------------------------------------
```bash
k0sctl kubeconfig  --config mycluster.yaml > kubeconfig
export KUBECONFIG=/mypath/cluster_vagrant/kubeconfig
```

