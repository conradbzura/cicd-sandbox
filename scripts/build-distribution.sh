TAG=$1

# Checkout the specified tag
git fetch --unshallow
git checkout $TAG
git pull