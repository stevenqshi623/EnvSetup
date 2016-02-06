#!/bin/bash

set -e

CHEF_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
CONF_DIR=$CHEF_DIR/conf

pp() {
    local title="$@"
    local len=$( expr $( echo $title | wc -c ) + 7 )
    local bar=`eval "printf '=%.0s' {1..$len}"`

    echo $bar
    echo "=== $title ==="
    echo $bar
}

install_chefdk() {
    pp installing chefdk
    curl -L https://www.opscode.com/chef/install.sh | bash
}

install_basic_tools() {
    pp installing basic tools
    chef-solo -c $CHEF_DIR/solo.rb -j $CONF_DIR/basic_tools.json
}

install_hdf4() {
    pp installing hdf4
    chef-solo -c $CHEF_DIR/solo.rb -j $CONF_DIR/hdf4.json
}

main() {
    [ $EUID != 0 ] && { echo "Please run as root!"; exit 1; }
    apt-get update
    hash chef-solo 2>/dev/null || install_chefdk
    install_basic_tools
    install_hdf4
}

main #@
