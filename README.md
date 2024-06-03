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
```bash
vim mycluster.yaml
k0sctl apply --config mycluster.yaml
```

