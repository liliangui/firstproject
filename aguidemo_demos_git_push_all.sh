#! /bin/sh

echo "============================================="
echo "aguidemo_demos_git_push_all"
echo "Li  Liangui"
echo "liliangui369@163.com"
echo "https://github.com/liliangui"
echo "============================================="

#vars
commitstr="multi-platform"
remotestr="origin"
#remotestr="osc master"
#remotestr="github master"
#remotestr="origin"

#git push
cd gittest
git add --all .
git commit -m ${commitstr}
git push ${remotestr}
cd ..

