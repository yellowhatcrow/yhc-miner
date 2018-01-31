#!/bin/bash



printf "\033[35mExecuting:\033[0m \033[32mapt-get install automake autoconf pkg-config libcurl4-openssl-dev libjansson-dev libssl-dev libgmp-dev make g++ -y\033[0m\n"
printf "\033[36mCAUTION:\033[0m \033[41mThis can replace any older version without warning!!!\033[0m\n"

read -p "Are you sure? [yes|no] " _ch

case $_ch in
	y|yes|Y|Yes)
	apt-get install automake autoconf pkg-config libcurl4-openssl-dev libjansson-dev libssl-dev libgmp-dev make g++ -y && \
	printf "\033[32mDone!\033[0m\n"
	;;
	*) printf "\033[36mExiting, nothing to do!\033[0m\n";;
esac
