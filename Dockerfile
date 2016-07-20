FROM ubuntu:trusty
MAINTAINER ASCDC <asdc.sinica@gmail.com>

ADD run.sh /run.sh

RUN chmod +x /*.sh && \
	apt-get update && \
	DEBIAN_FRONTEND=noninteractive && \
	apt-get -y install software-properties-common python-software-properties && \
	locale-gen en_US.UTF-8 && \
	export LANG=en_US.UTF-8 && \
	add-apt-repository -y ppa:ondrej/php && \
	add-apt-repository -y ppa:ondrej/apache2
RUN DEBIAN_FRONTEND=noninteractive && apt-get update && \
	apt-get -y upgrade && \
	apt-get install -y apache2 php7.0 php7.0-common php7.0-json php7.0-opcache php-uploadprogress php-memcache php7.0-zip php7.0-mysql php7.0-phpdbg php7.0-gd php7.0-imap php7.0-ldap php7.0-pgsql php7.0-pspell php7.0-recode php7.0-tidy php7.0-dev php7.0-intl php7.0-curl php7.0-mcrypt php7.0-xmlrpc php7.0-xsl php7.0-bz2 php7.0-mbstring pkg-config libmagickwand-dev imagemagick build-essential && \
	echo 'autodetect'|pecl install imagick && \
	echo "extension=imagick.so" | sudo tee /etc/php/7.0/mods-available/imagick.ini && \
	ln -sf /etc/php/7.0/mods-available/imagick.ini /etc/php/7.0/apache2/conf.d/20-imagick.ini

EXPOSE 80
WORKDIR /var/www/html
ENTRYPOINT ["/run.sh"]