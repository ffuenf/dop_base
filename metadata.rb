maintainer 'Achim Rosenhagen'
maintainer_email 'a.rosenhagen@ffuenf.de'
license 'Apache 2.0'
description 'installs/configures dop_base'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
name 'dop_base'
version '0.5.1'
issues_url 'https://github.com/ffuenf/dop_base/issues'
source_url 'https://github.com/ffuenf/dop_base'

%w(debian ubuntu).each do |os|
  supports os
end

%w(
  build-essential
  sudo
  user
  sshd
  ssh
  hostnames
  apt
  git
  dotdeb
  ntp
  fail2ban
  logrotate
  htpasswd
  chef_handler
  chef-sugar
  sysctl
  bsw_gpg
  chef-sugar
  python
).each do |ressource|
  depends ressource
end
