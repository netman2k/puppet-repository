######                           ######
##  Configure Directory Environments ##
##  It's for the puppetserver >= 2.5 ##
######                           ######

# Reference:
# https://docs.puppet.com/puppet/4.6/reference/environments_configuring.html 

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
  value   => '$codedir/environments',
}

ini_setting { 'Configure basemodulepath':
  section => 'main',
  setting => 'basemodulepath',
  value   => '$codedir/modules:/usr/share/puppet/modules',
}

