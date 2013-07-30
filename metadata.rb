maintainer       "Achim Rosenhagen"
maintainer_email "a.rosenhagen@ffuenf.de"
license          "Apache 2.0"
description      "installs/configures dop_base"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.4"

%w{ debian }.each do |os|
	supports os
end

%w{ 
	sudo
	user
	ssh_known_hosts
	apt
	git
	dotdeb
	fail2ban
	logrotate
	htpasswd
	}.each do |ressource|
	depends ressource
end

recipe "dop_base::default", "includes all recipes of cookbook dop_base"
recipe "dop_base::fail2ban", "installs/configures fail2ban"
recipe "dop_base::locales", "installs/configures locales"
recipe "dop_base::logrotate", "installs/configures logrotate"
recipe "dop_base::preboot", "preboots vagrant vm"
recipe "dop_base::ssh", "installs/configures ssh"
recipe "dop_base::timezone", "installs/configures timezone"
recipe "dop_base::user", "installs/configures user"
