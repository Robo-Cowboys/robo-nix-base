# 🤖 RoBo SqUaD Nix ❄️S Template 🤖
## 1: Clone this Repo.
## 2: In flake.nix update the `nyx` path to match the absolute path locally `url = "path:/home/sincore/source/nyx-snowfall-template/nyx";` OR set it to `github:Spacebar-Cowboys/nyx` if you dont want to have the main repo local.
## 3: Modify hosts to meet your needs.
I have created some templates and Sushi should be removed or modified to match the machine you are trying to deploy. Sushi is my main workstation.

Pay close attention to the options being set in sushi and make sure to setup your users and main user as that is used in many of the options

## 3: Modify homes to meet your needs.
I have setup a default user (myself) you should modify the directory name to match your user as the directory name is what dictactes the home manager env.

## 4: Modify the `./flake/keys.nix` and add your keys and systems.
In addition add your main user here as well. This is going to be used later on and will automatically be added to the options so you don't always need to set it in hosts.


## 5: Profit! 💵
