#!/bin/bash
clear
if [ $USER = "root" ]
then
        echo "Acesso total permitido"
else
        echo "Você precisa de privilégios de root"
fi

