# must ssh vagrant@10.0.0.41,22 first

ansible-playbook --inventory-file=hosts-list --user=vagrant --ask-pass --become --limit=voltdbs playbook.yml

ansible-playbook --inventory-file=hosts-list --user=vagrant --ask-pass --become --limit=voltdbs init-cluster.yml


