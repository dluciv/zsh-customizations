# Addition to https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/ssh-agent

# This detector is based on ssh-agent plugin implementation.
# Can't reuse it, as implementation ends up with unfunction.
function _ssh-agent_detect () {
  _ssh_env_cache="$HOME/.ssh/environment-$SHORT_HOST"

  # Check if ssh-agent is already running
  if [[ -f "$_ssh_env_cache" ]]; then
    . "$_ssh_env_cache" > /dev/null

    # Test if $SSH_AUTH_SOCK is visible
    zmodload zsh/net/socket
    if [[ -S "$SSH_AUTH_SOCK" ]] && zsocket "$SSH_AUTH_SOCK" 2>/dev/null && [[ ! -z $SSH_AGENT_PID ]]; then
      return 0
    fi
  fi

  return 1
}

# Operations: status, stop, start, restart

function _ssh-agent_status () {
  if _ssh-agent_detect; then
    echo "SSH agent: $SSH_AGENT_PID @ $SSH_AUTH_SOCK"
    return 0
  else
    echo "SSH agent not running"
    return 1
  fi
}

function _ssh-agent_stop () {
  eval $(ssh-agent -k) 2>/dev/null
  # echo $_ssh_env_cache
  rm "$_ssh_env_cache" 2>/dev/null
}

function _ssh-agent_start () (
  if _ssh-agent_detect >/dev/null; then
    echo "SSH agent already running..."
  else
    omz plugin load ssh-agent
  fi
)

function _ssh-agent_restart () {
  _ssh-agent_stop 2>&1 1>/dev/null
  _ssh-agent_start
}

# CLI

function sshagnt {
  case $1 in
    stop)
      _ssh-agent_stop
      _ssh-agent_status
    ;;
    start)
      _ssh-agent_start
      _ssh-agent_status
    ;;
    restart)
      _ssh-agent_restart
      _ssh-agent_status
    ;;
    *)
      _ssh-agent_status
    ;;
  esac
}

# Load SSH agent on start
# Usage: zstyle :omz:plugins:dluciv-ssh-agent-control autostart yes
if zstyle -t :omz:plugins:dluciv-ssh-agent-control autostart; then
  _ssh-agent_start
else
  # load vars if agent is running
  _ssh-agent_detect >/dev/null
fi

# ZSH completion for CLI

_sshagnt () {
  _describe sshagnt "('status:Current state' 'stop:Stop agent' 'start:Start agent if not already running' 'restart:Restart agent or start if not running')"
  # compadd restart
}

compdef _sshagnt sshagnt
