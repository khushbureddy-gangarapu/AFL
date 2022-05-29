set -e
CC=clang  CXX=clang++ CFLAGS=-fsanitize=address
export CC CXX
set $LLVM_CONFIG=/usr/bin/llvm-config-10

git clone https://github.com/AFLplusplus/AFLplusplus

cd .clusterfuzzlite/input
xxd image.img

cd AFLplusplus
make all
make install
cp $SRC/.clusterfuzzlite/imgRead.c .

./afl-cc -fsanitize=address,undefined -ggdb imgRead.c -o imgRead
