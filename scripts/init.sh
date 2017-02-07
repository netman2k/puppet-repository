#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

function config(){

  yum install -y git
  git clone https://github.com/netman2k/puppet-repository.git
  cd puppet-repository

  puppet module install puppetlabs/inifile
  puppet apply ${DIR}/../configure_directory_environments.pp
  cp -fv ${DIR}/../environment.conf /etc/puppetlabs/puppet/

  puppet module install puppet/r10k
  puppet apply ${DIR}/../configure_r10k.pp

  puppetserver gem install hiera-eyaml

  if [ "$(systemctl is-active puppetserver)" = "active" ];then
    systemctl restart puppetserver
  fi

  #yum install ruby -y
  export PATH=/opt/puppetlabs/puppet/bin/:$PATH
  gem install hiera-eyaml
  puppet module install puppet-hiera
  puppet apply ${DIR}/../configure_hiera.pp

}

function install_puppet(){

  rpm -qi puppetlabs-release-pc1 > /dev/null || rpm -Uvh https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm
  rpm -qi puppetserver > /dev/null || yum install puppetserver -y

  source /etc/profile.d/puppet-agent.sh

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

function generate_gpg(){

  cat << EOF >> /tmp/gpg_answers
%echo Generating a Puppet Hiera GPG Key
Key-Type: RSA
Key-Length: 4096
Subkey-Type: ELG-E
Subkey-Length: 4096
Name-Real: Hiera Data
Name-Comment: Hiera Data Encryption
Name-Email: infra-sys@cdnetworks.com
Expire-Date: 0
%no-ask-passphrase
# Do a commit here, so that we can later print "done" :-)
# %commit
# %echo done
EOF

}

function main(){

  install_puppet
  config
#  generate_gpg
#  set_application_tier_facts $1
  r10k deploy environment -pv
}


main "$@"
