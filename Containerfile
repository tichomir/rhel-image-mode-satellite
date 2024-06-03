FROM registry.redhat.io/rhel9/rhel-bootc:latest

#install the lamp components
RUN dnf module enable -y php:8.2 nginx:1.22 && dnf install -y httpd mariadb mariadb-server php-fpm php-mysqlnd && dnf clean all

#start the services automatically on boot
RUN systemctl enable httpd mariadb php-fpm

#install additional
RUN dnf install -y insights-client rhc vim sudo net-tools mc

#Add the admin user to sudoers
RUN echo 'rhel-admin ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/rhel-admin
RUN chmod 0440 /etc/sudoers.d/rhel-admin

##update to latest
RUN dnf update -y

#create an awe inspiring home page!
RUN echo '<h1 style="text-align:center;">Welcome to image mode for RHEL</h1> <?php phpinfo(); ?>' >> /var/www/html/index.php
