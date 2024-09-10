# MTA Server

## Features / Funcionalidades
### English
- #### Register system
  - Simple register interface
  - Verifies if user's pc has an account to avoid multi-account creation
  - Encrypts password using sha-256 for security
  - Autologin-in after a successfully register

- #### Log-in system
  - Simple log-in interface
  - When a player tries to log-in, validates if that account belongs to that PC to prevent account selling or theft
  - Load up all user information properly after log-in

- #### Bank system
  - Simple bank interface to deposits or withdrawals
  - All banking transactions are logged
  - In the future, depending on the card type, players will receive different discounts when purchasing items. However, I first need to implement a drugstore system or something similar.
  
- #### Admin system
  - List all active players
  - Displays detailed information about the selected player, such as current HP, money, location, and more.
  - Allows modification of the selected player's bank status, like creating a free account, removing it or adjusting the player’s balance.
  - Reconnects the selected to the server

- #### Database system
  - When someone disconnects, it saves player's information
  - When server is closing, it automatically saves all active players information before closing

### Español
- #### Sistema de registro
  - Tiene una interfaz simple
  - Valida si la pc que está usando el usuario no tenga una cuenta para evitar multicuentas
  - Encripta la contraseña usando sha-256 por seguridad
  - Conecta automaticamente al usuario luego de la creación de su cuenta

- #### Sistema de log-in
  - Tiene una interfaz simple
  - Cuando alguien intenta conectarse a una cuenta, valida si esa cuenta pertenece a esa PC para evitar venta o robo de cuentas
  - Carga la información del usuario correctamente luego del log-in

- #### Sistema bancario
  - Tiene una interfaz simple para depositar o extraer
  - Todas las transacciones se logean
  - A futuro agregaré un sistema que, dependiendo de qué tipo de tarjeta tengas, puedas obtener distintos descuentos cuando quieras comprar algo. Pero para eso primero tengo que implementar un sistema de kiosko o similar.

- #### Sistema de admin
  - Lista todos los jugadores actuales
  - Muestra información detallada del usuario seleccionado como su HP, dinero, localización, etcétera.
  - Permite la modificación de la situación bancaria del usuario seleccionado, desde crear o eliminar su cuenta hasta modificar su dinero depositado
  - Permite la reconección al servidor del usuario seleccionado

- #### Sistema de base de datos
  - Cuando alguien se desconecta, guarda toda su información
  - Cuando el servidor está por cerrarse, primero guarda toda la información de todos los usuarios activos

## Introduction / Introducción
### English
I started this client-server structure project in 2016 by myself with absolutely zero knowledge of programming but with a lot of curiosity. By reading a lot from the wiki (https://wiki.multitheftauto.com/wiki/Main_Page), the forums (https://forum.multitheftauto.com/), and watching some videos, I was able to take my first steps into the world of programming. For various reasons, I’ve often left it aside for a while, but I come back to it from time to time to improve the code (based on what I’m currently learning in university or my jobs).

This is a project that I’m very fond of due to how long it has been around, and I would like to keep evolving it in the future.

It is mainly built with LUA but also uses SQL to ensure the persistence, easy visualization, and modification of the data.

### Español
Arranqué este proyecto de estructura cliente-servidor en 2016 por mí mismo con un completo nulo conocimiento en programación pero con mucha curiosidad. Leyendo mucho de la wiki (https://wiki.multitheftauto.com/wiki/Main_Page), los foros (https://forum.multitheftauto.com/) y viendo algunos videos, pude empezar a dar mis primeros pasos en el mundo de la programación. Por diversos motivos siempre lo terminé dejando un tiempo pero cada tanto vuelvo para mejorar los códigos (en base a lo que aprendo actualmente en la facultad o mis trabajos).

Es un proyecto al que le tengo mucho cariño por la antigüedad que tiene y que me gustaría seguir evolucionandolo a futuro.

Está hecho principalmente con LUA pero también tiene SQL para asegurar la permanencia, fácil visualización y modificación de la información.
