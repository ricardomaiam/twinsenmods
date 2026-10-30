# Compilar o motor / Building the engine

The gameplay mods run on a modified build of
[LBA2 Classic Community](https://github.com/2point21/lba2-classic-community) (GPL-2.0).
All changes are in `mods_motor.patch`, made against commit `2fa1c7a`.
Os mods de jogabilidade rodam numa versão modificada desse motor; todas as
mudanças estão em `mods_motor.patch`, feito sobre o commit `2fa1c7a`.

## Steps / Passos

```sh
git clone https://github.com/2point21/lba2-classic-community
cd lba2-classic-community
git checkout 2fa1c7a
git apply /path/to/mods_motor.patch
```

Then build as the upstream project documents (see its `README.md` and
`CMakePresets.json`), for example on Windows with MSYS2 UCRT64:
Depois compile como o projeto original explica (veja o `README.md` e o
`CMakePresets.json` dele), por exemplo no Windows com o MSYS2 UCRT64:

```sh
cmake --preset windows_ucrt64
cmake --build --preset windows_ucrt64
```

The released `lba2cc.exe` was cross-compiled from Linux with llvm-mingw
(ucrt, x86_64) and SDL3 3.2.26, statically linked except for `SDL3.dll`.
O `lba2cc.exe` do pacote foi compilado no Linux com o llvm-mingw (ucrt,
x86_64) e o SDL3 3.2.26.

Headless test example / exemplo de teste sem janela:

```sh
LBA2_MODS_MOTOR="swim,jetfree,pilot,orbit,blaster,world" \
  ./lba2cc --headless --no-autosave --game-dir <game> --user-dir /tmp/u \
  --load <save> --tick 200 --screenshot shot.png --exit
```
