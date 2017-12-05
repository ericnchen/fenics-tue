#!/bin/bash
#
# Check if we have internet access. Exit codes != 0 means we don't.

wget -q --tries=2 --timeout=2 --spider https://google.com
