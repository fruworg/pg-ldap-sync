# Использование разрешений LDAP в PostgreSQL

* http://github.com/larskanis/pg-ldap-sync

## ОПИСАНИЕ:

LDAP часто используется для централизованного управления пользователями и ролями в корпоративной среде.
PostgreSQL предлагает различные методы аутентификации, такие как LDAP, SSPI, GSSAPI или SSL.
Однако при любом методе пользователь должен уже существовать в базе данных, прежде чем аутентификация может быть использована.
В настоящее время не существует прямой авторизации пользователей базы данных по LDAP.
Поэтому роли и членство приходится администрировать дважды.

Данная программа позволяет решить эту проблему путем синхронизации пользователей, групп и их членства из LDAP в PostgreSQL.
Доступ к LDAP используется только для чтения.
Для синхронизации пользователей и групп `pg_ldap_sync` выдает соответствующие команды CREATE ROLE, DROP ROLE, GRANT и REVOKE.

Она предназначена для запуска в качестве cron-задания.

## FEATURES:

* Создание, удаление пользователей и групп, а также изменения в членстве синхронизируются из LDAP в PostgreSQL.
* Поддерживаются вложенные группы/роли
* Настраивается в конфигурационном файле YAML
* Возможность использования Active Directory в качестве LDAP-сервера
* Установка области видимости рассматриваемых пользователей/групп на стороне LDAP и PG
* Тестовый режим, не вносящий никаких изменений в СУБД
* Соединения между LDAP и PG могут быть защищены с помощью SSL/TLS
* NTLM и Kerberos аутентификация на LDAP-сервере

## ТРЕБОВАНИЯ:

* Ruby-2.0+
* LDAP-v3-сервер
* PostgreSQL-сервер v9.0+

## УСТАНОВКА:

Установить Ruby:

* под Windows: http://rubyinstaller.org
* на Debian/Ubuntu: `apt-get install ruby libpq-dev`.

Установите pg-ldap-sync и необходимые зависимости:
``sh
  gem install pg-ldap-sync
```

### Установка из Git:
``sh
  git clone https://github.com/fruworg/pg-ldap-sync.git
  cd pg-ldap-sync
  gem install bundler
  bundle install
  bundle exec rake install
```

## ИСПОЛЬЗОВАНИЕ:

Создать файл конфигурации на основе
[config/sample-config.yaml](https://github.com/fruworg/pg-ldap-sync/blob/master/config/sample-config.yaml)
или еще лучше
[config/sample-config2.yaml](https://github.com/fruworg/pg-ldap-sync/blob/master/config/sample-config2.yaml).

Запустить в тестовом режиме:
``sh
  pg_ldap_sync -c my_config.yaml -vv -t
```
Запуск в режиме модификации:
``sh
  pg_ldap_sync -c my_config.yaml -vv
```

Рекомендуется не предоставлять права синхронизируемым пользователям на сервере PostgreSQL, а предоставлять права группам.
Это связано с тем, что операторы `DROP USER`, вызываемые при уходе пользователя, в противном случае терпят неудачу из-за наличия зависимых объектов.
Оператор `DROP GROUP` также не работает при наличии зависимых объектов, но группы, как правило, более стабильны и удаляются редко.


## ТЕСТ:
В каталоге `test` находится небольшой тестовый набор, который работает с внутренним LDAP-сервером и сервером PostgreSQL. Убедитесь, что команды `pg_ctl`, `initdb` и `psql` находятся в `PATH` следующим образом:
``sh
  cd pg-ldap-sync
  установить пакет
  PATH=$PATH:/usr/lib/postgresql/10/bin/ bundle exec rake test
```

## ISSUES:

* В настоящее время нет возможности установить определенные атрибуты пользователя в PG на основе индивидуальных атрибутов в LDAP (срок действия и т.д.).


## Лицензия

Гем доступен с открытым исходным кодом на условиях [MIT License](https://opensource.org/licenses/MIT).
