# SOPS Secrets and you.

This is a quick refrence file for full documentation see here `https://github.com/Mic92/sops-nix`

The general Idea of SOPS Nix. Is we create a secrets folder at the root. that contains additional folders and .yaml files that contain age encrypted secrets. These folders and files MUST be accompanied by a line in your .sops.yaml this is becuase the `.sops.yaml` is used to create all the age encrypted secrets. Below is an example with some comments to help demonstrate this point.

```yaml
keys:
  - &admin_alice 2504791468b153b8a3963cc97ba53d1919c5dfd4 #These are the keys that will be used to make each age secret.
  - &admin_bob age12zlz6lvcdk6eqaewfylg35w0syh58sm7gh53q5vvn7hd7c6nngyseftjxl
creation_rules:
  - path_regex: secrets/[^/]+\.(yaml|json|env|ini)$  #This is an example rule of where the secrets will be located and the file types that will be encrypted
    key_groups: #These are the groups used to encrypt the serets.
    - pgp:
      - *admin_alice
      age:
      - *admin_bob
```

# 1. Generate a key for yourself
run the following:
mkdir -p ~/.config/sops/age
Generate the user key
nix-shell -p ssh-to-age --run "ssh-to-age -private-key -i ~/.ssh/id_ed25519 > ~/.config/sops/age/keys.txt"
Generate the system key
sudo nix-shell -p ssh-to-age --run "ssh-to-age -private-key -i /etc/ssh/ssh_host_ed25519_key >> /home/$USER/.config/sops/age/keys.txt"
# 2. Now you can get the Age Public keys
Run the following:
age-keygen -y ~/.config/sops/age/keys.txt

# 3. Now you can add your public key to your .sops.yaml
Your age public key or GPG fingerprint can be written to your .sops.yaml in the root of your configuration directory or repository:

Here is an example Yaml. 
```yaml
# This example uses YAML anchors which allows reuse of multiple keys 
# without having to repeat yourself.
# Also see https://github.com/Mic92/dotfiles/blob/master/nixos/.sops.yaml
# for a more complex example.
keys:
  - &admin_alice 2504791468b153b8a3963cc97ba53d1919c5dfd4
  - &admin_bob age12zlz6lvcdk6eqaewfylg35w0syh58sm7gh53q5vvn7hd7c6nngyseftjxl
  - &server_sushi age1cec9wu3fpf07xve6vg44h356vwea6n8v7rvw0jp94waw9up5a94sl0atz0
creation_rules:
  - path_regex: secrets/[^/]+\.(yaml|json|env|ini)$
    key_groups:
    - pgp:
      - *admin_alice
    - age:
      - *admin_bob
      - *server_sushi
```
# 4. Once you have a .sops file and a path set edit that secret by running the following:
To create or edit a secret run from the root dir `nix-shell -p sops --run "sops secrets/default.yaml"`

this will open a editor let you set your seret and then encrypt it.
