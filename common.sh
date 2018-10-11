#!/bin/bash

init()
{
	RED='\033[0;31m'
	GREEN='\033[0;32m'
	NC='\033[0m' # No Color
}

err() {
	echo -e "${RED}$1${NC}"
}

log() {
	echo -e "${GREEN}$1${NC}"
}
