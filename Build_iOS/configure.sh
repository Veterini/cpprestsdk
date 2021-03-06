#!/bin/bash
set -e

git clone https://gist.github.com/c629ae4c7168216a9856.git boostoniphone
pushd boostoniphone
git apply ../fix_boost_version.patch
./boost.sh
popd
mv boostoniphone/ios/framework/boost.framework .

git clone --depth=1 https://github.com/x2on/OpenSSL-for-iPhone.git
pushd OpenSSL-for-iPhone
./build-libssl.sh
popd
mkdir openssl
mv OpenSSL-for-iPhone/include openssl
mv OpenSSL-for-iPhone/lib openssl

git clone https://github.com/cristeab/ios-cmake.git
pushd ios-cmake
git apply ../fix_ios_cmake_compiler.patch
popd
mkdir build.ios
pushd build.ios
cmake .. -DCMAKE_BUILD_TYPE=Release
make
popd
echo "===="
echo "The final library is available in 'build.ios/libcpprest.a'"
