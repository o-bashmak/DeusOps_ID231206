Light:
  - Vagrantfile - запуск VM и настройки согласна зачадам

Normal:
  - Написать Dockerfile для приложения, установить на web01 Докер и запустить приложение в контейнере. Убедиться, что всё работает так, как настраивали на уровне Light:
      - установка Докера - install_Docker_Ubuntu.sh
      - Dockerfile для приложения - Dockerfile
  - Написать gitlab-ci pipline для автоматической сборки и публикации Докер-образа с приложением:
      - .gitlab-ci.yml
  - Написать ansible-playbook настраивающий сервера web01 и file01:
      - сразу по ролям
  - Написать ansible-роль "nfs", для установки nfs-сервера и nfs-клиента. Придумать как разделять Server и Client на уровне ролей и уровне inventory-host-file,
  - Написать ansible-роль "nginx", для установки nginx и темплейт для конфигурации proxy на localhost,
  - Написать ansible-роль "docker", для установки docker и темплейт для запуска docker-compose с нужным нам приложением:
      - .\roles\nfs
      - .\roles\nginx
      - .\roles\docker
  - Добавить в gitlb-ci шаг с деплоем приложения на сервера. Ansible-роли должны находиться в отдельных репозиториях и работать через galaxy
      - o-bashmak.id231206_ansible_nfs_role
			- o-bashmak.id231206_ansible_docker_role
			- o-bashmak.id231206_ansible_nginx_role
