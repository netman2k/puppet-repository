######         ######
##  Configure R10k ##
######         ######

##  This manifest requires the zack/R10k module and will attempt to
##  configure R10k according to my blog post on directory environments.
##  Beware! (and good luck!)

class { 'hiera':
  master_service       => 'puppetserver',
  hierarchy            => [
    "nodes/%{::fqdn}",
    "nodes/%{::fqdn}_secure",
    "locations/%{::location}",
    "locations/%{::location}_secure",
    "hostgroups/%{::hostgroup}",
    "hostgroups/%{::hostgroup}_secure",
    "virtual/%{::virtual}",
    "virtual/%{::virtual}_secure",
    "%{::application_tier}",
    "%{::application_tier}_secure",
    'secure',
    'common'
  ],
  backends             => ['yaml',],
  merge_behavior       => 'deeper',
  logger               => 'console',
  eyaml                => true,
  eyaml_gpg            => true,
  eyaml_gpg_recipients => 'daehyung@gmail.com',
}
