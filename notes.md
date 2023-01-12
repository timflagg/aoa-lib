# multicluster aoa
./aoa-tools/deploy.sh $GM_LICENSE_KEY 2.1.2 aoa-mgmt m1 mgmt mgmt ably77 aoa-lib HEAD
./aoa-tools/deploy.sh $GM_LICENSE_KEY 2.1.2 aoa-cluster1 m1 cluster1 mgmt ably77 aoa-lib HEAD
./aoa-tools/deploy.sh $GM_LICENSE_KEY 2.1.2 aoa-cluster2 m1 cluster2 mgmt ably77 aoa-lib HEAD

# single cluster freestyle
./aoa-tools/deploy.sh $GM_LICENSE_KEY 2.1.2 single-cluster-freestyle m1 mgmt mgmt ably77 aoa-lib HEAD

# single cluster httpbin
./aoa-tools/deploy.sh $GM_LICENSE_KEY 2.1.2 single-cluster-httpbin m1 mgmt mgmt ably77 aoa-lib HEAD