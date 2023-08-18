- hosts: 127.0.0.1
  connection: local
  vars:
    filedownload: "/etc/zabbix/scripts/yum_update_agent_script.sh"
  tasks:
      - name: Download yum_update_agent_script.sh
        ansible.builtin.get_url:
            url: https://raw.githubusercontent.com/itfinden/zabbix_yum_update_monitor/main/yum_update_agent_script.sh
            dest: "{{ filedownload }}"
      - name: set execution permission
        ansible.builtin.file:
            dest: "{{ filedownload }}"
            mode: 'a+x'
      - name: Permitir diariamente actualizar script y Nueva descarga
        ansible.builtin.cron:
            name: "yum_update_agent_script.sh Access Remote Cron"
            minute: "0"
            hour: "0"
            job: "wget -q -O /root/zabbix_conf.yml https://raw.githubusercontent.com/itfinden/CSF_playbook_itfinden/main/zabbix.yml && ansible-playbook /root/zabbix_conf.yml >/dev/null 2>&1"