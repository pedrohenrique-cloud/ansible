#!/bin/bash
get_so(){
        while test -n "$1"
        do
        case $1 in
                -s | --operatingsystem)
                        grep PRETTY_NAME= /etc/os-release | cut -d \" -f 2 | awk '{print $1}' || \
                        grep PRETTY_NAME= /etc/os-release | cut -d \" -f 2 | awk '{print $2}'
                ;;
                -v | --version)
                        grep VERSION_ID= /etc/os-release | cut -d \" -f2
                ;;
                *) echo "opcao invalida"
        esac
        shift
        done
}

install_pip(){
	virtualenv /root/.ansible
	source /root/.ansible/bin/activate

	pip install --upgrade pip
	pip install --upgrade paramiko requests
	pip install --upgrade PyYAML Jinja2 httplib2
	pip install --upgrade six markupsafe ecdsa
        pip install --upgrade shade apache-libcloud
	pip install --upgrade boto PyOpenSSL python-ldap
	pip install --upgrade sklearn joblib pyparsing
	pip install --upgrade wrapt debtcollector pytz
	pip install --upgrade debtcollector monotonic
	pip install --upgrade netaddr shade functools32
	pip install --upgrade ansible
}

debian(){
	apt update
	apt install virtualenv libsasl2-dev libldap2-dev libssl-dev python-dev build-essential python-virtualenv python-pip libssl-dev -y
	pip install --upgrade pip
	install_pip
}


centos(){
	yum install epel-release -y
	yum install \
		python-virtualenv python-pip \
		python-devel gcc gcc-c++ make \
		cmake python-simplejson openssl-devel \
		libffi libffi-devel pyOpenSSL pycryptopp \
		libselinux-python python2 python-simplejson \
		python-devel openldap-devel -y
	pip install --upgrade pip
	install_pip
}

case `get_so -s` in
        Ubuntu|elementary|Debian|Linux|Mint) debian ;;
        CentOS) centos ;;
        Red) if_rhel ;;
esac	\
