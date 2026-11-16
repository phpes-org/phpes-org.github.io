# phpes-org.github.io

Página do PHP Espírito Santo — <https://www.phpes.org>

O site é gerado com [Jekyll](https://jekyllrb.com/) pelo build padrão do GitHub Pages
a partir da branch `master`. Não é preciso gerar nada localmente para publicar.

## Contribuindo

- Faça um clone do repositório
- Escreva o post em markdown e salve em `_posts/` seguindo o formato `Y-m-d-slug-do-post.md`
- Envie as alterações para a `master` (commit/push ou pull request). O GitHub Pages publica automaticamente.

Formato do front matter:

```yaml
---
title: Título do post
author:
    name: Seu Nome
    link: https://github.com/seu-usuario
tags:
    - php
---
```

## Validação (CI)

Cada push na `master` e cada pull request executam o workflow [Lint](.github/workflows/lint.yml), que:

1. valida os posts (`script/validate-posts.rb`): nome do arquivo `AAAA-MM-DD-slug.md`, data válida e não futura, slug único, e front matter com `title`, `author.name`, `author.link` e `tags`;
2. faz o build do Jekyll com as mesmas versões do GitHub Pages;
3. verifica links internos e imagens do site gerado (html-proofer).
4. verifica o estilo do Markdown com o [markdownlint](https://github.com/DavidAnson/markdownlint-cli2) (regras em `.markdownlint-cli2.jsonc`).

Para validar os posts antes de enviar:

```sh
ruby script/validate-posts.rb
npx markdownlint-cli2          # use --fix para corrigir automaticamente
```

## Rodando localmente (opcional)

A lista de membros na barra lateral usa a API do GitHub, então é preciso um token:

```sh
bundle install
JEKYLL_GITHUB_TOKEN=$(gh auth token) bundle exec jekyll serve
```

Ou, sem instalar Ruby, usando um container:

```sh
docker run --rm -p 4000:4000 -e JEKYLL_GITHUB_TOKEN="$(gh auth token)" \
  -v "$PWD":/srv/site -w /srv/site ruby:3.3 \
  bash -c 'bundle install && bundle exec jekyll serve --host 0.0.0.0 --force_polling'
```

O site fica disponível em <http://localhost:4000>.
