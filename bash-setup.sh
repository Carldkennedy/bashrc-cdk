#!/bin/bash
assign_hostname() {
  if [[ "$HOSTNAME" == *"bessemer"* ]]; then
    hostname="bessemer"
  elif [[ "$HOSTNAME" == *"stanage"* ]]; then
    hostname="stanage"
  elif [[ "$HOSTNAME" == *"sharc"* ]]; then
    hostname="sharc"
  else
    hostname="unknown"
  fi
  echo $hostname
}
# call function and assign hostname to variable
my_hostname=$(assign_hostname)


# check if hostname is known
if [[ "$my_hostname" != "unknown" ]]; then
  echo "Hostname is $my_hostname"
    # save current working directory
    pushd . > /dev/null

    # Clone the repository to the user's home directory first.

    cd ~/bashrc-cdk && git pull > /dev/null 2>&1 && 

    echo -e "##################################\nCustom bashrc updated from Github.\n##################################" || 
    echo -e "################################\nCustom bashrc git update failed.\n################################"

    if [ $? -eq 0 ]; then

      ## HOST Specific
      # Check if the lines are already in the .bashrc file
      if ! grep -Fxq ". ~/bashrc-cdk/bashrc_$my_hostname" ~/.bashrc
      then
        # If not, add them to the .bashrc file
        echo -e "\n# Load custom bashrc for $my_hostname\n. ~/bashrc-cdk/bashrc_$my_hostname" >> ~/.bashrc
      fi

      if ! grep -Fxq ". ~/bashrc-cdk/bash_aliases_$my_hostname" ~/.bashrc
      then
        # If not, add them to the .bashrc file
        echo -e "\n# Load custom bash aliases for $my_hostname\n. ~/bashrc-cdk/bash_aliases_$my_hostname" >> ~/.bashrc
      fi
      ## Common
      if ! grep -Fxq ". ~/bashrc-cdk/bashrc_common" ~/.bashrc
      then
        # If not, add them to the .bashrc file
        echo -e "\n# Load custom common bashrc\n. ~/bashrc-cdk/bashrc_common" >> ~/.bashrc
      fi

      if ! grep -Fxq ". ~/bashrc-cdk/bash_aliases_common" ~/.bashrc
      then
        # If not, add them to the .bashrc file
        echo -e "\n# Load custom common bash aliases\n. ~/bashrc-cdk/bash_aliases_common" >> ~/.bashrc
      fi

      if ! grep -Fq "~/bashrc-cdk/bash-setup.sh" ~/.bashrc
      then
        # If not, add them to the .bashrc file
        echo -e "\n# Before enabling, check if git pull + SSH agent forwarding causes high CPU." >> ~/.bashrc
        echo -e "# Load custom bashrc setup script\n#if [[ \$- == *i* ]]; then\n#    ~/bashrc-cdk/bash-setup.sh \n#fi" >> ~/.bashrc
      fi

    else
      echo "Error: Git clone failed, setup or update aborted." 
    fi
else
  echo "Hostname is unknown. Exiting script."
  exit 1
fi
tmux -f tmux.conf
vim -u vimrc
# restore current working directory
popd > /dev/null

