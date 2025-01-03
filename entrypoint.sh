#!/bin/sh

if [ -n "$EFB_PROFILE" ]; then
  PARAMS="$PARAMS -p $EFB_PROFILE"
fi

PARAMS=

PARAMS="$PARAMS $EFB_PARAMS"

eval "ehforwarderbot $PARAMS"
