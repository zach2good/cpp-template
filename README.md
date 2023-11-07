# cpp-template

A template I end up using to bootstrap all C++ projects I start.

## Build

```sh
mkdir build
cmake -S . -B build -DCMAKE_BUILD_TYPE=Debug
cmake --build build --config Debug -j4
```

## Run

```sh
.\build\test\Debug\test.exe
.\build\src\Debug\main.exe
```
