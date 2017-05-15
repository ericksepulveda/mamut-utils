function mamut {
  cat <<-'EOF'
                    ,--"`-.-._
                   ,' ,.:::::. `.
                   | ;'     `:: |
               ,--,-, .::::..;','
             ,'   ,'      "" ,'_
              '-)",'o         "_\
              _,' ""'  .::.  .:o;
             ;      :::'       ;
             ;     \`::;        ;
             : (_;_ ;::        ;\
            ;  /   ;::.        ; \
           /  /    ,:'        ;:: \
        __|__/_   /::        ;   \ `
    _,-'       \`-<::'___    ;|   \  \
 ,-'    _,-""";-._`.(__ `.  ;|    \ |      ____
(   ,--'__,--'   |`-`(@)  \(  \`.   `.   ,-'    `-.
 \___.-'   \     |::. \    :    `.   `./,-'""`.   \
            \    |::.  )   : .-.  `-._ ' `--.--'   )
             \ .-`.:' /    :      /   `-.__   __,-'
   bye        )    `.'     ;     /         `"'
             (  `'  ,\    , ---.(
             ,' --- `:`--'  :  : \
            (  :  :  ;   `--`--`-'
             `-`--`--
	EOF
}

function debugOn {
  if [[ $DEBUG ]]; then
    echo "+ debugOn" &&  set -x
  fi
}

function debugOff {
  if [[ $DEBUG ]] 2>/dev/null; then
    { set +x; } 2>/dev/null
  fi
}

function setWorkingDir {
  pushd $(dirname $0) > /dev/null
  WORKING_DIR=$(pwd)
  popd > /dev/null
}

function log {
  if [ ! -n "$UTILS_ECHO_E" ]; then
    if [[ $(man echo | egrep "\-e" | wc -l) > 0 ]]; then
      export UTILS_ECHO_E=true
    else
      export UTILS_ECHO_E=false
    fi
  fi

  while getopts ":c:" opt "$@"; do
    case $opt in
      c)
        logColor $OPTARG
        shift 2
        ;;
    esac
  done

  if [[ $UTILS_ECHO_E == "true" ]]; then
    echo -e "\e[1m["$(date "+%d/%m/%y %H:%M")] "\e[0m$UTILS_ECHO_COLOR$@\e[0m"
    resetColor
  else
    echo [$(date "+%d/%m/%y %H:%M")] "$@"
  fi
}

function logColor {
  case $1 in
    red)
      UTILS_ECHO_COLOR="\e[31m"
      ;;
    green)
      UTILS_ECHO_COLOR="\e[32m"
      ;;
    blue)
      UTILS_ECHO_COLOR="\e[34m"
      ;;
    *)
      UTILS_ECHO_COLOR=""
      ;;
  esac
}

function resetColor {
  UTILS_ECHO_COLOR=""
}
