# CHANGELOG for dop_base

This file is used to list changes made in each version of dop_base.

## 0.2.13 (October 9, 2015)

* add tmp_npm() to allow installation of nodejs and modules inside vagrant

## 0.2.12 (April 17, 2015)

* introduce magento backend login filter for fail2ban

## 0.2.11 (February 19, 2015)

* introduce node['dop_base']['sshd_config']['use_custom_adjustments'] to circumvent too special sshd_config settings

## 0.2.10 (February 16, 2015)

* fix ownership of logrotate/fail2ban

## 0.2.9 (February 13, 2015)

* disable apf, bfd and maldetect by default completely

## 0.2.8 (January 21, 2015)

* disable (Advanced Policy Firewall)[https://www.rfxn.com/projects/advanced-policy-firewall/] by default
* update travis-ci: use containerized infrastructure

## 0.2.7 (January 16, 2015)

* add (Advanced Policy Firewall)[https://www.rfxn.com/projects/advanced-policy-firewall/]
* add (Brute Force Detection)[https://www.rfxn.com/projects/brute-force-detection/]
* add (Linux Malware Detect)[https://www.rfxn.com/projects/linux-malware-detect/]
* add compatibility between apf and fail2ban
* add custom motd
* embrace best practices from (Secure Secure Shell)[https://stribika.github.io/2015/01/04/secure-secure-shell.html] and (Secure Secure Shell on Debian Wheezy)[https://xivilization.net/~marek/blog/2015/01/12/secure-secure-shell-on-debian-wheezy/]
* adjust /etc/default/sysstat
* embrace (Quick Tip: Serverspec Spec_helper in Test Kitchen)[http://jtimberman.housepub.org/blog/2014/12/31/quick-tip-serverspec-spec-helper-in-test-kitchen/]

## 0.2.6 (December 27, 2014)

* add (nginx-limitreq)[https://cowthink.org/custom-fail2ban-filter-for-limit-req-nginx/] fail2ban settings

## 0.2.5 (December 17, 2014)

* update awscli config and credential settings

## 0.2.4 (December 15, 2014)

* add .ssh/ for root user

## 0.2.3 (November 22, 2014)

* add awscli
* add gnupg

## 0.2.2 (October 13, 2014)

* introduce serverspec2;
* add antispam-bee fail2ban settings
* make fail2ban dynamic (activate rules with attribute settings)

## 0.2.1 (September 28, 2014)

* prepare upgrade to serverspec2;
* add sysdig recipe;
* rewrite tests to fullfill serverspec2 compatibility;

## 0.2.0 (August 16, 2014)

* add colorized bash prompt via .bashrc
* remove ntpdate setting via cron. add ntp service instead
* add more packages (ntp, siege)
* update/integrate testsuites: test-kitchen, foodcritic, rubocop, travis-ci

## 0.1.2 (August 9, 2014)

* include chef-sugar
* include sysctl and set vm.overcommit_memory 1

## 0.1.1 (August 7, 2014)

* install ntpdate and set time every day via cron;

## 0.1.0 (July 19, 2014)

* add compatibility with ubuntu (use upstart service provider for ssh; conditionally load dotdeb)

## 0.0.7 (March 16, 2014)

* introduce test-kitchen

## 0.0.6 (February 21, 2014)

* enable sftp config
* fix user/group setting
* integrate fail2ban filter template for pure-ftpd
* integrate fail2ban filter templates for wordpress (http://antispambee.de/ / http://wordpress.org/plugins/wp-fail2ban/)

## 0.0.5 (July 30, 2013)

* track structure change of dop (integrate vagrant_prebuild recipe, which is run for prebuild VMs)

## 0.0.4 (July 18, 2013)

* rewrite hosts configuration

## 0.0.3 (May 10, 2013)

* introduced service user

## 0.0.2 (May 8, 2013)

* fixed sudo command when generating locales

## 0.0.1 (April 30, 2013)

* Initial release of dop_base