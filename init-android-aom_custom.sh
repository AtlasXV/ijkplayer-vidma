
set -e
TOOLS=tools

#echo "== pull av1 base =="

function pull_fork()
{
    echo "== pull aom fork $1 =="
    if [ -d "android/contrib/aom-$1" ]; then
      rm -r "android/contrib/aom-$1"
    fi
    cp -r extra/aom "android/contrib/aom-$1"
}

pull_fork "armv7a"
pull_fork "arm64"
pull_fork "x86"
pull_fork "x86_64"