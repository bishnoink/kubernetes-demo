#!/bin/bash

#install lamp packages
sudo yum update -y
sudo yum install -y httpd24 php70 mysql56-server php70-mysqlnd
sudo service httpd start
sudo chkconfig httpd on
sudo usermod -a -G apache ec2-user
sudo chown -R ec2-user:apache /var/www
sudo chmod 2775 /var/www
find /var/www -type d -exec sudo chmod 2775 {} \;
find /var/www -type f -exec sudo chmod 0664 {} \;
echo "<?php phpinfo(); ?>" > /var/www/html/phpinfo.php

#Install wordpress
rm -rf /var/www/html/phpinfo.php
wget https://wordpress.org/latest.tar.gz
tar -xzf latest.tar.gz
cp wordpress/wp-config-sample.php wordpress/wp-config.php

#configure env variables for DB config and change wp-config file settings

DB_NAME='<DBNAME>'
DB_USER='<username>'
DB_PASSWORD='<password>'
DB_HOST='<db_hostname>'


sed -i 's/database_name_here/'"$DB_NAME"'/g' wordpress/wp-config.php
sed -i 's/username_here/'"$DB_USER"'/g' wordpress/wp-config.php
sed -i 's/password_here/'"$DB_PASSWORD"'/g' wordpress/wp-config.php
sed -i 's/localhost/'"$DB_HOST"'/g' wordpress/wp-config.php

#Replace below key with new keys 

sed -i "/\<AUTH_KEY\>/cdefine('AUTH_KEY',         ' #U$$+[RXN8:b^-L 0(WU_+ c+WFkI~c]o]-bHw+)/Aj[wTwSiZ<Qb[mghEXcRh-');" wordpress/wp-config.php
sed -i "/\<SECURE_AUTH_KEY\>/cdefine('SECURE_AUTH_KEY',         ' D\&ovlU#\|CvJ##uNq}bel+^MFtT\&.b9{UvR]g%ixsXhGlRJ7q\!h}XWdEC[BOKXssj');" wordpress/wp-config.php
sed -i "/\<LOGGED_IN_KEY\>/cdefine('LOGGED_IN_KEY',         ' MGKi8Br(\&{H*~&0s\;{k0<S(O:+f#WM+q\|npJ-+P\;RDKT:~jrmgj#/-,[hOBk\!ry^');" wordpress/wp-config.php
sed -i "/\<NONCE_KEY\>/cdefine('NONCE_KEY',         ' FIsAsXJKL5ZlQo)iD-pt??eUbdc{_Cn<4\!d~yqz))\&B D?AwK%)+)F2aNwI|siOe');" wordpress/wp-config.php
sed -i "/\<AUTH_SALT\>/cdefine('AUTH_SALT',         ' 7T-\!^i\!0,w)L\#JK@pc2{8XE[DenYI^BVf{L:jvF,hf}zBf883td6D\;Vcy8,S)-\&G');" wordpress/wp-config.php
sed -i "/\<SECURE_AUTH_SALT\>/cdefine('SECURE_AUTH_SALT',         ' I6\`V\|mDZq21-J\|ihb u^q0F }F_NUcy\`l,=obGtq*p#Ybe4a31R,r=\|n#=]@]c #');" wordpress/wp-config.php
sed -i "/\<LOGGED_IN_SALT\>/cdefine('LOGGED_IN_SALT',         ' w<\$4c\$Hmd%/*]\`Oom>(hdXW|0M=X={we6\;Mpvtg+V.o<\$|#_}qG(GaVDEsn,~*4i#');" wordpress/wp-config.php
sed -i "/\<NONCE_SALT\>/cdefine('NONCE_SALT',         ' a\|#h{c5|P \&xWs4IZ20c2\&%4\!c(/uG}W:mAvy<I44\`jAbup]t=]V<\`}.py(wTP%%');" wordpress/wp-config.php

#copy wordress code to document root
cp -r wordpress/* /var/www/html/

# Allow AllowOverride in apache config file, restart and enable apache service
sudo sed -i 's/\<AllowOverride None\>/'AllowOverride\ All'/g' /etc/httpd/conf/httpd.conf
sudo service httpd restart
sudo chkconfig --add httpd