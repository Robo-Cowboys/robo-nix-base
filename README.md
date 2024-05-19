# 🤖 RoBo SqUaD Nix ❄️S Template 🤖
Follow these steps to configure and use this Nix template: test

### 1. Clone this Repository
Clone the repository to get started with the setup.

### 2. Update the Flake File
In `flake.nix`, update the `nyx` path to match the absolute path on your local system:
```nix
url = "path:/home/yourusername/source/nyx-snowfall-template/nyx";
```
Alternatively, set it to use a GitHub repository if you do not want to have the main repo locally:
```nix
url = "github:Spacebar-Cowboys/nyx";
```

### 3. Modify Global Settings and Keys
In your local flake directory, edit `globals.nix` and `keys.nix` to match your main user and the keys you would like to use. Ensure the user and keys configuration aligns with your system requirements.
```bash
# Create System SSH keys for handshake
ssh-keygen -A 
```
```bash
# Create User SSH keys for handshake
ssh-keygen -t rsa -b 4096
```
### 4. Configure Hosts
Review and modify the hosts configuration to suit your deployment needs. The default configuration includes a template for 'Sushi', which is my main workstation. Update or remove this to reflect your own setup.

Pay close attention to the options set in the 'Sushi' configuration. Ensure you configure your users and the main user correctly, as many settings depend on these configurations.

For additional options, refer to the `github:Spacebar-Cowboys/nyx` repository under `modules/options/`.

### 5. Adjust Home Manager Environments
Navigate to the home directory configurations and adjust them for your user. Rename the directory to match your user as it dictates the Home Manager environment.

Ensure that the default user configuration imports the global Home Manager settings from:
```nix
"${inputs.nyx}/modules/home";
```
These settings are also influenced by `modules/options/`.

### 6. Update the SOPS Configuration
Modify the root `.sops.yaml` file to include your encryption keys. This configuration determines how SOPS will encrypt your keys. For more details, see the README in the `secrets` directory.

### 7. Build and Deploy
To build an ISO, use one of the following commands depending on your needs:
```bash
nix build .#images.installer
nix build .#images.airgap
nix build .#images.raspberry
```

Ensure all configurations are correct before proceeding with the builds to avoid errors during deployment.

### 8. Profit! 💵
