#!/bin/bash

#
# BBRF hook script - /ip/new/tag-cdn.sh
#

ips=$@

git -C $HOME/hacktools/cdn-ranges/ pull

for f in $HOME/hacktools/cdn-ranges/providers/*.js; do
 provider=${f%%.*}; provider=${provider##*/};
 ip_match -F $HOME/hacktools/cdn-ranges/output/$provider.txt <(printf '%s\n' ${ips[@]} | sort ) | cut -f1 -d"/" | bbrf ip update - -t cdn:$provider;
done
