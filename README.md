dop_base
========
[![GitHub tag](http://img.shields.io/github/tag/ffuenf/dop_base.svg)][tag]
[![Build Status](http://img.shields.io/travis/ffuenf/dop_base.svg)][travis]
[![Gittip](http://img.shields.io/gittip/arosenhagen.svg)][gittip]

[tag]: https://github.com/ffuenf/dop_base/tags
[travis]: https://travis-ci.org/ffuenf/dop_base
[gittip]: https://www.gittip.com/arosenhagen

dop_base is a wrapper-cookbook to setup commonly used services by ffuenf.

Dependencies
------------

This cookbook depends on the following community cookbooks.

* sudo
* user
* ssh_known_hosts
* apt
* git
* dotdeb
* ntp
* fail2ban
* logrotate
* htpasswd
* chef_handler
* chef-sugar
* sysctl

Platform
--------

The following platforms are supported and tested:

* Debian 6.x
* Debian 7.x
* Ubuntu 14.04.x

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
6. Run the tests: `foodcritic`, `rubocop`, `kitchen test`
7. Push your changes to GitHub
8. Open a Pull Request

Testing
-------

dop_base is on [Travis CI](http://travis-ci.org/ffuenf/dop_base) which tests against multiple Chef and Ruby versions.

The following Rake tasks are provided for automated testing of the cookbook:

* `rake rubocop` - Run [RuboCop] style and lint checks
* `rake foodcritic` - Run [Foodcritic] lint checks
* `rake integration` - Run [Test Kitchen] integration tests (provisions a
  Vagrant VM using this cookbook and then tests the infrastructure with
  [Serverspec])
* `rake test` - Run all tests

License and Author
------------------

- Author:: Achim Rosenhagen (<a.rosenhagen@ffuenf.de>)

- Copyright:: 2014, ffuenf

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
