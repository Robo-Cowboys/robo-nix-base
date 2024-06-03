# 🤖 RoBo SqUaD Nix ❄️S Template 🤖

Follow these steps to configure and use this Nix template:

### 1. Clone the Repository

Clone the repository to get started with the setup. You can either use it as a template or create a fork.

Typically, you will want to clone it to a location where you keep your `dot` files, usually `~/.config/dots`.

### 2. Open a Console Window and Go to the Root of the Cloned Repo

Then run:

```bash
direnv allow
```

This will pull down all the needed files to enter a dev shell. You know it worked if you see `just` outputs.

### 3. Modify Your Keys

Open your `keys/default.nix` in your favorite editor and modify the following:

Update the `users -> main` key to match your public key. This will be in your `~/.ssh/id_ed25519.pub` file. You can run the following command to quickly get this:

```bash
cat ~/.ssh/id_ed25519.pub
```

You should also add the keys for each of your machines in the `machines` section. The reference to `sushi` is a placeholder and should be replaced with your keys.

Once you have completed your edits to `keys/default.nix`, save the file.

### 4. Configure your user

Open `modules/options/system/default.nix` and change the user from `sincore` to your main username.

the line that says `default = ["sincore"];` (around line 77)

### 4. Configure Hosts

Navigate to your `hosts` directory. Within it, you will see four folders: airgap, installer, raspberry, and sushi.

Each of these folders represents a different NixOS system that can be built using this flake.

`sushi` will be the template you can use to create your own.

Now open the `hosts/default.nix` file. In this file, you will see all the modules and options defined at the top, followed by each system as described above defined as an output.

Review and modify the hosts configuration to suit your deployment needs. The default configuration includes a template for 'Sushi', which is my main workstation. Update or remove this to reflect your setup.

Update the fs folder to match your machine's setup. Sushi is configured with Disko, BTRFS, and Luks. If you don't want to use Disko, comment out the Disko import and use your own settings.

Pay close attention to the options in the 'Sushi' configuration. Ensure your users and main user are configured correctly, as many settings depend on these configurations.

These settings are influenced by `modules/options/`.

### 5. Adjust Home Manager Environments

Adjust the home directory configurations for your user. Rename the directory to match your user as it dictates the Home Manager environment.

These settings are influenced by `modules/options/`.

### 6. Update the SOPS Configuration

Modify the root `.sops.yaml` file to include your encryption keys. This configuration determines how SOPS will encrypt your keys. For more details, see the README in the `secrets` directory.

### 7. Build and Deploy

To build an ISO, use one of the following commands:

```bash
nix build .#images.installer
nix build .#images.airgap
nix build .#images.raspberry
```

Ensure all configurations are correct before proceeding to avoid errors during deployment.

### 8. Profit! 💵
