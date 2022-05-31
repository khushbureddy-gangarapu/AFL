# Build fuzzers into $OUT. These could be detected in other ways.
for fuzzer in $(find $SRC -name 'imgRead.c'); do
  fuzzer_basename=$(basename -s .c $fuzzer)
  fuzzer_package=${fuzzer_basename}.pkg
 
  echo "#!/bin/sh
# LLVMFuzzerTestOneInput for fuzzer detection.
this_dir=\$(dirname \"\$0\")
ASAN_OPTIONS=\$ASAN_OPTIONS:symbolize=1:external_symbolizer_path=\$this_dir/llvm-symbolizer:detect_leaks=0 \
\$this_dir/$fuzzer_package \$@" > $OUT/$fuzzer_basename
  chmod +x $OUT/$fuzzer_basename
done
