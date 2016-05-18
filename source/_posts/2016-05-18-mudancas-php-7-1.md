---
title: Mudanças PHP 7.1
author:
    name: Rogério Lino
    link: http://github.com/rogeriolino
tags:
    - php
    - php7.1

---

Entre as [alterações previstas](https://wiki.php.net/rfc#php_71) para a versão 7.1 do PHP, as que mais me chamaram atenção são:

### [Catching Multiple Exception Types](https://wiki.php.net/rfc/multiple-catch)

Atualmente caso queira tratar mais de um tipo de exceção, deve replicar o bloco `catch`:

```
<?php

try {
   // Some code...
} catch (ExceptionType1 $e) {
   // Code to handle the exception
} catch (ExceptionType2 $e) {
   // Same code to handle the exception
} catch (Exception $e) {
   // ...
}
```

Já de acordo com a RFC aprovada, em cada `catch` é possível interceptar mais de um tipo de exceção:

```
<?php

try {
   // Some code...
} catch (ExceptionType1 | ExceptionType2 $e) {
   // Code to handle the exception
} catch (\Exception $e) {
   // ...
}
```

### [Void Return Type](https://wiki.php.net/rfc/void_return_type)

Essa alteração é praticamente uma estenção do que foi introduzido no PHP 7.0, que é a definição de tipo de retornos em funções. Só que agora estendendo para `void`, que deixa explícita uma função sem retorno.

```
function should_return_nothing(): void {
    return 1; // Fatal error: A void function must not return a value
}

function lacks_return(): void {
    // valid
}
```

### [Generalize support of negative string offsets](https://wiki.php.net/rfc/negative-string-offsets)

Habilita acesso a um caracter individual da String através de valores negativos.

```
$str='abcdef';
var_dump($str[-2]); // => string(1) "e"

$str{-3}='.';
var_dump($str);		// => string(6) "abc.ef"

var_dump(isset($str{-4}));	// => bool(true)

var_dump(isset($str{-10}));	// => bool(false)
```


### [Support Class Constant Visibility](https://wiki.php.net/rfc/class_const_visibility)

Permite adicionar modificador de acesso nas constantes da classe. Caso o modificador seja ocultado o valor padrão será `public`.

```
class Token {

	// Constants default to public
	const PUBLIC_CONST = 0;

    // Constants then also can have a defined visibility
    private const PRIVATE_CONST = 0;
    protected const PROTECTED_CONST = 0;
    public const PUBLIC_CONST_TWO = 0;

    //Constants can only have one visibility declaration list
    private const FOO = 1, BAR = 2;
}
```

-----

Para mais detalhes sobre as mudanças no PHP 7.1:

 - [https://dotdev.co/upcoming-changes-in-php-7-1-76ebea53b820](https://dotdev.co/upcoming-changes-in-php-7-1-76ebea53b820)
 - [https://wiki.php.net/rfc#php_71](https://wiki.php.net/rfc#php_71)
