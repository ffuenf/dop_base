# CHANGELOG for dop_base

This file is used to list changes made in each version of dop_base.

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