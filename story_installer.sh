import os

# input moniker
moniker = input("Enter your moniker name: ")

commands = [
    # install Update
    "sudo apt update",
    "sudo apt-get update",
    "sudo apt install curl git make jq build-essential gcc unzip wget lz4 aria2 -y",
    # install story-geth v0.9.3
    "wget https://story-geth-binaries.s3.us-west-1.amazonaws.com/geth-public/geth-linux-amd64-0.9.3-b224fdf.tar.gz",
    "tar -xzvf geth-linux-amd64-0.9.3-b224fdf.tar.gz",
    "[ ! -d \"$HOME/go/bin\" ] && mkdir -p $HOME/go/bin",
    "if ! grep -q \"$HOME/go/bin\" $HOME/.bash_profile; then echo \"export PATH=$PATH:/usr/local/go/bin:~/go/bin\" >> ~/.bash_profile; fi",
    "sudo cp geth-linux-amd64-0.9.3-b224fdf/geth $HOME/go/bin/story-geth",
    "source $HOME/.bash_profile",
    "story-geth version",
     # install story v0.10.1
    "wget https://story-geth-binaries.s3.us-west-1.amazonaws.com/story-public/story-linux-amd64-0.10.1-57567e5.tar.gz",
    "tar -xzvf story-linux-amd64-0.10.1-57567e5.tar.gz",
    "[ ! -d \"$HOME/go/bin\" ] && mkdir -p $HOME/go/bin",
    "if ! grep -q \"$HOME/go/bin\" $HOME/.bash_profile; then echo \"export PATH=$PATH:/usr/local/go/bin:~/go/bin\" >> ~/.bash_profile; fi",
    "cp $HOME/story-linux-amd64-0.10.1-57567e5/story $HOME/go/bin",
    "source $HOME/.bash_profile",
    "story version",
    # moniker init
    f"story init --network iliad --moniker \"{moniker}\"",
    # service make
    "sudo tee /etc/systemd/system/story-geth.service > /dev/null <<EOF\n[Unit]\nDescription=Story Geth Client\nAfter=network.target\n\n[Service]\nUser=root\nExecStart=/root/go/bin/story-geth --iliad --syncmode full\nRestart=on-failure\nRestartSec=3\nLimitNOFILE=4096\n\n[Install]\nWantedBy=multi-user.target\nEOF",
    "sudo tee /etc/systemd/system/story.service > /dev/null <<EOF\n[Unit]\nDescription=Story Consensus Client\nAfter=network.target\n\n[Service]\nUser=root\nExecStart=/root/go/bin/story run\nRestart=on-failure\nRestartSec=3\nLimitNOFILE=4096\n\n[Install]\nWantedBy=multi-user.target\nEOF",
    "sudo systemctl daemon-reload && sudo systemctl start story-geth && sudo systemctl enable story-geth",
    "sudo systemctl daemon-reload && sudo systemctl start story && sudo systemctl enable story",
    # Check block
    "while true; do local_height=$(curl -s localhost:26657/status | jq -r '.result.sync_info.latest_block_height'); network_height=$(curl -s https://rpc-story.josephtran.xyz/status | jq -r '.result.sync_info.latest_block_height'); blocks_left=$((network_height - local_height)); echo -e \"\\033[1;38mYour node height:\\033[0m \\033[1;34m$local_height\\033[0m | \\033[1;35mNetwork height:\\033[0m \\033[1;36m$network_height\\033[0m | \\033[1;29mBlocks left:\\033[0m \\033[1;31m$blocks_left\\033[0m\"; sleep 5; done"
]

for command in commands:
    os.system(command)
