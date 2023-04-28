IJK_AAC_UPSTREAM=https://github.com/mstorsjo/fdk-aac.git
IJK_AAC_FORK=https://github.com/mstorsjo/fdk-aac.git

IJK_AAC_LOCAL_REPO=extra/fdk-aac

set -e
TOOLS=tools

echo "== pull fdk-aac base =="
sh $TOOLS/pull-repo-base.sh $IJK_AAC_UPSTREAM $IJK_AAC_LOCAL_REPO

function pull_fork()
{
    echo "== pull fdk-aac fork $1 =="
    sh $TOOLS/pull-repo-ref.sh $IJK_AAC_FORK android/contrib/fdk-aac-$1 ${IJK_AAC_LOCAL_REPO}
}

pull_fork "armv5"
pull_fork "armv7a"
pull_fork "arm64"
pull_fork "x86"
pull_fork "x86_64"