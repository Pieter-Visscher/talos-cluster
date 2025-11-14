talosctl gen config talos https://10.0.50.254:6443 \
	--with-secrets patches/secrets.yml \
	--config-patch @patches/cluster.yml \
	--config-patch @patches/controlplane-0.yml \
	--config-patch @patches/controlplane.yml \
	--config-patch @patches/storage.yml \
	--config-patch @patches/network.yml \
	--config-patch @patches/patches.yml \
	--with-docs=false \
	--with-examples=false
mv controlplane.yaml /var/www/html/talos/configs/config-58-47-ca-77-3c-5b.yaml
talosctl gen config talos https://10.0.50.254:6443 \
	--with-secrets patches/secrets.yml \
	--config-patch @patches/cluster.yml \
	--config-patch @patches/controlplane-1.yml \
	--config-patch @patches/controlplane.yml \
	--config-patch @patches/storage.yml \
	--config-patch @patches/network.yml \
	--config-patch @patches/patches.yml \
	--with-docs=false \
	--with-examples=false
mv controlplane.yaml /var/www/html/talos/configs/config-58-47-ca-77-a3-35.yaml
talosctl gen config talos https://10.0.50.254:6443 \
	--with-secrets patches/secrets.yml \
	--config-patch @patches/cluster.yml \
	--config-patch @patches/controlplane-2.yml \
	--config-patch @patches/controlplane.yml \
	--config-patch @patches/storage.yml \
	--config-patch @patches/network.yml \
	--config-patch @patches/patches.yml \
	--with-docs=false \
	--with-examples=false
mv controlplane.yaml /var/www/html/talos/configs/config-58-47-ca-77-b3-1d.yaml
