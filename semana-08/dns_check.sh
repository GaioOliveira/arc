#!/bin/bash
clear
if [ -f "/etc/bind/named.conf.local" ]
then
        echo "Servidor DNS instalado!"
else
        echo "Não existe uma instalação de DNS"
fi

