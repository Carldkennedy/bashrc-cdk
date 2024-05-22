#!/bin/bash
assign_hostname() {
  if [[ $HOSTNAME == *bessemer* ]]; then
    echo "bessemer"
  elif [[ $HOSTNAME == *stanage* ]]; then
    echo "stanage"
  elif [[ $HOSTNAME == *sharc* ]]; then
    echo "sharc"
  else
    echo "unknown"
  fi
}

# Call function and assign hostname to variable
my_hostname=$(assign_hostname)

echo "Hostname is $my_hostname"
# Save and change to the working directory
pushd . > /dev/null
cd ~/bashrc-cdk

# Attempt to update the repository, handling the outcome immediately
if git pull > /dev/null 2>&1; then
  echo -e "##################################\nCustom bashrc updated from Github.\n##################################"
  # Check if hostname is known
  if [[ "$my_hostname" != "unknown" ]]; then
    # Host-specific configurations
    grep -Fxq ". ~/bashrc-cdk/bashrc_$my_hostname" ~/.bashrc || echo -e "\n# Load custom bashrc for $my_hostname\n. ~/bashrc-cdk/bashrc_$my_hostname" >> ~/.bashrc
    grep -Fxq ". ~/bashrc-cdk/bash_aliases_$my_hostname" ~/.bashrc || echo -e "\n# Load custom bash aliases for $my_hostname\n. ~/bashrc-cdk/bash_aliases_$my_hostname" >> ~/.bashrc
  fi

  # Common configurations
  grep -Fxq ". ~/bashrc-cdk/bashrc_common" ~/.bashrc || echo -e "\n# Load custom common bashrc\n. ~/bashrc-cdk/bashrc_common" >> ~/.bashrc
  grep -Fxq ". ~/bashrc-cdk/bash_aliases_common" ~/.bashrc || echo -e "\n# Load custom common bash aliases\n. ~/bashrc-cdk/bash_aliases_common" >> ~/.bashrc
  grep -Fq "~/bashrc-cdk/bash-setup.sh" ~/.bashrc || echo -e "\n# Before enabling, check if git pull + SSH agent forwarding causes high CPU.\n# Load custom bashrc setup script\n#if [[ \$- == *i* ]]; then\n#    ~/bashrc-cdk/bash-setup.sh \n#fi" >> ~/.bashrc
  tmux source ~/bashrc-cdk/tmux.conf
else
  echo -e "################################\nCustom bashrc git update failed.\n################################"
fi
# Backup history
source ~/bashrc-cdk/bin/.local/scripts/backup_new_history.sh
# Restore the original working directory
popd > /dev/null
