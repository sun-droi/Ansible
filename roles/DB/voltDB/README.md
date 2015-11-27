## Requirements

2台voltDB組成一個cluster，建議 128G RAM

## Role Variables

10.0.0.41
10.0.0.42

帳密 vagrant/vagrant


1. 控制主機要先裝好 ansible
	sudo apt-get update
	sudo apt-get install -y software-properties-common
	sudo apt-add-repository ppa:ansible/ansible
	sudo apt-get update
	sudo apt-get install -y ansible

2. 確認控制主機能 ssh 到被控制主機

3. 確認 host 檔 ip 資料已修改
	hosts-list
	data/roles/voltdb/files/host 
	

4. 修改 *.yml 裡的 host ip (改為上述其中一台的ip: 10.0.0.41)
	addnode.yml
	changenode.yml
	shutdownserver.yml
	startserver.yml
	init-cluster.yml

5. 修改 home dir 路徑
	addnode.yml
	changenode.yml
	startserver.yml
	init-cluster.yml
	playbook.yml

6. 修改 owner/group
	addnode.yml
	playbook.yml

7. 修改使用者名稱/密碼	
	deployment.xml
	startup.sh

8. 修改節點設定
	deployment.xml
	hostcount: 主機數
	sitesperhost: 每台主機切的 partition <- 越高越可以提升 throughput，看每台主機有幾個 core 就設幾個 partition


9. 修改時區
	addnode.yml
	playbook.yml

10. 修改 ntp server
	addnode.yml
	init-cluster.yml

9. 到控制主機執行 ./startup.sh

10. ssh 到上述其中一台 voltDB 主機
	$cd cluster-test
	$sqlcmd
	
	> select * from oz_role;
	應該會有資料表欄位出現，表示安裝完成
	但因為還沒有資料，所以是空的

## Service

11. 關閉 voltDB server
	ansible-playbook --inventory-file=hosts-list --user=vagrant --ask-pass --become --limit=voltdbs shutdownserver.yml

12. 啟動 voltDB server
	ansible-playbook --inventory-file=hosts-list --user=vagrant --ask-pass --become --limit=voltdbs startserver.yml

13. 增加節點
	先關閉 voltDB server
	調整 hosts-list, host 參數
deployment.xml
	ansible-playbook --inventory-file=hosts-list --user=vagrant --ask-pass --become --limit=voltdbs addnode.yml
	啟動 voltDB server

14. 減少節點
	先關閉 voltDB server
	調整 hosts-list, host 參數
	ansible-playbook --inventory-file=hosts-list --user=vagrant --ask-pass --become --limit=voltdbs changenode.yml
	啟動 voltDB server

15. 重新啟動 voltDB server
	ansible-playbook --inventory-file=hosts-list --user=vagrant --ask-pass --become --limit=voltdbs db-service.yml
	
## Example Playbook

    - hosts: dbservers
      roles:
        - { role:  }


## License

MIT / BSD

