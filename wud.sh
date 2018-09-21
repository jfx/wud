#!/bin/bash
#
# wud.sh is a bash program to wait for a deployment to complete.
#
# Copyright (c) 2018 FX Soubirou
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

VERSION=__VERSION__

DEFAULT_INITIAL_WAIT=30
DEFAULT_INTERVAL=10
DEFAULT_TIMEOUT=300
DEFAULT_HTTP_CODE=200

initial_wait=$DEFAULT_INITIAL_WAIT
interval=$DEFAULT_INTERVAL
timeout=$DEFAULT_TIMEOUT
http_code=$DEFAULT_HTTP_CODE

url=""

function url_validation() {
  if [ -z "$url" ] 
  then 
    echo "-u argument is mandatory !" >&2;
    usage
    exit 1
  fi
}

function integer_validation() {
  re='^[0-9]+$'
  if ! [[ $2 =~ $re ]];
  then
    echo "Error: $1 argument should be an integer" >&2;
    exit 1
  fi
}

function check() {
  if [[ "$(curl -s -o /dev/null -w %\{http_code\} ${url})" == "${http_code}" ]];
  then
    return 0
  else
    return 199
  fi
}

function usage() {
  echo "Usage: wud.sh -u <url> [options...]"
  echo "Options:"
  echo "-w initial wait in seconds before check. Default: ${DEFAULT_INITIAL_WAIT}s"
  echo "-i interval check in seconds. Default: ${DEFAULT_INTERVAL}s"
  echo "-t timeout of check in seconds. Default: ${DEFAULT_TIMEOUT}s"
  echo "-v print version"
  echo "-h print usage"
}

function version() {
  echo "wud.sh, version $VERSION"
  echo "Copyright (C) 2018 FX Soubirou"
  echo "License GPLv3+ : GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>"
}

while getopts hi:t:u:vw: option
do
  case "${option}" in
    h)
      usage
      exit 0
      ;;
    i)
      integer_validation "-i" "${OPTARG}"
      interval=${OPTARG}
      ;;
    t)
      timeout=${OPTARG}
      ;;
    u)
      url=${OPTARG}
      ;;
    w)
      initial_wait=${OPTARG}
      ;;
    v)
      version
      exit 0
      ;;
    *)
      usage
      exit 1
      ;;
  esac
done

url_validation
time_timeout=$(( $(date +%s) + timeout ))

sleep "$initial_wait"

check_status=$(check; echo $?)
while [[ $check_status != 0 ]] && [[ $(date +%s) < $time_timeout ]]
do 
  sleep "$interval"
  check_status=$(check; echo $?)
done

exit "$check_status"
