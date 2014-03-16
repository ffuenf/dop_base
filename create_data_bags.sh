#!/bin/sh

knife solo data bag create users deploy --data-bag-path ./test/integration/default/data_bags/ --json-file .data_bags/users_deploy.json --secret-file ./test/integration/default/encrypted_data_bag_secret
knife solo data bag create users service --data-bag-path ./test/integration/default/data_bags/ --json-file .data_bags/users_service.json --secret-file ./test/integration/default/encrypted_data_bag_secret