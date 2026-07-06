# openkoutsi-landing-page

The **static marketing landing page** for [openkoutsi](https://github.com/openkoutsi/openkoutsi),
served at **[koutsi.dev](https://koutsi.dev)**. It links to the web app
(**[app.koutsi.dev](https://app.koutsi.dev)**) and the
[user documentation](https://openkoutsi.github.io/openkoutsi-docs/).

This page used to be baked into the web app (openkoutsi-web) and served at the apex. It was
split out into this standalone static site so the app can live on its own `app.` subdomain — see
[openkoutsi/openkoutsi#7](https://github.com/openkoutsi/openkoutsi/issues/7).

## What's here

- `site/` — the whole site: `index.html` (English, served at `/`), `fi/index.html` (Finnish,
  `/fi/`), `styles.css`, `app.js`, and `assets/`. Plain HTML/CSS/JS, no build step.
- `Dockerfile` + `entrypoint.sh` — package `site/` into a tiny Alpine image that copies the files
  into a shared volume at runtime.
- `.github/workflows/publish.yml` — build + push `ghcr.io/openkoutsi/openkoutsi-landing-page:latest`.

## Preview locally

Any static file server works, e.g.:

```console
python3 -m http.server 8080 --directory site
# open http://localhost:8080/  (English) and http://localhost:8080/fi/  (Finnish)
```

## How it's deployed

Production is pull-only: the openkoutsi-ops stack runs a `landing` service from
`ghcr.io/openkoutsi/openkoutsi-landing-page:latest`. On start it copies `site/` into the shared
`landing_html` volume, which the stack's nginx serves at `koutsi.dev` (see
`compose/nginx/conf.d/landing.conf` and the `landing` service in
`openkoutsi-ops/compose/docker-compose.yml`). The container owns no port — it only publishes
files, mirroring the goaccess report pattern. Merging to `main` pushes a new `:latest`, and
`okdeploy` on the VM recreates the container, which re-copies fresh content.

## Editing

- Update copy/markup in `site/index.html` (English) and `site/fi/index.html` (Finnish) — keep the
  two in sync. Shared styles live in `site/styles.css`.
- CTAs point at `https://app.koutsi.dev` (web app) and the docs site; keep those in sync if the
  hostnames change.

## License

Apache-2.0. See [LICENSE](LICENSE).
