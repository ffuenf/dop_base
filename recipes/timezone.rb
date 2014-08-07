#
# Cookbook Name:: dop_base
# Recipe:: timezone
#

package "ntpdate"

cron "set_time" do
	month "*"
	day "*"
	minute "0"
	hour "4"
	weekday "*"
	user "root"
	command %Q{
		/usr/sbin/ntpdate ptbtime1.ptb.de >/dev/null 2>&1 | logger -t ntpdate
	}
end

bash "set_timezone" do
	code <<-EOF
		echo "#{node['dop_base']['timezone']}" > /etc/timezone
		dpkg-reconfigure -f noninteractive tzdata
	EOF
end