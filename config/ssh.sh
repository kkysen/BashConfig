if [[ "${SSH_AGENT_PID}" == "" ]]; then
	eval `ssh-agent`
	ssh-add
fi
