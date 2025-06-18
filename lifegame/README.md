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

![image](https://github.com/user-attachments/assets/514cf7d6-d4f7-47c5-8725-5e122eb270f6)
