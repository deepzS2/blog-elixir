# Blog API com Elixir
Uma API desenvolvida em Elixir com objetivo de imitar um website de blogs onde usuários terão seus posts e suas respectivas contas.

## Instalando
Para rodar este projeto você precisará das seguintes dependências no seu sistema
- [Elixir](https://elixir-lang.org/install.html)
- [Phoenix](https://hexdocs.pm/phoenix/installation.html)

E para começar, é só rodar os seguintes comandos no terminal:
```bash
mix deps.get # Baixar as dependências que estão no arquivo mix.exs
mix ecto.create # Cria o banco de dados gerando um arquivo .db (sqlite)
mix ecto.migrate # Roda as migrations na pasta priv/repo/migrations
mix phx.server # Roda a aplicação 
```

## Testando rotas
Você pode executar as requisições HTTP no arquivo de [testes](./test.http) onde foi utilizado uma [extensão do vscode](https://marketplace.visualstudio.com/items?itemName=humao.rest-client) para tal.

## TODOs
- [x] Migration e controller de posts;
- [x] Criar as relações entre posts e users;
- [x] Comentários em partes do código onde pode ser de difícil entendimento;
- [x] Migration e controller de comentários em posts;
