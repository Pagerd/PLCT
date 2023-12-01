```
[root@10 ~]# ruyi install gnu-plct gnu-plct-xthead
info: downloading 
https://mirror.iscas.ac.cn/ruyisdk/dist/RuyiSDK-20231118-PLCT-Sources-riscv64-pl
ct-linux-gnu.tar.xz to 
/root/.cache/ruyi/distfiles/RuyiSDK-20231118-PLCT-Sources-riscv64-plct-linux-gnu
.tar.xz
info: extracting RuyiSDK-20231118-PLCT-Sources-riscv64-plct-linux-gnu.tar.xz for
package gnu-plct-0.20231118.0
info: package gnu-plct-0.20231118.0 installed to 
/root/.cache/ruyi/binaries/x86_64/gnu-plct-0.20231118.0
info: downloading 
https://mirror.iscas.ac.cn/ruyisdk/dist/RuyiSDK-20231118-T-Head-Sources-riscv64-
plctxthead-linux-gnu.tar.xz to 
/root/.cache/ruyi/distfiles/RuyiSDK-20231118-T-Head-Sources-riscv64-plctxthead-l
inux-gnu.tar.xz
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100  273M  100  273M    0     0  17.0M      0  0:00:16  0:00:16 --:--:-- 28.5M
info: extracting 
RuyiSDK-20231118-T-Head-Sources-riscv64-plctxthead-linux-gnu.tar.xz for package 
gnu-plct-xthead-0.20231118.0
info: package gnu-plct-xthead-0.20231118.0 installed to 
/root/.cache/ruyi/binaries/x86_64/gnu-plct-xthead-0.20231118.0
[root@10 ~]# ruyi venv -t gnu-plct milkv-duo /tmp/venv1
info: Creating a Ruyi virtual environment at /tmp/venv1...
info: The virtual environment is now created.

You may activate it by sourcing the appropriate activation script in the
bin directory, and deactivate by invoking `ruyi-deactivate`.
A fresh sysroot/prefix is also provisioned in the virtual enviroment.
It is available at the following path:

    /tmp/venv1/sysroot

[root@10 ~]# ruyi venv -t gnu-plct-xthead sipeed-lpi4a /tmp/venv2
info: Creating a Ruyi virtual environment at /tmp/venv2...
info: The virtual environment is now created.

You may activate it by sourcing the appropriate activation script in the
bin directory, and deactivate by invoking `ruyi-deactivate`.
A fresh sysroot/prefix is also provisioned in the virtual enviroment.
It is available at the following path:

    /tmp/venv2/sysroot

[root@10 ~]# mkdir /tmp/test1
[root@10 ~]# pushd /tmp/test1
/tmp/test1 ~
[root@10 test1]# ruyi extract coremark
info: downloading https://mirror.iscas.ac.cn/ruyisdk/dist/coremark-1.01.tar.gz 
to /root/.cache/ruyi/distfiles/coremark-1.01.tar.gz
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100  391k  100  391k    0     0  1187k      0 --:--:-- --:--:-- --:--:-- 1190k
info: extracting coremark-1.01.tar.gz for package coremark-1.0.1
info: package coremark-1.0.1 extracted to current working directory
[root@10 test1]# . /tmp/venv2/bin/ruyi-activate                                                               sed -i 's/\bgcc\b/riscv64-plctxthead-linux-gnu-gcc/g' linux64/core_portme.mak nux-gnu-gcc/g' linux64/core_portme.mak 
«Ruyi venv2» [root@10 test1]# make PORT_DIR=linux64 link
riscv64-plctxthead-linux-gnu-gcc -O2 -Ilinux64 -I. -DFLAGS_STR=\""-O2   -lrt"\" -DITERATIONS=0  core_list_join.c core_main.c core_matrix.c core_state.c core_util.c linux64/core_portme.c -o ./coremark.exe -lrt
Link performed along with compile
«Ruyi venv2» [root@10 test1]# file coremark.exe 
coremark.exe: ELF 64-bit LSB executable, UCB RISC-V, RVC, double-float ABI, version 1 (SYSV), dynamically linked, interpreter /lib/ld-linux-riscv64xthead-lp64d.so.1, BuildID[sha1]=d9510c5fef107e2c56b40547a02f1488471dd2d2, for GNU/Linux 4.15.0, with debug_info, not stripped
«Ruyi venv2» [root@10 test1]# ruyi-deactivate
[root@10 test1]# popd
~
[root@10 ~]# rm -rf /tmp/test1                                                               git clone https://github.com/zlib-ng/zlib-ng.git /tmp/zlib-ng --depth 1b-ng/zlib-ng.git /tmp/zlib-ng --depth 1
Cloning into '/tmp/zlib-ng'...
remote: Enumerating objects: 372, done.
remote: Counting objects: 100% (372/372), done.
remote: Compressing objects: 100% (319/319), done.
remote: Total 372 (delta 71), reused 189 (delta 37), pack-reused 0
Receiving objects: 100% (372/372), 2.23 MiB | 3.04 MiB/s, done.
Resolving deltas: 100% (71/71), done.
[root@10 ~]# mkdir /tmp/test2
[root@10 ~]# pushd /tmp/test2
/tmp/test2 ~
[root@10 test2]# . /tmp/venv1/cmake /tmp/zlib-ng -G Ninja -DCMAKE_C_COMPILER=riscv64-plct-linux-gnu-gcc -DCMAKE_INSTALL_PREFIX=/tmp/venv1/sysroot -DCMAKE_C_FLAGS="-O2 -pipe -g" -DZLIB_COMPAT=ON -DWITH_GTEST=OFFinux-gnu-gcc -DCMAKE_INSTALLninjaIX=/tmp/venv1/sysroot -DCMAKE_C_FLAGS="-O2 -pipe -g" -DZLIB_COMPAT=ON -DWITH_GTEST=OFF
-bash: cmake: command not found
-bash: ninja: command not found
«Ruyi venv1» [root@10 test2]# yum install cmake
Last metadata expiration check: 7:32:18 ago on Mon 27 Nov 2023 07:05:19 PM UTC.
Dependencies resolved.
================================================================================
 Package                 Architecture  Version                  Repo       Size
================================================================================
Installing:
 cmake                   x86_64        3.24.3-1.oe2303          OS         11 M
Installing dependencies:
 cmake-data              noarch        3.24.3-1.oe2303          OS        1.8 M
 cmake-filesystem        x86_64        3.24.3-1.oe2303          OS         11 k
 cmake-rpm-macros        noarch        3.24.3-1.oe2303          OS         10 k
 emacs-filesystem        noarch        1:28.2-4.oe2303          OS        7.7 k
 jsoncpp                 x86_64        1.9.5-3.oe2303           OS         87 k
 libuv                   x86_64        1:1.42.0-4.oe2303        OS         80 k

Transaction Summary
================================================================================
Install  7 Packages

Total download size: 13 M
Installed size: 40 M
Is this ok [y/N]: y
Downloading Packages:
(1/7): cmake-filesystem-3.24.3-1.oe2303.x86_64. 100 kB/s |  11 kB     00:00    
(2/7): cmake-rpm-macros-3.24.3-1.oe2303.noarch. 260 kB/s |  10 kB     00:00    
(3/7): emacs-filesystem-28.2-4.oe2303.noarch.rp 152 kB/s | 7.7 kB     00:00    
(4/7): jsoncpp-1.9.5-3.oe2303.x86_64.rpm        601 kB/s |  87 kB     00:00    
(5/7): libuv-1.42.0-4.oe2303.x86_64.rpm         803 kB/s |  80 kB     00:00    
(6/7): cmake-data-3.24.3-1.oe2303.noarch.rpm    3.0 MB/s | 1.8 MB     00:00    
(7/7): cmake-3.24.3-1.oe2303.x86_64.rpm         6.6 MB/s |  11 MB     00:01    
--------------------------------------------------------------------------------
Total                                           7.8 MB/s |  13 MB     00:01     
Running transaction check
Transaction check succeeded.
Running transaction test
Transaction test succeeded.
Running transaction
  Preparing        :                                                        1/1 
  Installing       : cmake-rpm-macros-3.24.3-1.oe2303.noarch                1/7 
  Installing       : cmake-filesystem-3.24.3-1.oe2303.x86_64                2/7 
  Installing       : libuv-1:1.42.0-4.oe2303.x86_64                         3/7 
  Installing       : jsoncpp-1.9.5-3.oe2303.x86_64                          4/7 
  Running scriptlet: jsoncpp-1.9.5-3.oe2303.x86_64                          4/7 
  Installing       : emacs-filesystem-1:28.2-4.oe2303.noarch                5/7 
  Installing       : cmake-data-3.24.3-1.oe2303.noarch                      6/7 
  Installing       : cmake-3.24.3-1.oe2303.x86_64                           7/7 
  Running scriptlet: cmake-3.24.3-1.oe2303.x86_64                           7/7 
  Verifying        : cmake-3.24.3-1.oe2303.x86_64                           1/7 
  Verifying        : cmake-data-3.24.3-1.oe2303.noarch                      2/7 
  Verifying        : cmake-filesystem-3.24.3-1.oe2303.x86_64                3/7 
  Verifying        : cmake-rpm-macros-3.24.3-1.oe2303.noarch                4/7 
  Verifying        : emacs-filesystem-1:28.2-4.oe2303.noarch                5/7 
  Verifying        : jsoncpp-1.9.5-3.oe2303.x86_64                          6/7 
  Verifying        : libuv-1:1.42.0-4.oe2303.x86_64                         7/7 

Installed:
  cmake-3.24.3-1.oe2303.x86_64                                                  
  cmake-data-3.24.3-1.oe2303.noarch                                             
  cmake-filesystem-3.24.3-1.oe2303.x86_64                                       
  cmake-rpm-macros-3.24.3-1.oe2303.noarch                                       
  emacs-filesystem-1:28.2-4.oe2303.noarch                                       
  jsoncpp-1.9.5-3.oe2303.x86_64                                                 
  libuv-1:1.42.0-4.oe2303.x86_64                                                

Complete!
«Ruyi venv1» [root@10 test2]# yum install ninja
Last metadata expiration check: 7:32:28 ago on Mon 27 Nov 2023 07:05:19 PM UTC.
No match for argument: ninja
Error: Unable to find a match:cmake /tmp/zlib-ng -G Ninja -DCMAKE_C_COMPILER=riscv64-plct-linux-gnu-gcc -DCMAKE_INSTALL_PREFIX=/tmp/venv1/sysroot -DCMAKE_C_FLAGS="-O2 -pipe -g" -DZLIB_COMPAT=ON -DWITH_GTEST=OFFinux-gnu-gcc -DCMAKE_INSTALLninjaIX=/tmp/venv1/sysroot -DCMAKE_C_FLAGS="-O2 -pipe -g" -DZLIB_COMPAT=ON -DWITH_GTEST=OFF
-- Using CMake version 3.24.3
-- ZLIB_HEADER_VERSION: 1.3.0
-- ZLIBNG_HEADER_VERSION: 2.1.5
CMake Error: CMake was unable to find a build program corresponding to "Ninja".  CMAKE_MAKE_PROGRAM is not set.  You probably need to select a different build tool.
-- Configuring incomplete, errors occurred!
See also "/tmp/test2/CMakeFile
«Ruyi venv1» [root@10 test2]# yum install ninja-build 
Last metadata expiration check: 7:33:11 ago on Mon 27 Nov 2023 07:05:19 PM UTC.
Dependencies resolved.
================================================================================
 Package              Architecture Version               Repository        Size
================================================================================
Installing:
 ninja-build          x86_64       1.11.1-1.oe2303       everything       154 k
Installing dependencies:
 vim-filesystem       noarch       2:9.0-30.oe2303       OS                17 k

Transaction Summary
================================================================================
Install  2 Packages

Total download size: 171 k
Installed size: 415 k
Is this ok [y/N]: y
Downloading Packages:
(1/2): vim-filesystem-9.0-30.oe2303.noarch.rpm  123 kB/s |  17 kB     00:00    
(2/2): ninja-build-1.11.1-1.oe2303.x86_64.rpm   697 kB/s | 154 kB     00:00    
--------------------------------------------------------------------------------
Total                                           721 kB/s | 171 kB     00:00     
Running transaction check
Transaction check succeeded.
Running transaction test
Transaction test succeeded.
Running transaction
  Preparing        :                                                        1/1 
  Installing       : vim-filesystem-2:9.0-30.oe2303.noarch                  1/2 
  Installing       : ninja-build-1.11.1-1.oe2303.x86_64                     2/2 
  Running scriptlet: ninja-build-1.11.1-1.oe2303.x86_64                     2/2 
  Verifying        : vim-filesystem-2:9.0-30.oe2303.noarch                  1/2 
  Verifying        : ninja-build-1.11.1-1.oe2303.x86_64                     2/2 

Installed:
  ninja-build-1.11.1-1.oe2303.x86_64    vim-filesystem-2:9.0-30.oe2303.noarch   

Complete!                     cmake /tmp/zlib-ng -G Ninja -DCMAKE_C_COMPILER=riscv64-plct-linux-gnu-gcc -DCMAKE_INSTALL_PREFIX=/tmp/venv1/sysroot -DCMAKE_C_FLAGS="-O2 -pipe -g" -DZLIB_COMPAT=ON -DWITH_GTEST=OFFinux-gnu-gcc -DCMAKE_INSTALLninjaIX=/tmp/venv1/sysroot -DCMAKE_C_FLAGS="-O2 -pipe -g" -DZLIB_COMPAT=ON -DWITH_GTEST=OFF
-- Using CMake version 3.24.3
-- ZLIB_HEADER_VERSION: 1.3.0
-- ZLIBNG_HEADER_VERSION: 2.1.5
-- The C compiler identification is GNU 13.1.0
-- Detecting C compiler ABI info
-- Detecting C compiler ABI info - done
-- Check for working C compiler: /tmp/venv1/bin/riscv64-plct-linux-gnu-gcc - skipped
-- Detecting C compile features
-- Detecting C compile features - done
-- Arch detected: 'riscv64'
-- Basearch of 'riscv64' has been detected as: 'riscv'
-- Performing Test FNO_LTO_AVAILABLE
-- Performing Test FNO_LTO_AVAILABLE - Success
-- Looking for arm_acle.h
-- Looking for arm_acle.h - not found
-- Looking for sys/auxv.h
-- Looking for sys/auxv.h - found
-- Looking for sys/sdt.h
-- Looking for sys/sdt.h - not found
-- Looking for unistd.h
-- Looking for unistd.h - found
-- Looking for sys/types.h
-- Looking for sys/types.h - found
-- Looking for stdint.h
-- Looking for stdint.h - found
-- Looking for stddef.h
-- Looking for stddef.h - found
-- Check size of off64_t
-- Check size of off64_t - done
-- Looking for fseeko
-- Looking for fseeko - found
-- Looking for strerror
-- Looking for strerror - found
-- Looking for posix_memalign
-- Looking for posix_memalign - found
-- Looking for aligned_alloc
-- Looking for aligned_alloc - found
-- Performing Test HAVE_NO_INTERPOSITION
-- Performing Test HAVE_NO_INTERPOSITION - Success
-- Performing Test HAVE_ATTRIBUTE_VISIBILITY_HIDDEN
-- Performing Test HAVE_ATTRIBUTE_VISIBILITY_HIDDEN - Success
-- Performing Test HAVE_ATTRIBUTE_VISIBILITY_INTERNAL
-- Performing Test HAVE_ATTRIBUTE_VISIBILITY_INTERNAL - Success
-- Performing Test HAVE_ATTRIBUTE_ALIGNED
-- Performing Test HAVE_ATTRIBUTE_ALIGNED - Success
-- Performing Test HAVE_THREAD_LOCAL
-- Performing Test HAVE_THREAD_LOCAL - Success
-- Performing Test HAVE_BUILTIN_CTZ
-- Performing Test HAVE_BUILTIN_CTZ - Success
-- Performing Test HAVE_BUILTIN_CTZLL
-- Performing Test HAVE_BUILTIN_CTZLL - Success
-- Performing Test HAVE_PTRDIFF_T
-- Performing Test HAVE_PTRDIFF_T - Success
-- Performing Test HAVE_RVV_INTRIN
-- Performing Test HAVE_RVV_INTRIN - Success
-- Architecture-specific source files: arch/riscv/riscv_features.c;arch/riscv/riscv_features.c;arch/riscv/adler32_rvv.c;arch/riscv/chunkset_rvv.c;arch/riscv/compare256_rvv.c;arch/riscv/slide_hash_rvv.c
-- The following features have been enabled:

 * CMAKE_BUILD_TYPE, Build type: Release (default)
 * WITH_GZFILEOP, Compile with support for gzFile related functions
 * ZLIB_COMPAT, Compile with zlib compatible API
 * ZLIB_ENABLE_TESTS, Build test binaries
 * ZLIBNG_ENABLE_TESTS, Test zlib-ng specific API
 * WITH_SANITIZER, Enable sanitizer support
 * WITH_OPTIM, Build with optimisation
 * WITH_NEW_STRATEGIES, Use new strategies
 * WITH_RVV, Build with RVV intrinsics

-- The following features have been disabled:

 * ZLIB_SYMBOL_PREFIX, Publicly exported symbols DO NOT have a custom prefix
 * WITH_GTEST, Build gtest_zlib
 * WITH_FUZZERS, Build test/fuzz
 * WITH_BENCHMARKS, Build test/benchmarks
 * WITH_BENCHMARK_APPS, Build application benchmarks
 * WITH_NATIVE_INSTRUCTIONS, Instruct the compiler to use the full instruction set on this host (gcc/clang -march=native)
 * WITH_MAINTAINER_WARNINGS, Build with project maintainer warnings
 * WITH_CODE_COVERAGE, Enable code coverage reporting
 * WITH_INFLATE_STRICT, Build with strict inflate distance checking
 * WITH_INFLATE_ALLOW_INVALID_DIST, Build with zero fill for inflate invalid distances
 * INSTALL_UTILS, Copy minigzip and minideflate during install

-- Configuring done
-- Generating done
-- Build files have been written to: /tmp/test2
[24/93] Building C object CMakeFiles/zlib.dir/arch/riscv/riscv_features.c.o
/tmp/zlib-ng/arch/riscv/riscv_features.c: In function 'is_kernel_version_greater_or_equal_to_6_5':
/tmp/zlib-ng/arch/riscv/riscv_features.c:22:33: warning: suggest parentheses around '&&' within '||' [-Wparentheses]
   22 |     if (major > 6 || major == 6 && minor >= 5)
      |                      ~~~~~~~~~~~^~~~~~~~~~~~~
[63/93] Building C object CMakeFiles/z...atic.dir/arch/riscv/riscv_features.c.o
/tmp/zlib-ng/arch/riscv/riscv_features.c: In function 'is_kernel_version_greater_or_equal_to_6_5':
/tmp/zlib-ng/arch/riscv/riscv_features.c:22:33: warning: suggest parentheses around '&&' within '||' [-Wparentheses]
   22 |     if (major > 6 || major == 6 && minor >= 5)
      |                      ~~~~~~~~~~~^~~~~~~~~~~~~
[93/93] Linking C executable maketrees
«Ruyi venv1» [root@10 test2]# ninja install
[0/1] Install the project...
-- Install configuration: "Release"
-- Installing: /tmp/venv1/sysroot/lib64/libz.so.1.3.0.zlib-ng
-- Installing: /tmp/venv1/sysroot/lib64/libz.so.1
-- Installing: /tmp/venv1/sysroot/lib64/libz.so
-- Installing: /tmp/venv1/sysroot/lib64/libz.a
-- Installing: /tmp/venv1/sysroot/include/zlib.h
-- Installing: /tmp/venv1/sysroot/include/zlib_name_mangling.h
-- Installing: /tmp/venv1/sysroot/include/zconf.h
-- Installing: /tmp/venv1/sysroot/lib64/pkgconfig/zlib.pc
«Ruyi venv1» [root@10 test2]# ls /tmp/venv1/sysroot/include
zconf.h  zlib.h  zlib_name_mangling.h
«Ruyi venv1» [root@10 test2]# ruyi-deactivate
[root@10 test2]# popd
~
[root@10 ~]# rm -rf /tmp/test2
[root@10 ~]# 

```

