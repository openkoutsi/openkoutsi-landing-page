# openkoutsi landing page — a tiny image that ships the static site and copies
# it into a shared volume that the production nginx serves at koutsi.dev.
#
# There is no build step: the site under site/ is plain HTML/CSS/JS, so the
# image is just Alpine + the files + the publish entrypoint. See entrypoint.sh
# and the `landing` service in openkoutsi-ops/compose/docker-compose.yml.
FROM alpine:3.20

COPY site/ /site/
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Written into the shared `landing_html` volume at runtime.
VOLUME ["/dist"]

ENTRYPOINT ["/entrypoint.sh"]
