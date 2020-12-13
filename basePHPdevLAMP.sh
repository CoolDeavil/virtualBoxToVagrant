
##########################
# Apache Server & PHP
##########################

sudo apt-get update

sudo apt-get install apache2 -y && sudo apt-get install sqlite3 -y
sudo a2enmod rewrite

sudo add-apt-repository ppa:ondrej/php
sudo apt-get update

sudo apt-cache search --names-only ^php | grep 7.4

sudo apt-get install php7.4 php7.4-cli php7.4-common php7.4-json php7.4-opcache libapache2-mod-php7.4 -y
sudo apt-get install  php7.4-mysql  php7.4-mbstring php7.4-zip php7.4-gd php7.4-redis php7.4-sqlite3 php-uploadprogress -y

sudo apt-get install -y php-xdebug php-imagick
# update default site


############################################
# Dependencies Manages for PHP and Webpack
############################################
# install composer
curl -sS https://getcomposer.org/installer -o composer-setup.php
sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer
# node & npm
curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
sudo apt-get install -y nodejs
# Folder for npm Variables
mkdir ~/.npm-global
sudo chown -R $(whoami) ~/.npm-global/
#inform npm about the location
npm config set prefix '~/.npm-global'
# add path for npm global installs
export PATH=~/.npm-global/bin:$PATH
source ~/.bashrc

##########################
# VM Customization
##########################
sudo apt-get install figlet
sudo sudo vi /etc/update-motd.d/90-updates-available
figlet ZenPHPCoding

# Terminal TTY
sudo apt-get install zsh -y
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
sudo apt-get install fonts-powerline -y

# Test Font Installation
echo "\ue0b0 \u00b1 \ue0a0 \u27a6 \u2718 \u26a1 \u2699"
# edit ~/zshrc and replace the default theme
# ZSH_THEME="agnoster"

##########################
#  MySql  & PhpMyAdmin
##########################
sudo apt-get update
sudo apt-get install mysql-server -y

# update root user

##########################
#  REDIS
##########################
sudo apt update
sudo apt install redis-server -y
sudo vi /etc/redis/redis.conf
supervised systemd
sudo systemctl restart redis.service

redis-cli ping  # PONG

##########################
#install mailcatcher
##########################
sudo apt-get install build-essential libsqlite3-dev ruby-dev -y
sudo gem install mailcatcher
# Add mailcatcher service
sudo systemctl enable mailcatcher
sudo systemctl start mailcatcher
# localhost:1080
#/usr/local/bin/mailcatcher --ip 0.0.0.0

########################################
#  Clean the BOX
########################################
sudo apt-get clean && sudo apt-get autoremove
sudo dd if=/dev/zero of=/EMPTY bs=1M
sudo rm -f /EMPTY
cat /dev/null > ~/.bash_history && history -c && exit

########################################
#  Package the BOX
########################################
vagrant package --output mynew.box
