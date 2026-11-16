# phpes-org.github.io

Página do PHP Espírito Santo — https://www.phpes.org

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

## Rodando localmente (opcional)

```sh
bundle install
bundle exec jekyll serve
```

O site fica disponível em http://localhost:4000.
