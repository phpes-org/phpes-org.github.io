---
title: "Marko: o framework PHP modular"
author:
    name: Rogério Lino
    link: https://github.com/rogeriolino
tags:
    - php
    - marko
    - framework
---

[Marko](https://marko.build/) é um framework PHP modular, criado por Mark Shust, que se propõe a combinar a extensibilidade do Magento com a experiência de desenvolvimento do Laravel. Requer **PHP 8.5+** e ainda está em estágio inicial, com código aberto.

Principais conceitos:

- **Tudo é um módulo**: cada funcionalidade (rotas, cache, autenticação, a própria aplicação) é um pacote Composer. Os módulos são carregados de `app/`, `modules/` e `vendor/`, nessa ordem de prioridade.
- **Interface separada da implementação**: por exemplo, `marko/cache` define a interface e `marko/cache-file` ou `marko/cache-redis` a implementam.
- **Injeção de dependência** configurada em PHP puro (`module.php`), sem XML nem YAML.
- **Extensibilidade por atributos**: `#[Preference]` para substituir uma classe, `#[Plugin]` com `#[Before]`/`#[After]` para interceptar métodos, e `#[Observer]` para eventos.
- **Erros explícitos**: cada erro informa o que aconteceu, o contexto e uma sugestão de correção.

### Instalação

```sh
composer create-project marko/skeleton my-app
cd my-app
```

### Exemplo

As rotas são declaradas com atributos nos métodos do controller, e os parâmetros da URL são injetados pelo nome:

```php
<?php

declare(strict_types=1);

use Marko\Routing\Attributes\Get;
use Marko\Routing\Http\Response;

class PostController
{
    #[Get('/posts/{id}')]
    public function show(int $id): Response
    {
        return Response::json(data: ['id' => $id]);
    }
}
```

O `module.php` de um módulo liga interfaces às implementações:

```php
<?php

declare(strict_types=1);

use App\Blog\Repository\PostRepository;
use App\Blog\Repository\PostRepositoryInterface;

return [
    'bindings' => [
        PostRepositoryInterface::class => PostRepository::class,
    ],
    'singletons' => [
        PostRepository::class,
    ],
];
```

E para trocar a implementação de uma classe de outro módulo, basta um atributo:

```php
#[Preference(replaces: FlatRate::class)]
class ZoneShipping extends FlatRate
{
    // ...
}
```

Mais detalhes na documentação oficial: [https://marko.build/docs](https://marko.build/docs)

Código-fonte: [https://github.com/markshust/marko](https://github.com/markshust/marko)
