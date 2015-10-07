######                           ######
##  Configure Directory Environments ##
######                           ######

##  This manifest requires the puppetlabs/inifile module and will attempt to
##  configure puppet.conf according to the blog post on using R10k and
##  directory environments.  Beware!

# Default for ini_setting resources:
Ini_setting {
  ensure => present,
  path   => "${::settings::confdir}/puppet.conf",
}

ini_setting { 'Configure environmentpath':
  section => 'main',
  setting => 'environmentpath',
  value   => '$confdir/environments',
}

if versioncmp($::puppetversion, '3.5') {
  # >= Puppet 3.8
  ini_setting { 'Configure basemodulepath':
    section => 'main',
    setting => 'basemodulepath',
    value   => '$confdir/modules:/usr/share/puppet/modules',
  }
} else {
# <= Puppet 3.4
  ini_setting { 'Configure modulepath':
    section => 'main',
    setting => 'modulepath',
    value   => '$confdir/modules:/usr/share/puppet/modules',
  }
  ini_setting { 'Configure manifest':
    section => 'master',
    setting => 'manifest',
    value   => '$confdir/environments/$environment/manifests/site.pp',
  }
}
