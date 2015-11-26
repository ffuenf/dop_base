<a href="http://www.ffuenf.de" title="ffuenf - code • design • e-commerce"><img src="https://github.com/ffuenf/Ffuenf_Common/blob/master/skin/adminhtml/default/default/ffuenf/ffuenf.png" alt="ffuenf - code • design • e-commerce" /></a>

dop_base
========
[![GitHub tag](http://img.shields.io/github/tag/ffuenf/dop_base.svg)][tag]
[![Build Status](http://img.shields.io/travis/ffuenf/dop_base.svg)][travis]
[![PayPal Donate](https://img.shields.io/badge/paypal-donate-blue.svg)][paypal_donate]
[tag]: https://github.com/ffuenf/dop_base/tags
[travis]: https://travis-ci.org/ffuenf/dop_base
[paypal_donate]: https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=J2PQS2WLT2Y8W&item_name=dop%3a%20dop_base&item_number=dop_base&currency_code=EUR

dop_base is a wrapper-cookbook to setup commonly used services by ffuenf.

Dependencies
------------

This cookbook depends on the following community cookbooks.

* sudo
* user
* sshd
* ssh
* hostnames
* hostsfile
* apt
* apt_cleanup
* git
* dotdeb
* ntp
* fail2ban
* logrotate
* htpasswd
* chef_handler
* chef-sugar
* sysctl
* sysdig
* bsw_gpg
* chef-sugar
* python

Platform
--------

The following platforms are supported and tested:

* Debian 6.x
* Debian 7.x
* Ubuntu 14.04.x
* Ubuntu 14.10.x

Other Debian family distributions are assumed to work.

Data_bags
---------

We assume to use an encrypted databag which holds sensitive user information with the following convention (derived from the opscode user cookbook):
```
{
  "id": "deploy", 
  "name": "dop_deploy",
  "group": "dop_deploy",
  "ssh_keys": [
        "authorized ssh public key 1",
        "authorized ssh public key 2"
  ],
  "groups": [ "dop_deploy", "sudo" ],
  "home": "/home/dop_deploy",
  "comment": "dop deploy user"
}
```

Development
-----------
1. Fork the repository from GitHub.
2. Clone your fork to your local machine:

        $ git clone git@github.com:USER/dop_base.git

3. Create a git branch

        $ git checkout -b my_bug_fix

4. **Write tests**
5. Make your changes/patches/fixes, committing appropriately
6. Run the tests: `rake style`, `rake spec`, `rake integration:vagrant`
7. Push your changes to GitHub
8. Open a Pull Request

Testing
-------

The following Rake tasks are provided for automated testing of the cookbook:

```
$ rake -T
rake integration:vagrant  # Run Test Kitchen with Vagrant
rake spec                 # Run ChefSpec examples
rake style                # Run all style checks
rake style:chef           # Lint Chef cookbooks
rake style:ruby           # Run Ruby style checks
rake travis               # Run all tests on Travis
```
See TESTING.md for detailed information.

License and Author
------------------

- Author:: Achim Rosenhagen (<a.rosenhagen@ffuenf.de>)

- Copyright:: 2015, ffuenf

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
