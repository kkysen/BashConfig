sshd_status=$(service ssh status)
if [[ "${sshd_status}" == *"is not running"* ]]; then
    sudo service ssh --full-restart
fi
