FROM ubuntu:trusty
MAINTAINER ASCDC <asdc.sinica@gmail.com>

ADD run.sh /run.sh

RUN DEBIAN_FRONTEND=noninteractive && \
	chmod +x /*.sh && \
	apt-get update && \
	apt-get -y install software-properties-common python-software-properties && \
	locale-gen en_US.UTF-8 && \
	export LANG=en_US.UTF-8 && \
	add-apt-repository -y ppa:ondrej/php && \
	add-apt-repository -y ppa:ondrej/apache2
RUN DEBIAN_FRONTEND=noninteractive && apt-get update && \
	apt-get -y upgrade && \
	apt-get install -y apache2 php7.1 php7.1-common php7.1-json php7.1-opcache php-uploadprogress php-memcache php7.1-zip php7.1-mysql php7.1-mysqli php7.1-mongodb php7.1-solr php7.1-geoip php7.1-gmp php7.1-curl php7.1-exif php7.1-memcache php7.1-iconv php7.1-pdo-mysql php7.1-pgsql php7.1-dom php7.1-smbclient php7.1-bcmath php7.1-phpdbg php7.1-gd php7.1-imap php7.1-ldap php7.1-pgsql php7.1-pspell php7.1-recode php7.1-tidy php7.1-dev php7.1-intl php7.1-curl php7.1-mcrypt php7.1-xmlrpc php7.1-xsl php7.1-bz2 php7.1-mbstring pkg-config libmagickwand-dev imagemagick build-essential && \
	echo 'autodetect'|pecl install imagick && \
	echo "extension=imagick.so" | sudo tee /etc/php/7.1/mods-available/imagick.ini && \
	ln -sf /etc/php/7.1/mods-available/imagick.ini /etc/php/7.1/apache2/conf.d/20-imagick.ini && \
	ln -sf ../mods-available/rewrite.load /etc/apache2/mods-enabled/rewrite.load

EXPOSE 80
WORKDIR /var/www/html
ENTRYPOINT ["/run.sh"]