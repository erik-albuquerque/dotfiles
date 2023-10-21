# All the changes i made to the .p10k.zsh file

# Default current directory color.
typeset -g POWERLEVEL9K_DIR_FOREGROUND='#C792EA'
# Color of the anchor directory segments. Anchor segments are never shortened. The first
# segment is always an anchor.
typeset -g POWERLEVEL9K_DIR_ANCHOR_FOREGROUND='#C792EA'
# Default prompt symbol.
typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VIINS_CONTENT_EXPANSION='👻' # >

# Remove 'if else' and replace this lines on my_git_formatter function
function my_git_formatter() {
  # before code...

  # Styling for different parts of Git status.
  local       meta='%7F' # white foreground
  local      clean='%156F' # green foreground
  local   modified='%006F' # cyan foreground
  local  untracked='%009F' # red foreground
  local conflicted='%009F' # red foreground

  local res

  # after code...
}

# These settings are used for repositories other than Git or when gitstatusd fails and
# Powerlevel10k has to fall back to using vcs_info.
typeset -g POWERLEVEL9K_VCS_CLEAN_FOREGROUND='#C3E88D'
typeset -g POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND='#C3E88D'
typeset -g POWERLEVEL9K_VCS_MODIFIED_FOREGROUND='#f07178'

# Status on success. No content, just an icon. No need to show it if prompt_char is enabled as
# it will signify success by turning green.
typeset -g POWERLEVEL9K_STATUS_OK=true
typeset -g POWERLEVEL9K_STATUS_OK_FOREGROUND='#FFCB6B'
typeset -g POWERLEVEL9K_STATUS_OK_VISUAL_IDENTIFIER_EXPANSION='✔'

# Status when some part of a pipe command fails but the overall exit status is zero. It may look
# like this: 1|0.
typeset -g POWERLEVEL9K_STATUS_OK_PIPE=true
typeset -g POWERLEVEL9K_STATUS_OK_PIPE_FOREGROUND='#FFCB6B'
typeset -g POWERLEVEL9K_STATUS_OK_PIPE_VISUAL_IDENTIFIER_EXPANSION='✔'

# Status when it's just an error code (e.g., '1'). No need to show it if prompt_char is enabled as
# it will signify error by turning red.
typeset -g POWERLEVEL9K_STATUS_ERROR=true
typeset -g POWERLEVEL9K_STATUS_ERROR_FOREGROUND='#f07178'
typeset -g POWERLEVEL9K_STATUS_ERROR_VISUAL_IDENTIFIER_EXPANSION='✘'

# Status when the last command was terminated by a signal.
typeset -g POWERLEVEL9K_STATUS_ERROR_SIGNAL=true
typeset -g POWERLEVEL9K_STATUS_ERROR_SIGNAL_FOREGROUND='#f07178'
# Use terse signal names: "INT" instead of "SIGINT(2)".
typeset -g POWERLEVEL9K_STATUS_VERBOSE_SIGNAME=false
typeset -g POWERLEVEL9K_STATUS_ERROR_SIGNAL_VISUAL_IDENTIFIER_EXPANSION='✘'

# Status when some part of a pipe command fails and the overall exit status is also non-zero.
# It may look like this: 1|0.
typeset -g POWERLEVEL9K_STATUS_ERROR_PIPE=true
typeset -g POWERLEVEL9K_STATUS_ERROR_PIPE_FOREGROUND='#f07178'
typeset -g POWERLEVEL9K_STATUS_ERROR_PIPE_VISUAL_IDENTIFIER_EXPANSION='✘'

###################[ command_execution_time: duration of the last command ]###################
# Show duration of the last command if takes at lea st this many seconds.
typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=3
# Show this many fractional digits. Zero means round to seconds.
typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_PRECISION=0
# Execution time color.
typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND='#FFCB6B'
# Duration format: 1d 2h 3m 4s. ....