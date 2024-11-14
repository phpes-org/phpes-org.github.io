---
title: PHP-FFMpeg
author:
    name: Rogério Lino
    link: https://github.com/rogeriolino
tags:
    - php
    - ffmpeg
    - avconv

---

[PHP-FFMpeg](https://github.com/PHP-FFMpeg/PHP-FFMpeg) é um projeto que representa de forma orientada a objetos (OOP) a biblioteca ffmpeg/avconv, facilitando a manipulação de arquivos de áudio e vídeo.

>This library requires a working FFMpeg install. You will need both FFMpeg and FFProbe binaries to use it. Be sure that these binaries can be located with system PATH to get the benefit of the binary detection, otherwise you should have to explicitely give the binaries path on load.


Exemplo:

```
$ffmpeg = FFMpeg\FFMpeg::create();
$video = $ffmpeg->open('video.mpg');
$video
    ->filters()
    ->resize(new FFMpeg\Coordinate\Dimension(320, 240))
    ->synchronize();
$video
    ->frame(FFMpeg\Coordinate\TimeCode::fromSeconds(10))
    ->save('frame.jpg');
$video
    ->save(new FFMpeg\Format\Video\X264(), 'export-x264.mp4')
    ->save(new FFMpeg\Format\Video\WMV(), 'export-wmv.wmv')
    ->save(new FFMpeg\Format\Video\WebM(), 'export-webm.webm');
```
