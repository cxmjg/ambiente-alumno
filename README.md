Este repositorio esta destinado al desarrollo de un ambiente apto para un alumno de la carrera de Tecnicatura Superior en Desarrollo de Software
El objetivo es que el ambiente pueda ser utilizado para crear contenedores con un sistema operativo Linux Ubuntu XFCE completo, inmutable, con software instalado al momento de la creacion del contenedor
El ambiente contara con el siguiente software:
- python3
- vscodium
- eclipse ide
- jre y jdk
- libreoffice
- workbench (cliente mysql)
- mongofb compass
El Dockerfile utilizara la imagen de linuxserver.io Wentop con su variante ubuntu-xfce para optimizar recursos
El escritorio del ambiente podra ser accedido desde un Browser gracias a la implementacion de KasmVNC que permite acceder a un escritorio remoto via web browser sin necesidad de la instalacion de un cliente
