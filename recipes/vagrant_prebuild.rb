#
# Cookbook Name:: dop_base
# Recipe:: vagrant_prebuild
#

# if you linked out directories in the vm to your host which should be served by the webserver, make sure the webserver can write to those directories and files
#group "dialout" do
#	members "www-data"
#	append true
#	action :modify
#end