FROM ubuntu:18.04
MAINTAINER ASCDC <asdc.sinica@gmail.com>

ADD run.sh /run.sh
ADD set_root_pw.sh /set_root_pwd.sh

RUN chmod +x /*.sh && \
	apt-get update && \
	DEBIAN_FRONTEND=noninteractive && \
	apt-get install -yyq tzdata locales locales locales-all dumb-init software-properties-common openssh-server  && \
	ln -fs /usr/share/zoneinfo/Asia/Taipei /etc/localtime && \
	dpkg-reconfigure --frontend noninteractive tzdata && \
	echo "locales locales/default_environment_locale select zh_TW.UTF-8" | debconf-set-selections && \
	echo "locales locales/locales_to_be_generated multiselect zh_TW.UTF-8 UTF-8" | debconf-set-selections && \
	rm -f "/etc/locale.gen" && \
	dpkg-reconfigure --frontend noninteractive locales && \
	locale-gen en_US.UTF-8 && \
	export LANG=zh_TW.UTF-8 && \
	export LC_ALL=zh_TW.UTF-8 && \
	echo "export LANG=zh_TW.UTF-8" >> ~/.bashrc && \
	echo "export LC_ALL=zh_TW.UTF-8" >> ~/.bashrc && \
	echo "alias ll='ls -al --color=auto'" >> ~/.bashrc && \
	echo "alias ls='ls --color=auto'" >> ~/.bashrc && \
	echo "alias grep='grep --color=auto'" >> ~/.bashrc && \
	add-apt-repository -y ppa:ondrej/php && \
	add-apt-repository -y ppa:ondrej/apache2
RUN DEBIAN_FRONTEND=noninteractive && apt-get update && \
	apt-get install -y apache2 php7.2 php7.2-common php7.2-json php7.2-opcache php-uploadprogress php-memcache php7.2-zip php7.2-mysql php7.2-phpdbg php7.2-gd php7.2-imap php7.2-ldap php7.2-pgsql php7.2-pspell php7.2-recode php7.2-tidy php7.2-dev php7.2-intl php7.2-curl php7.2-xmlrpc php7.2-xsl php7.2-bz2 php7.2-mbstring pkg-config libmagickwand-dev imagemagick build-essential && \
	echo 'autodetect'|pecl install imagick && \
	echo "extension=imagick.so" | tee /etc/php/7.2/mods-available/imagick.ini && \
	ln -sf /etc/php/7.2/mods-available/imagick.ini /etc/php/7.2/apache2/conf.d/20-imagick.ini && \
	ln -sf /etc/apache2/mods-available/rewrite.load /etc/apache2/mods-enabled/rewrite.load

EXPOSE 80
WORKDIR /var/www/html
ENTRYPOINT ["/run.sh"]
