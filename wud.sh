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
DEFAULT_INTERVAL=20
DEFAULT_TIMEOUT=300

function check_file() {
  if [[ ! -f "$1" ]] ; then
      echo "File \"$1\" does not exist, aborting."
      exit 1
  fi
}

function init_count() {
  count=$(grep -o "$MASK" "$1" | wc -l)
  HIDDEN_COUNT=$count
}

function display_count() {
  count=$(grep -o "$MASK" "$1" | wc -l)
  delta=$((count - HIDDEN_COUNT))
  echo "Hidden variables [$VARIABLE_INDEX]: $delta matches"
  HIDDEN_COUNT=$count
  (( VARIABLE_INDEX++ ))
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

u_arg=0

while getopts u:vh option
do
  case "${option}" in
    u)
      u_arg=1
      ;;
    h)
      usage
      exit 0
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

if [ $u_arg -eq 0 ] 
then 
  echo "u argument is mandatory !"
  usage
  exit 1
fi 
