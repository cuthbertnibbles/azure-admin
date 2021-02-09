FROM ubuntu

# Update Ubuntu
RUN apt-get update -y
RUN apt-get upgrade -y


# Install pre-requisite packages.
RUN apt-get install -y \
        less \
        locales \
        ca-certificates \
        libicu66 \
        libssl1.1 \
        libc6 \
        libgcc1 \
        libgssapi-krb5-2 \
        liblttng-ust0 \
        libstdc++6 \
        zlib1g \
        wget\
        software-properties-common

# Download the Microsoft repository GPG keys
RUN wget -q https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb

# Register the Microsoft repository GPG keys
RUN dpkg -i packages-microsoft-prod.deb

# Update the list of products
RUN apt-get update

# Enable the "universe" repositories
RUN add-apt-repository universe

# Install PowerShell
RUN apt-get install -y powershell

# Install Az (Azure) Module for things you can't afford to administer
RUN pwsh -Command "Install-Module -Name Az -AllowClobber -Scope CurrentUser -Force"

# Install MSOL (Microsoft Online) Module for Azure AD administration
RUN pwsh -Command "Install-Module -Name AzureADPreview -AllowClobber -Force"

# Install the PS Core-compatible version of Exchange Online PowerShell V2
RUN pwsh -Command "Install-Module -Name ExchangeOnlineManagement -RequiredVersion 2.0.4-Preview2 -AllowPrerelease -Force"

# Start PowerShell
ENTRYPOINT [ "pwsh" ]
