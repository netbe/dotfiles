
## Define virtualenv variables
VIRTUALENVWRAPPER="/usr/local/bin/virtualenvwrapper.sh"
if [[ -s "$VIRTUALENVWRAPPER" ]]; then
   export WORKON_HOME=$HOME/.virtualenvs
   export PIP_VIRTUALENV_BASE=$WORKON_HOME
   export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python
   export VIRTUALENVWRAPPER_VIRTUALENV=/usr/local/bin/virtualenv
   export VIRTUALENVWRAPPER_VIRTUALENV_ARGS='--no-site-packages'
   source "$VIRTUALENVWRAPPER"
fi
