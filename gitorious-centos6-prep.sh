# PREPARATION SCRIPT

wget -O /tmp/epel-release-6-7.noarch.rpm http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-7.noarch.rpm
rpm -Uvh /tmp/epel-release-6*.rpm
yum -y update

yum -y install vixie-cron #crontab setup

mkdir /etc/chef /root/chef-solo
wget -O /etc/chef/solo.rb https://raw.github.com/aantonov/gitorious-centos-6/master/chef-gitorious-etc-solo.rb
echo "gem: --no-rdoc --no-ri" > /etc/gemrc
yum install -y ruby ruby-devel libruby gcc-c++ make ssl-cert git
cd /tmp
wget http://production.cf.rubygems.org/rubygems/rubygems-1.4.2.tgz
tar zxf rubygems-1.4.2.tgz
ruby rubygems-1.4.2/setup.rb --no-format-executable
gem install chef
cd /tmp
git clone git://github.com/aantonov/gitorious-centos-6.git
cd /root/chef-solo
mkdir cookbooks

cp -r /tmp/gitorious-centos-6/cookbooks/* /root/chef-solo/cookbooks/
cp /tmp/gitorious-centos-6/node.json /root/chef-solo/node.json
rm -rf /tmp/gitorious-centos-6
#git clone git://github.com/aantonov/gitorious-centos-6.git
#cp /root/chef-solo/cookbooks/node.json /root/chef-solo/
echo -e "\n-------------------------------------------------------- \\n
Please review the settings in /root/chef-solo/gitorious-centos-6/node.json.\n
You will have to change these in order to customize the install of this instance."
