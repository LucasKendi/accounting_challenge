# Account movement challenge

Esse repositório é um desafio de gestão financeira.

Seu objetivo é executar a criação de contas  e transferências entre elas através de uma requisição http autenticada.
## Tecnologias

Tecnologias utilizadas no projeto:
 - ruby (2.6.3)
 - rails (6.0.3.1)
 - mysql (14.14)

Gems adicionais:
 - Rspec (3.10.0.pre) - Garantir a confiabilidade do código
 - Rubocop (0.84) - Garantir a qualidade do código
 - Factory Bot (5.2.0) - Auxiliar na criação de testes


## Instalação
Clone o projeto:
```bash
$ git clone https://github.com/LucasKendi/accounting_challenge.git
```
Execute o bundle:
```bash
$ bundle
```
Execute as migrações:
```bash
$ rails db:create
$ rails db:migrate
```

Caso seja necessário, altere o password do arquivo `database.yml` para o seu password do usuário root no mysql

## Uso

### Criar conta
Acessar a rota `/api/v1/accounts/` com um POST passando os parâmetros `name`, `balance` e opcionalmente o `id` com seus respectivos valores

A aplicação irá retornar o token e o id associados à conta caso a requisição tenha sido feita corretamente

### Consultar saldo
Acessar a rota `/api/v1/accounts/id` com um GET, onde o `id` e o id da conta que deseja-se consultar. É necessário também passar o token no header como autorização

A aplicação deve retornar o saldo da conta associada ao id

### Tranferência
Acessar a rota `/api/v1/transfer` com um POST, passando os parâmetros `source_account_id` com o id da conta de origem do dinheiro, `destination_account_id` com o id da conta de destino do dinheiro e `amount` com o valor que deseja transferir em centavos (Ex: R$50,00 será passado como 5000). Também é necessário passar o token de autorização

Caso uma das contas não exista ou a conta de origem não tenha saldo suficiente, a transação é cancelada e a aplicação avisa qual erro foi encontrado.

## Testes

Para garantir a qualidade do projeto, foram desenvolvidos uma série de testes que podem ser executados com:
```bash
$ bundle exec rspec
```

## Licensa
[MIT](https://choosealicense.com/licenses/mit/)