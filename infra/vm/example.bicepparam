using './main.bicep'

param adminPassword = readEnvironmentVariable('ADMIN_PASSWORD')
param location = 'japanwest'
param virtualNetworkName = 'sample-jpwest-vnet'
param gitlabSubnetName = 'gitlab-vm-subnet'
param natGatewayName = 'sample-nat'
param deployTestSubnetName = 'deptest-vm-subnet'
param deployTestSubnetPrefix = '10.0.3.0/24'
param deployTestVmName = 'sample-deptest-vm'
param adminUsername = 'azureuser'
param vmSize = 'Standard_D2s_v3'
param virtualMachineNames = [
  'sample-gitlab-vm'
  'sample-runner-vm'
]
