# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
    tfe = {
      source  = "hashicorp/tfe"
      version = "~> 0.67.1"
    }
  }

}

data "tfe_outputs" "source_workspace" {
  workspace    = var.workspace_name
  organization = var.organization_name
}
provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = "westus2"

  tags = {
    Environment = "Linking workspace"
    Team        = "DevOps"
  }
}

# Create NSG
resource "azurerm_network_security_group" "rg" {
  name                = "rg-security-group"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# Create a virtual network
resource "azurerm_virtual_network" "vnet1" {
  name                = "myNewTFVnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  subnet {
    name             = "subnet1"
    address_prefixes = ["10.0.1.0/24"]
  }

  subnet {
    name             = "subnet2"
    address_prefixes = ["10.0.2.0/24"]
    security_group   = data.tfe_outputs.source_workspace.outputs["nsgid"].value
  }
}
