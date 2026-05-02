# karl2d GameJam 2026 <br/>https://itch.io/jam/karl2d-jam

### Live Web Demo
https://rajasharan.github.io/karl2d-gamejam-2026/

### screenshot
![screenshot](./screenshot.png)

### Pre-requisites
- Odin lang
https://github.com/odin-lang/Odin/releases/tag/dev-2026-04
- karl2d
https://github.com/karl-zylinski/karl2d/releases/tag/karl2d-jam-hotfix-1
- Square font
https://strlen.com/square/

### Run locally
```sh
$> odin run game.odin -file
```

### Web builds
```sh
$> odin run karl2d/build_web -- . -o:size

$> cd bin/web
$> python3 -m http.server 8000
http://localhost:8000/
```

### Credits
[Square Font](https://strlen.com/square/)
Creative Commons Attribution 3.0 Unported
