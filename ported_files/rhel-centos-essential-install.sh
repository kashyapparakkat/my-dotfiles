
# yum install java
yum install java-1.8.0-openjdk java-1.8.0-openjdk-devel

yum install p7zip
# yum install eclipse-platform

yum install gcc

yum install java

# Download latest eclipse package. This guide uses Eclipse IDE for Java Developers version. Another popular versions are Eclipse IDE for Java EE Developers and Eclipse for PHP Developers. Select also 32-bit or 64-bit version depending on your system.
# Extract Eclipse package (example /opt/):
wget -c http://ftp.jaist.ac.jp/pub/eclipse/oomph/epp/neon/R2a/eclipse-inst-linux64.tar.gz
tar -zxvf eclipse-inst-linux64.tar.gz -C /opt
# Make symbolic link to bin directory:
ln -s /opt/eclipse/eclipse /usr/bin/eclipse
