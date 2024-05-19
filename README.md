# 🤖 RoBo SqUaD Nix ❄️S Template 🤖

Follow these steps to configure and use this Nix template:

### 1. Clone the Repository

Clone the repository to get started with the setup. Use it as a template.

### 2. Open a Console Window and Go to the Root of the Cloned Repo

Run:

```bash
nix flake lock
```

then

```bash
direnv allow
```

This should pull down all the needed files to enter a dev shell. You know it worked if you see `just` outputs.

### 3. Update the Flake File

If you are developing locally and want to use the submodule, update `flake.nix` to match the absolute path on your local system:

```nix
url = "path:/home/sincore/source/RoboNyx-template/robo-nyx";
```

### 4. Modify Global Settings and Keys

Edit `flake/globals.nix` and `flake/keys.nix` in your local flake directory to match your main user and the keys you want to use. Ensure the user and keys configuration align with your system requirements.

### 5. Configure Hosts

Review and modify the hosts configuration to suit your deployment needs. The default configuration includes a template for 'Sushi', which is my main workstation. Update or remove this to reflect your setup.

Update the fs folder to match your machine's setup. Sushi is configured with Disko, BTRFS, and Luks. If you don't want to use Disko, comment out the Disko import and use your own settings.

Pay close attention to the options in the 'Sushi' configuration. Ensure your users and main user are configured correctly, as many settings depend on these configurations.

For additional options, refer to the `https://github.com/Spacebar-Cowboys/RoboNyx` repository under `modules/options/`.

### 6. Adjust Home Manager Environments

Adjust the home directory configurations for your user. Rename the directory to match your user as it dictates the Home Manager environment.

Ensure the default user configuration imports the global Home Manager settings from:

```nix
"${inputs.robo-nyx}/modules/home";
```

These settings are influenced by `modules/options/`.

### 7. Update the SOPS Configuration

Modify the root `.sops.yaml` file to include your encryption keys. This configuration determines how SOPS will encrypt your keys. For more details, see the README in the `secrets` directory.

### 8. Build and Deploy

To build an ISO, use one of the following commands:

```bash
nix build .#images.installer
nix build .#images.airgap
nix build .#images.raspberry
```

Ensure all configurations are correct before proceeding to avoid errors during deployment.

### 9. Profit! 💵
