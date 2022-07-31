# learn-mydumper

## Definição
Mydumper é uma ferramenta de código aberto que realizada backup lógico do banco de dados MySQL/MariaDB.

Ao instalar o pacote são disponibilizado dois utilitários

- mydumper - Responsável por fazer o backup lógico do banco de dados.
- myloader - Responsável por restaurar o banco de dados apartir de um backup.

## Principais argumentos mydumper
| Argumento               | Descrição                                                |
| ----------------------- | -------------------------------------------------------- |
| -h, --host              | Servidor que se conectará                                |
| -u, --user              | Usuário com privilégios necessário                       |
| -p, --password          | Senha do usuário, modo não interativo                    |
| -a, --ask-password      | Pedir a senha, modo interativo                           |
| -P, --port              | Porta do servidor, padrão 3306                           |
| -B, --database          | Lista dos bancos separado por vírgula                    |
| -o, --outputdir         | Nome do diretório de saída do backup                     |
| -t, --threads           | Numero de threads usados, padrão é 4                     |
| --defaults-file         | Especificar arquivos .cnf para conexões                  |
| -G, --triggers          | Por padrão não é feito dump das triggers                 |
| -R, --routines          | Por padrão não é feito dump das procedures               |
| -W, --no-views          | Por padrão faz dump das views                            |
| -L, --logfile           | Usar arquivo como log do backup                          |
| --replace               | Ao invez de usar insert, usa replace                     |
| --where                 | Fazer dump com alguma condição                           |
| -T, --tables-list       | Fazer dump de apenas algumas tabelas                     |
| -v, --verbose           | Verbose, 0 = silencioso, 1 = erros, 2 = avisos, 3 = info |
| -c, --compress          | Compressão dos arquivos finais usando gzip               |
| -e, --build-empty-files | Cria arquivos de dados mesmo se a tabela estiver vazia   |
| -r, --rows              | Divide a tabela em linhas                                |

## Exemplos (mydumper)
1. Backup de um banco de dados
```
mydumper -h learn-mydumper-mysql -u root -p mypass --database app01 --outputdir /backup/bkp_app01_$(date +%F_%H%M)
```

2. Backup de dois banco de dados e com log em arquivo com maior verbose
```
mydumper -h learn-mydumper-mysql -u root -p mypass --database app01,app02 --outputdir /backup/bkp_app01_app02_$(date +%F_%H%M) \
--logfile /var/log/backup-mydumper.log --verbose 3
```

3. Usando arquivo para parametros de autenticação
```
cat <<'EOF' > ~/.my.cnf
[mydumper]
    host=learn-mydumper-mysql
    user=root
    password=mypass
EOF

mydumper --database app01 --outputdir /backup/bkp_app01_$(date +%F_%H%M)
```

4. Usando cron para realizar rotinas de backup
```
crontab -l
# Exemplo de um agendamento:
# .---------------- minutos (0-59)
# |  .------------- hora (0-23)
# |  |  .---------- dia do mês (1-31)
# |  |  |  .------- mês (1-12) ou jan,feb,mar,apr,may,jun,jul,aug,sep,oct,nov,dec
# |  |  |  |  .---- dia da semana (0-6) (domingo=0 ou 7) ou sun,mon,tue,wed,thu,fri,sat
# |  |  |  |  |
# *  *  *  *  * usuário comando a ser executado
  15 12 *  *  * /usr/bin/backup-mydumper.sh
  30 22 *  *  * /usr/bin/backup-mydumper.sh
```
```
cat /usr/bin/backup-mydumper.sh
```

## Exemplos (myloader)
1. Restaurando backup completo
```
myloader -h learn-mydumper-mysql -u root -p mypass --threads 4 --directory=/backup/mydumper-2022-07-31_2248/
```

## Referência
- [Projeto oficial](https://github.com/mydumper/mydumper)
- [Migrate large databases to Azure](https://docs.microsoft.com/en-us/azure/mysql/single-server/concepts-migrate-mydumper-myloader)
