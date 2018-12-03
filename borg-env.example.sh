#!/usr/bin/env sh

export BORG_PASSPHRASE="changeme"
export BORG_RSH="ssh -i /root/.ssh/changeme"
export BORG_REPO='ssh://user@example.tld/backup/dir'
