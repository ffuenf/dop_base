maintainer 'Achim Rosenhagen'
maintainer_email 'a.rosenhagen@ffuenf.de'
license 'Apache 2.0'
description 'installs/configures dop_base'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
name 'dop_base'
version '0.2.2'

%w( debian ).each do |os|
  supports os
end

%w(
  sudo
  user
  sshd
  ssh
  hostnames
  hostsfile
  apt
  apt_cleanup
  git
  dotdeb
  ntp
  fail2ban
  logrotate
  htpasswd
  chef_handler
  chef-sugar
  sysctl
  sysdig
).each do |ressource|
  depends ressource
end
