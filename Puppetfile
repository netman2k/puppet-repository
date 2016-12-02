forge "http://forge.puppetlabs.com"

# Modules from the Puppet Forge
mod "puppetlabs/apache"
mod "puppetlabs/ntp"
mod 'puppetlabs/concat'
mod 'puppetlabs/stdlib', '4.12.0'
mod 'puppetlabs/inifile'
mod 'puppet/hiera'
mod 'puppet/staging'
mod 'puppet/selinux'
mod 'saz/rsyslog', '4.0.2'
mod 'saz/ssh', '2.9.1'
mod 'joshbeard/login_defs', '0.2.0'
mod 'ccin2p3/etc_services', '1.0.2'
mod 'duosecurity/duo_unix', :latest
mod 'crayfishx/firewalld', :latest
mod 'aboe/chrony',
  :git    => 'https://github.com/aboe76/puppet-chrony.git'
mod 'ghoneycutt/common'
mod 'ghoneycutt/nsswitch'
mod 'ghoneycutt/pam',
  :git    => 'https://github.com/ghoneycutt/puppet-module-pam.git',
  :commit => '4ac5ce444df1aefae50d6f35c40792f8892177c8'
mod 'snmp',
# Currently, razersedge/snmp module makes many nosy warnings
# such as Warning: Unknown variable: '::snmp_agentaddress'.
# at /etc/puppetlabs/code/environments/dev/modules/snmp/manifests/params.pp:19:19
# It's not fully support Puppet 4.0 syntax. that's why I used another git repo.
# The origin is :
  #:git   => 'https://github.com/razorsedge/puppet-snmp.git'
  :git    => 'https://github.com/mterzo/puppet-snmp.git',
  :branch => 'enable_strict'
   #:tag    => '3.6.0'
mod 'herculesteam/augeasproviders_sysctl', '2.1.0'
mod 'profiles',
  :git     => 'https://github.com/netman2k/puppet-profiles.git',
  :branch => 'dev'
mod 'roles',
  :git => 'https://github.com/netman2k/puppet-roles.git'
