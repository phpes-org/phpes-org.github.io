---
title: PPM - PHP Process Manager
author:
    name: Rogério Lino
    link: https://github.com/rogeriolino
tags:
    - php
    - php-pm
    - ppm
    - http
    - server
    - load-balancer
---

PHP-PM é um gerenciador de processo, supercharger e load balancer para aplicações PHP que chega a ser 15 vezes mais rápidos do uma aplicação PHP tradicional.

>It's based on ReactPHP and works best with applications that use request-response frameworks like Symfony's HTTPKernel. The approach of this is to kill the expensive bootstrap of PHP (declaring symbols, loading/parsing files) and the bootstrap of feature-rich frameworks. See Performance section for a quick hint. PHP-PM basically spawns several PHP instances as worker bootstraping your application (eg. the whole Symfony Kernel) and hold it in the memory to be prepared for every incoming request: This is why PHP-PM makes your application so fast.

Repositório do projeto: [https://github.com/php-pm/php-pm](https://github.com/php-pm/php-pm)
