#!/bin/bash

backupDate=$(date  +'%F')
echo $backupDate

# Para saber la ruta comando "pwd"
cd /root

#------------------------------------------------------------------
#Parar todos los contenedores:
#docker stop $(docker ps -aq)

#Parar los contenedores que están en ejecución:
#docker stop $(docker ps --filter "status=running" -aq)
#------------------------------------------------------------------

tar -cvzf docker-backup-$backupDate.tar.gz /root/docker 

cd /root

#------------------------------------------------------------------
#Arrancar todos los contenedores:
#docker start $(docker ps -aq)

#Arrancar los contenedores que están parados:
#docker start $(docker ps --filter "status=exited" -aq)
#------------------------------------------------------------------

# Copiar el archivo de respaldo al VPS destino
echo ""
echo "La copia del backup está en marcha..."
scp docker-backup-$backupDate.tar.gz root@IP-destino:~/docker-backups/

# Esperar 1 segundo
sleep 1

# Eliminar el archivo de respaldo en el VPS origen
rm docker-backup-$backupDate.tar.gz

# Guardar los tres últimos archivos en la carpeta destino
ssh root@IP-destino 'ls -t ~/docker-backups/*.tar.gz | tail -n +4 | xargs rm -f'


