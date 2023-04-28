IJK_x264_UPSTREAM=http://git.videolan.org/git/x264.git
IJK_x264_FORK=http://git.videolan.org/git/x264.git

IJK_x264_LOCAL_REPO=extra/x264

set -e
TOOLS=tools

echo "== pull x264 base =="
sh $TOOLS/pull-repo-base.sh $IJK_x264_UPSTREAM $IJK_x264_LOCAL_REPO

function pull_fork()
{
    echo "== pull x264 fork $1 =="
    sh $TOOLS/pull-repo-ref.sh $IJK_x264_FORK android/contrib/x264-$1 ${IJK_x264_LOCAL_REPO}
}

pull_fork "armv5"
pull_fork "armv7a"
pull_fork "arm64"
pull_fork "x86"
pull_fork "x86_64"