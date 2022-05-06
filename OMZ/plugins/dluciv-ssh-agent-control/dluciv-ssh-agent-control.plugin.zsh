# Addition to https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/ssh-agent

function _ssha_try_load_pid () {
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

function _ssh-agent-status () {
  if _ssha_try_load_pid; then
    echo "SSH agent: $SSH_AGENT_PID @ $SSH_AUTH_SOCK"
    return 0
  else
    echo "SSH agent not running"
    return 1
  fi
}

function _ssh-agent-stop () {
  eval $(ssh-agent -k) 2>/dev/null
  # echo $_ssh_env_cache
  rm "$_ssh_env_cache" 2>/dev/null
}

function _ssh-agent-start () (
  if _ssh-agent-status >/dev/null; then
    echo "SSH agent already running..."
  else
    . $ZSH/plugins/ssh-agent/ssh-agent.plugin.zsh
  fi
)

function _ssh-agent-restart () {
  _ssh-agent-stop 2>&1 1>/dev/null
  _ssh-agent-start
}

function sshagnt {
  case $1 in
    stop)
      _ssh-agent-stop
      _ssh-agent-status
    ;;
    start)
      _ssh-agent-start
      _ssh-agent-status
    ;;
    restart)
      _ssh-agent-restart
      _ssh-agent-status
    ;;
    *)
      _ssh-agent-status
    ;;
  esac
}

_sshagnt () {
  _describe sshagnt "('status:Current state' 'stop:Stop agent' 'start:Start agent if not already running' 'restart:Restart agent or start if not running')"
  # compadd restart
}

compdef _sshagnt sshagnt
