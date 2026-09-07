#!/usr/bin/env bash
set -euo pipefail

resource_group="${RESOURCE_GROUP:?Set RESOURCE_GROUP to the target resource group.}"
replacement_vm_name="${REPLACEMENT_VM_NAME:?Set REPLACEMENT_VM_NAME to the validated replacement VM.}"
old_vm_name="${OLD_VM_NAME:?Set OLD_VM_NAME to the VM you want to delete.}"
old_nic_name="${OLD_NIC_NAME:?Set OLD_NIC_NAME to the detached NIC you want to delete.}"
old_public_ip_name="${OLD_PUBLIC_IP_NAME:?Set OLD_PUBLIC_IP_NAME to the dedicated public IP you want to delete.}"

if ! az vm show --resource-group "$resource_group" --name "$replacement_vm_name" --only-show-errors >/dev/null; then
  echo "Replacement VM $replacement_vm_name was not found. Cleanup cancelled." >&2
  exit 1
fi

if [[ "${CONFIRM_DELETE_OLD_GITLAB_VM:-}" != "$old_vm_name" ]]; then
  echo "Set CONFIRM_DELETE_OLD_GITLAB_VM=$old_vm_name after validating the replacement VM." >&2
  exit 1
fi

az vm delete --resource-group "$resource_group" --name "$old_vm_name" --yes
az network nic delete --resource-group "$resource_group" --name "$old_nic_name"
az network public-ip delete --resource-group "$resource_group" --name "$old_public_ip_name"

echo 'Old VM, detached NIC, and dedicated public IP were deleted.'