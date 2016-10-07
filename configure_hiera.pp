######         ######
##  Configure R10k ##
######         ######

##  This manifest requires the zack/R10k module and will attempt to
##  configure R10k according to my blog post on directory environments.
##  Beware! (and good luck!)

class { 'hiera':
  hierarchy            => [
    'nodes/%{::trusted.certname}',
    'locations/%{::location}',
    'hostgroups/%{::hostgroup}',
    '%{::environment}/%{::application_tier}',
    '%{::environment}/secure',
    'virtual/%{::virtual}',
    'common'
  ],
  #backends             => ['yaml', 'redis'],
  backends             => [ 'yaml' ],
  merge_behavior       => 'deeper',
  logger               => 'console',
  eyaml                => true,
  eyaml_gpg            => true,
  eyaml_gpg_recipients => 'infra-sys@cdnetworks.com',
}
