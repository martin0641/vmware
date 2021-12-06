cephadm bootstrap --mon-ip 192.168.31.204 --initial-dashboard-user vcinity --initial-dashboard-password password --dashboard-password-noupdate --allow-mismatched-release --cluster-network 172.16.3.0/24 --allow-overwrite
echo 'MDxControl!' >> pass
ceph dashboard set-login-credentials vcinity -i pass
ceph cephadm get-pub-key > ~/ceph.pub
ssh-copy-id -f -i ~/ceph.pub root@s3gc-west-2
ssh-copy-id -f -i ~/ceph.pub root@s3gc-west-3
ceph orch host add s3gc-west-2
ceph orch host add s3gc-west-3
scp * root@s3gc-west-2:/etc/ceph
scp * root@s3gc-west-3:/etc/ceph
ceph orch host label add s3gc-west-2 _admin
ceph orch host label add s3gc-west-3 _admin
ceph config set mon public_network 192.168.30.0/23,172.16.3.0/24
ceph orch daemon add mgr s3gc-west-2
ceph orch daemon add mgr s3gc-west-3
ceph orch apply mon --unmanaged
ceph orch apply osd --all-available-devices





#/usr/sbin/cephadm shell
rbd create scale-01 --object-size 4M --stripe-unit 128K --stripe-count 1 --size 95G --image-feature layering --image-feature deep-flatten --image-feature striping --image-feature exclusive-lock --image-feature object-map --image-feature fast-diff