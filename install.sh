#!/usr/bin/env bash

PROXY_SERVER="proxy.wfw.wtb.tue.nl"


check_internet() {
  # Check if internet is available.
  #
  # Exit Codes
  #   0 - internet is available
  #   * - internet is not available

  wget -q --tries=2 --timeout=2 --spider https://google.com
}


#check_internet
#if [ "${?}" != "0" ]; then
#  export https_proxy="https://${PROXY_SERVER}:443"
#fi
