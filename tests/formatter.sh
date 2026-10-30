#!/usr/bin/env bash

stylua --allow-hidden --check . || {
	printf "\033[1;31m FIX:\033[0m Run './fixFormat.sh' to fix formatting\n"
	exit 1
}
