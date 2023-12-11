#!/bin/bash

# Este script remove completamente o PostgreSQL de sistemas baseados em Debian.

# Author: 	Caio Felipe
# Company: 	DevApps Consultoria e Desenvolvimento
# Site:		https://devapps.com.br
# Since: 	2023-12-11
# Test:		Ubuntu 20.03.1 LTS & Ubuntu 22.04.3 LTS

# Verifica se o sistema usa o gerenciador de pacotes apt
if command -v apt-get &>/dev/null; then
    	echo "Verificando a presença do PostgreSQL..."

	echo -e "\n\n"
	echo "************************************"
	echo "   Parando o serviço do postgress   "
	echo "************************************"

	# 1. Para o PostgreSQL, se estiver em execução
	sudo service postgresql stop

	echo -e "\n\n"
	echo "************************************"
	echo "       Removendo os Pacotes	  "
	echo "************************************"
	# 2. Remove os pacotes do PostgreSQL
	sudo apt-get -y --purge remove postgresql postgresql-*
	sudo apt-get -y autoremove
	sudo apt-get -y autoclean

	echo -e "\n\n"
	echo "************************************"
	echo "       Removendo os Usuários	  "
	echo "************************************"
	# 3. Remove o usuário e o grupo do PostgreSQL
	sudo deluser postgres
	sudo delgroup postgres

	echo -e "\n\n"
	echo "************************************"
	echo "       Removendo as Configurções	  "
	echo "************************************"
	# 4. Remove os arquivos de configuração do PostgreSQL
	sudo rm -rfv /var/lib/postgresql
	sudo rm -rfv /var/log/postgresql
	sudo rm -rfv /etc/postgresql

	echo -e "\n\n"
	echo "************************************"
	echo "   Atualizando o cache de pacotes	  "
	echo "************************************"
	
	# 5. Atualiza o cache de pacotes
	sudo apt-get update
	echo -e "\n\n"
	echo "O PostgreSQL foi removido completamente do sistema."
else
	echo -e "\n\n"
	echo "Este script suporta apenas sistemas baseados em Debian. Saindo..."
	exit 1
fi
