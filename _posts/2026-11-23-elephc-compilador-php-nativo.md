---
title: "elephc: compilando PHP para binário nativo"
author:
    name: Rogério Lino
    link: https://github.com/rogeriolino
tags:
    - php
    - elephc
    - compilador
---

[elephc](https://elephc.dev/) é um compilador que transforma PHP em executáveis nativos. Escrito em Rust e mantido pela Illegal Studio (Vincenzo Petrucci e Guillaume Loulier), ele compila um subconjunto estático do PHP direto para assembly, gerando um binário independente: sem máquina virtual e sem precisar do PHP instalado para rodar.

O projeto é open source (licença MIT) e ainda experimental. A versão mais recente é a 0.27.9, lançada em 20 de novembro.

### O que já funciona

Boa parte do PHP moderno já é suportada:

- Classes, interfaces, traits, enums, `readonly`, classes abstratas e finais, promoção de propriedades no construtor;
- Atributos, argumentos nomeados, first-class callables, closures e generators;
- Tipos em parâmetros e retornos, union types e nullable;
- Namespaces, includes e autoload do Composer resolvido em tempo de compilação;
- `Fiber`, PDO (SQLite, PostgreSQL, MySQL/MariaDB) e funções de imagem no estilo GD.

Os alvos suportados são macOS ARM64, Linux ARM64 e Linux x86_64.

### Instalação

Pelo Homebrew:

```sh
brew install illegalstudio/tap/elephc
```

Ou pelo gerenciador de versões oficial, o elvm:

```sh
curl -fsSL https://get.elephc.dev | sh
elvm install latest
elvm use latest --global
```

### Hello world

```php
<?php
echo "Hello, World!\n";
```

```sh
elephc build hello.php
./hello
```

### Além do PHP

O elephc adiciona algumas extensões à linguagem para código de sistemas e de alto desempenho: `packed class` para registros com layout de memória fixo, `buffer<T>` para arrays tipados contíguos, `ptr` para acesso direto à memória e `extern` para chamar funções C (FFI):

```php
<?php
extern function atoi(string $s): i32;

echo atoi("999") . "\n";
```

Para mostrar até onde dá para ir, o projeto tem um port do [DOOM](https://github.com/getelephc/doom) feito com elephc, usando SDL2 via FFI, `packed class` e `buffer<T>`.

### Limitações

Os próprios autores avisam que o projeto é experimental, que nem tudo do PHP está implementado e que bugs são esperados. Ele ainda não substitui o PHP tradicional para rodar um framework dinâmico completo. O foco está em ferramentas de linha de comando, scripts e código onde desempenho importa.

Documentação: [https://elephc.dev/](https://elephc.dev/)

Código-fonte: [https://github.com/illegalstudio/elephc](https://github.com/illegalstudio/elephc)
