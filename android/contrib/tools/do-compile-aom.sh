set -e

if [ -z "$NDK" ]; then
    echo "You must define NDK before starting."
    echo "They must point to your NDK directories.\n"
    exit 1
fi

#--------------------
# common defines
FF_ARCH=$1
if [ -z "$FF_ARCH" ]; then
    echo "You must specific an architecture 'arm, armv7a, x86, ...'.\n"
    exit 1
fi


FF_BUILD_ROOT=`pwd`


FF_BUILD_NAME=
FF_SOURCE=
FF_CROSS_PREFIX=

FF_CFG_FLAGS=

FF_EXTRA_CFLAGS=
FF_EXTRA_LDFLAGS=



#--------------------
echo ""
echo "--------------------"
echo "[*] make NDK standalone toolchain"
echo "--------------------"
FF_MAKE_FLAGS=$IJK_MAKE_FLAG
CROSS_ABI=

#----- armv7a begin -----
if [ "$FF_ARCH" = "armv7a" ]; then
        echo "gdebug fdk-aac-armv7a.............."
    FF_BUILD_NAME=aom-armv7a
    FF_SOURCE=$FF_BUILD_ROOT/$FF_BUILD_NAME

    CROSS_ABI="armeabi-v7a"

elif [ "$FF_ARCH" = "x86" ]; then
    FF_BUILD_NAME=aom-x86
    FF_SOURCE=$FF_BUILD_ROOT/$FF_BUILD_NAME

    CROSS_ABI="x86"

elif [ "$FF_ARCH" = "x86_64" ]; then

    FF_BUILD_NAME=aom-x86_64
    FF_SOURCE=$FF_BUILD_ROOT/$FF_BUILD_NAME


    CROSS_ABI="x86_64"

elif [ "$FF_ARCH" = "arm64" ]; then

    FF_BUILD_NAME=aom-arm64
    FF_SOURCE=$FF_BUILD_ROOT/$FF_BUILD_NAME

    CROSS_ABI="arm64-v8a"

else
    echo "unknown architecture $FF_ARCH";
    exit 1
fi


FF_PREFIX=$FF_BUILD_ROOT/build/$FF_BUILD_NAME/output

mkdir -p $FF_PREFIX


#--------------------
FF_MAKE_FLAGS=$IJK_MAKE_FLAG


#--------------------
echo ""
echo "--------------------"
echo "[*] check aom env"
echo "--------------------"
export COMMON_FF_CFG_FLAGS=

FF_CFG_FLAGS="$FF_CFG_FLAGS $COMMON_FF_CFG_FLAGS"

#--------------------
# Standard options:
echo "FF_PREFIX = $FF_PREFIX"
FF_CFG_FLAGS="$FF_CFG_FLAGS --enable-static --disable-shared"
FF_CFG_FLAGS="$FF_CFG_FLAGS --enable-pic --enable-strip --disable-asm --disable-cli"
FF_CFG_FLAGS="$FF_CFG_FLAGS --prefix=$FF_PREFIX"

#--------------------
echo ""
echo "--------------------"
echo "[*] configurate aom"
echo "--------------------"
cd $FF_SOURCE
echo $FF_SOURCE
echo $FF_CFG_FLAGS

#--------------------
echo "\n--------------------"
echo "[*] compile aom"
echo "--------------------"

#-DENABLE_DOCS=0 -DENABLE_TESTS=0
set +e
cd $FF_PREFIX
echo $NDK/build/cmake/android.toolchain.cmake
cmake $FF_SOURCE -DCMAKE_TOOLCHAIN_FILE=$FF_SOURCE/build/cmake/toolchains/android.cmake -DANDROID_ABI=$CROSS_ABI -DCMAKE_ANDROID_NDK=$NDK -DAOM_ANDROID_NDK_PATH=$NDK -DENABLE_DOCS=0 -DENABLE_TESTS=0
make

##--------------------
echo ""
echo "--------------------"
echo "[*] link aom"
echo "--------------------"