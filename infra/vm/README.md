# Private Linux VMs

This template creates the following private Linux VMs:

- `sample-gitlab-vm` in the existing `gitlab-vm-subnet`
- `sample-runner-vm` in the existing `gitlab-vm-subnet`
- `sample-deptest-vm` in a new `deptest-vm-subnet` (`10.0.3.0/24`)

The deployment-test subnet uses the existing NAT Gateway and a
dedicated NSG. The template does not create an AKS cluster, a public IP, or a
VNet.

## Validate

```bash
az bicep build --file ./infra/vm/main.bicep
read -s ADMIN_PASSWORD
export ADMIN_PASSWORD
az deployment group what-if \
  --resource-group <resource-group-name> \
  --parameters ./infra/vm/example.bicepparam
unset ADMIN_PASSWORD
```

The `what-if` result should add three VMs, three NICs, three OS disks, one
subnet, and one NSG. It should not change the existing GitLab subnet, NAT
Gateway, or jump boxes.

## Deploy

`ADMIN_PASSWORD` is mandatory for deployment.

```bash
read -s ADMIN_PASSWORD
export ADMIN_PASSWORD
az deployment group create \
  --name deploy-private-vms \
  --resource-group <resource-group-name> \
  --parameters ./infra/vm/example.bicepparam
unset ADMIN_PASSWORD
```

Connect from a jump box to each private IP and verify SSH before deleting the
old VM. Installing or migrating GitLab and registering GitLab Runner are
separate application setup tasks.

## Delete the incorrectly named old VM

Deleting the old VM permanently removes its OS disk and any GitLab data stored
on it. After validating or migrating to the replacement VM, run:

```bash
chmod +x ./infra/vm/delete-old-gitlab-vm.sh
RESOURCE_GROUP=<resource-group-name> \
REPLACEMENT_VM_NAME=<replacement-vm-name> \
OLD_VM_NAME=<old-vm-name> \
OLD_NIC_NAME=<old-nic-name> \
OLD_PUBLIC_IP_NAME=<old-public-ip-name> \
CONFIRM_DELETE_OLD_GITLAB_VM=<old-vm-name> \
  ./infra/vm/delete-old-gitlab-vm.sh
```