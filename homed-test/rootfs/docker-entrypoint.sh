#!/usr/bin/env bashio

bashio::log.info "Preparing to start..."

bashio::config.require 'data_path'

export HOMED_DATA="$(bashio::config 'data_path')"
if ! bashio::fs.file_exists "$HOMED_DATA/configuration.yaml"; then
    mkdir -p "$HOMED_DATA" || bashio::exit.nok "Could not create $HOMED_DATA"

    cat <<EOF > "$HOMED_DATA/configuration.yaml"
homeassistant: true
EOF
fi

bashio::log.info "Starting HOMED-Zigbee..."

