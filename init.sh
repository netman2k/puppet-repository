#!/bin/bash

function init_puppt(){

  rpm -qi puppetlabs-release-pc1 > /dev/null || rpm -Uvh https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm
  rpm -qi puppetserver > /dev/null || yum install puppetserver -y

  source /etc/profile.d/puppet-agent.sh

  puppet module install zack/r10k
  puppet module install puppet-hiera

  \cp -fv environment.conf /etc/puppetlabs/puppet/

  puppet apply configure_r10k.pp
  puppet apply configure_hiera.pp
  puppet apply configure_directory_environments.pp

}

function set_application_tier_facts(){
  local env=${1:-"production"}
  mkdir -p /etc/facter/facts.d
  cat <<EOF > /etc/facter/facts.d/environment.sh
#!/bin/bash
echo "application_tier=${env}"
EOF
  chmod +x /etc/facter/facts.d/environment.sh

}

function main(){
  local env=$1; shift 1;;
  init_puppet
  set_application_tier_facts $env
  r10k deploy environment -pv
}

main "$@"
