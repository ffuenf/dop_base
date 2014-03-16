Description
===========

Provides a wrapper-cookbook to setup commonly used services.

Usage
=====

This cookbook is intended as blueprint for a wrapper-cookbook. It should contain settings which may be used across systems (like company specific preferences).
Note that all attributes are "set" (node.set) as we like to leverage as many standard opscode cookbooks as possible and only override attributes to our preferences.

Requirements
============

Cookbooks
---------

The following cookbooks are direct dependencies because they're used for common "default" functionality.

* sudo
* user
* ssh_known_hosts
* apt
* git
* dotdeb
* fail2ban
* logrotate
* htpasswd

Platform
--------

The following platforms are supported and tested:

* Debian 7.4.0

Other Debian family distributions are assumed to work.

Attributes
==========

## default.rb
* `node['dop_base']['hosts']['hostname']` - the hostname (derived from a vagrant variable if present) (default: "dop")
* `node['dop_base']['hosts']['ipv4']` - the IPv4 addresses and associated domains/hostnames (default: "127.0.0.1")
* `node['dop_base']['locale']` - the system locale (default: "en_US")
* `node['dop_base']['timezone']` - the system timezone (default: "Europe/Berlin")
* `node['users']['deploy']` - the deploy user (keep this information in an encrypted databag and load contents into this attribute with: Chef::EncryptedDataBagItem.load("users", "deploy")) (default: nil)
* `node['dop_base']['ssh_known_hosts_entry']` - trusted known hosts (default: 'github.com')
* `node['authorization']['sudo']['groups']` - groups who can sudo (default: "sudo")
* `node['authorization']['sudo']['users']` - users who can sudo (see more information below) (default: node['users']['deploy']['name'])
* `node['authorization']['sudo']['passwordless']` - (default: true)
* `node['authorization']['sudo']['include_sudoers_d']` - (default: true)
* `node['authorization']['sudo']['agent_forwarding']` - (default: true)
* `node['authorization']['sudo']['sudoers_defaults']` - (default: 'env_reset')
* `node['fail2ban']['email']` - the notification email address for fail2ban (default: 'root@localhost')
* `node['dop_base']['git']['user']` - the system git user (default: node['dop_base']['hostname'])
* `node['dop_base']['git']['email']` - the email address of the system git user (default: "git@#{node['dop_base']['hostname']}")
* `node['dop_base']['packages']` - apt-packages which do not need to be configured any further (default: "htop", "nmap")

Recipes
=======

## default.rb
The default recipe will
* set the hostname
* provision the hosts files
* include all recipes of this cookbook
* provide access to the htpasswd LWRP according to the opscode cookbook
* provision host keys of known hosts to prevent key-authentication further down
* install configured apt-packages

## fail2ban.rb
The fail2ban recipe will
* install and configure fail2ban according to the opscode cookbook
* provision a jail.local to prevent ssh ddos attacks

## locales.rb
The locales recipe will
* configure the system locales properly

## logrotate.rb
The logrotate recipe will
* install and configure logrotate according to the opscode cookbook
* rotate fail2ban log files

## preboot.rb
The preboot recipe ensures that we begin our setup process like the vanilla box on the prouction side.
It is common that hosting providers (like Hetzner) provide a root-server with an already installed minimal system.
On this system there is already a root-user present, but we don't want to provision the system with root.
What this recipe does is to create a deploy-user and lock down access to the machine by only allowing the deploy-user
to access it with key-authentication.

## ssh.rb
The ssh recipe will
* configure the sshd daemon:
** PermitRootLogin no
** PasswordAuthentication no
** PubkeyAuthentication yes
** AllowAgentForwarding yes
** Subsystem sftp internal-sftp

## timezone.rb
The timezone recipe will
* configure the system time properly

## user.rb
The user recipe will
* install and configure sudo according to the opscode cookbook
* provide access to the user LWRP according to the opscode cookbook
* create the deploy user
* set configurations for the deploy user

We assume to use an encrypted databag which holds sensitive user information with the following convention (dervied from the opscode user cookbook):
```
{
	"id": "deploy", 
	"name": "dop",
	"ssh_keys": [
		"authorized ssh public key 1",
		"authorized ssh public key 2"
	],
	"groups": [ "dop", "sudo" ],
	"home": "/home/dop",
	"comment": "dop user"
}
```

License and Author
==================

- Author:: Achim Rosenhagen (<a.rosenhagen@ffuenf.de>)

- Copyright:: 2013, ffuenf

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
