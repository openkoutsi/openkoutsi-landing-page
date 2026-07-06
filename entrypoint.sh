#!/bin/sh
# Publish the baked static landing site into the shared volume that the stack's
# nginx serves at koutsi.dev. Mirrors the goaccess pattern in openkoutsi-ops:
# the container owns no port — it writes files into a volume nginx reads.
#
# The deployment is pull-only (okdeploy runs `docker compose pull && up -d`), so
# a new image digest recreates this container, which re-copies fresh content.
set -eu

DEST="${DIST_DIR:-/dist}"

mkdir -p "$DEST"
# Replace the volume contents with this image's site (clear stale files first).
rm -rf "${DEST:?}"/* "$DEST"/.[!.]* 2>/dev/null || true
cp -a /site/. "$DEST"/

echo "landing: published $(find "$DEST" -type f | wc -l) files to $DEST"

# Idle so the service stays running; okdeploy recreates it on the next image.
exec tail -f /dev/null
