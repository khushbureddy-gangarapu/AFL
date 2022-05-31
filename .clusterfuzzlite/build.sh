for fuzzer in $(find $SRC -name 'imgRead.c'); do
  clang -fsanitize=address $fuzzer -o imgRead
  ldd ./imgRead
  cp imgRead $OUT/
  cp $fuzzer $OUT/
  chmod +x $OUT/
  ./imgRead &> outfile.txt
done
