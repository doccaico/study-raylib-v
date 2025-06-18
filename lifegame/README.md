## lifegame

### Install
```sh
$ v install --git https://github.com/doccaico/raylib-v
```

### Build
```sh
# gcc (debug)
$ v -cc gcc lifegame.v

# gcc (prod)
$ v -cc gcc -prod -no-prod-options lifegame.v

# msvc (debug)
$ v -cc msvc lifegame.v

# msvc (prod)
$ v -cc msvc -prod -subsystem windows lifegame.v
```

### Play
- [R] - Restart
- [B] - Change Background Color
- [C] - Change Cell Color
