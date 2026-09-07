targetScope = 'resourceGroup'

@description('Azure region for the virtual machines and network interfaces.')
param location string = resourceGroup().location

@description('Name of the existing virtual network.')
param virtualNetworkName string

@description('Name of the existing subnet shared by GitLab and GitLab Runner.')
param gitlabSubnetName string

@description('Name of the existing NAT Gateway used for private outbound access.')
param natGatewayName string

@description('Name of the subnet for the deployment-test VM.')
param deployTestSubnetName string = 'deptest-vm-subnet'

@description('Address prefix for the deployment-test VM subnet.')
param deployTestSubnetPrefix string = '10.0.3.0/24'

@description('Name of the deployment-test VM.')
param deployTestVmName string = 'sample-deptest-vm'

@description('Administrator username for both virtual machines.')
param adminUsername string

@secure()
@minLength(12)
@description('Administrator password for both virtual machines.')
param adminPassword string

@description('Virtual machine size used by both virtual machines.')
param vmSize string = 'Standard_D2s_v3'

@description('Names of the Linux virtual machines to create.')
param virtualMachineNames array = [
  'sample-gitlab-vm'
  'sample-runner-vm'
]

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2024-05-01' existing = {
  name: virtualNetworkName
}

resource gitlabSubnet 'Microsoft.Network/virtualNetworks/subnets@2024-05-01' existing = {
  parent: virtualNetwork
  name: gitlabSubnetName
}

resource natGateway 'Microsoft.Network/natGateways@2024-05-01' existing = {
  name: natGatewayName
}

resource deployTestNetworkSecurityGroup 'Microsoft.Network/networkSecurityGroups@2024-05-01' = {
  name: '${virtualNetworkName}-${deployTestSubnetName}-nsg-${location}'
  location: location
  properties: {
    securityRules: []
  }
}

resource deployTestSubnet 'Microsoft.Network/virtualNetworks/subnets@2024-05-01' = {
  parent: virtualNetwork
  name: deployTestSubnetName
  properties: {
    addressPrefix: deployTestSubnetPrefix
    natGateway: {
      id: natGateway.id
    }
    networkSecurityGroup: {
      id: deployTestNetworkSecurityGroup.id
    }
  }
}

resource networkInterfaces 'Microsoft.Network/networkInterfaces@2024-05-01' = [for vmName in virtualMachineNames: {
  name: '${vmName}-nic'
  location: location
  properties: {
    enableAcceleratedNetworking: true
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: gitlabSubnet.id
          }
        }
      }
    ]
  }
}]

resource deployTestNetworkInterface 'Microsoft.Network/networkInterfaces@2024-05-01' = {
  name: '${deployTestVmName}-nic'
  location: location
  properties: {
    enableAcceleratedNetworking: true
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: deployTestSubnet.id
          }
        }
      }
    ]
  }
}

resource virtualMachines 'Microsoft.Compute/virtualMachines@2024-07-01' = [for (vmName, index) in virtualMachineNames: {
  name: vmName
  location: location
  tags: {
    SecurityControl: 'Ignore'
    workload: contains(vmName, 'runner') ? 'gitlab-runner' : 'gitlab'
  }
  properties: {
    hardwareProfile: {
      vmSize: vmSize
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: networkInterfaces[index].id
          properties: {
            deleteOption: 'Delete'
          }
        }
      ]
    }
    osProfile: {
      computerName: vmName
      adminUsername: adminUsername
      adminPassword: adminPassword
      linuxConfiguration: {
        disablePasswordAuthentication: false
        provisionVMAgent: true
        patchSettings: {
          assessmentMode: 'ImageDefault'
          patchMode: 'ImageDefault'
        }
      }
    }
    storageProfile: {
      imageReference: {
        publisher: 'canonical'
        offer: 'ubuntu-24_04-lts'
        sku: 'server'
        version: 'latest'
      }
      osDisk: {
        name: '${vmName}-osdisk'
        caching: 'ReadWrite'
        createOption: 'FromImage'
        deleteOption: 'Delete'
        managedDisk: {
          storageAccountType: 'Premium_LRS'
        }
      }
    }
  }
}]

resource deployTestVirtualMachine 'Microsoft.Compute/virtualMachines@2024-07-01' = {
  name: deployTestVmName
  location: location
  tags: {
    SecurityControl: 'Ignore'
    workload: 'deployment-test'
  }
  properties: {
    hardwareProfile: {
      vmSize: vmSize
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: deployTestNetworkInterface.id
          properties: {
            deleteOption: 'Delete'
          }
        }
      ]
    }
    osProfile: {
      computerName: deployTestVmName
      adminUsername: adminUsername
      adminPassword: adminPassword
      linuxConfiguration: {
        disablePasswordAuthentication: false
        provisionVMAgent: true
        patchSettings: {
          assessmentMode: 'ImageDefault'
          patchMode: 'ImageDefault'
        }
      }
    }
    storageProfile: {
      imageReference: {
        publisher: 'canonical'
        offer: 'ubuntu-24_04-lts'
        sku: 'server'
        version: 'latest'
      }
      osDisk: {
        name: '${deployTestVmName}-osdisk'
        caching: 'ReadWrite'
        createOption: 'FromImage'
        deleteOption: 'Delete'
        managedDisk: {
          storageAccountType: 'Premium_LRS'
        }
      }
    }
  }
}

output virtualMachines array = [for (vmName, index) in virtualMachineNames: {
  name: vmName
  privateIpAddress: networkInterfaces[index].properties.ipConfigurations[0].properties.privateIPAddress
}]

output deploymentTestVirtualMachine object = {
  name: deployTestVirtualMachine.name
  privateIpAddress: deployTestNetworkInterface.properties.ipConfigurations[0].properties.privateIPAddress
  subnetName: deployTestSubnet.name
}