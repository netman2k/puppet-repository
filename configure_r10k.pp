######         ######
##  Configure R10k ##
######         ######

##  This manifest requires the zack/R10k module and will attempt to
##  configure R10k according to my blog post on directory environments.
##  Beware! (and good luck!)

class { 'r10k':
  sources           => {
    'puppet' => {
      'remote'  => 'https://github.com/netman2k/puppet-repository.git',
      'basedir' =>  $::settings::environmentpath,
      'prefix'  => false,
    }
  },
}
