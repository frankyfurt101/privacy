# DreamWhisper legal site

This repo is set up to be published with GitHub Pages.

- `index.html` = public Privacy Policy URL for App Store Connect
- `terms.html` = public Terms of Service page
- `styles.css` = shared styling

## Expected URLs after GitHub Pages is enabled

- Privacy Policy: `https://frankyfurt101.github.io/privacy/`
- Terms of Service: `https://frankyfurt101.github.io/privacy/terms.html`

## Publish from the command line

```bash
git clone git@github.com:frankyfurt101/privacy.git
cd privacy
cp -R /path/to/these/files/* .
git add .
git commit -m "Add DreamWhisper legal site"
git push origin main
```

Then enable GitHub Pages for the repository.
