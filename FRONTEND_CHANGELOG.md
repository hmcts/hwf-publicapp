# Frontend changelog

Notable frontend dependency updates and the reasoning behind version choices
(especially where something was deliberately *not* bumped). Newest first.

## 2026-07-09
`picomatch` (4.0.5) and `fast-uri` (3.1.3) bumped to their latest in-range patches, while `undici` (held at 6.27.0, not 8.x) and `fast-uri` (not 4.x) stay back because their latest majors require node-gyp 13 / Node ≥26 (unpinned in CI) and ajv `^3` respectively — audit stays clean.
