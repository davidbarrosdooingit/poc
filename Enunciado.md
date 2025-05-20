## Enunciado del Laboratorio: Ejercicios de Phishing y Captura de Credenciales

### Introducción

En este laboratorio asumirás el rol de un atacante para comprender en la práctica cómo funcionan dos técnicas de phishing empleadas habitualmente. El objetivo es mostrarte el proceso completo de diseño, ejecución y captura de información de una víctima simulada, con fines estrictamente educativos.

El laboratorio consta de dos ejercicios independientes, que deberás abordar de forma secuencial. Todos los pasos se realizarán en tu máquina Linux, donde ya tienes instaladas y configuradas las siguientes herramientas:

- **MailHog** en `http://localhost:8025`

- **Servidor SMTP** de **Mailhog**: `http://localhost:1025`

- **EvilGophish** en `http://localhost:3333`

- **Evilngix3** dentro de la carpeta "evilgophish" como usuario root ejecutaremos : `./evilginx3/build/evilginx -g gophish/gophish.db -p evilginx3/legacy_phishlets/ --feed --developer`

- El usuario y la contraseña predeterminados para iniciar sesión en todos los servicios es:

  -  Usuario:  `admin` 

  -  Contraseña:  `abc123..`

La máquina Windows10 será nuestro cliente o victima, las credenciales son las mismas que las de la máquina linux.

### Ejercicio 1: Phishing mediante correo con malware camuflado

**Objetivo**
 Enviar un correo que contenga un archivo ZIP diseñado para parecer una actualización de Office. Al descomprimir y ejecutar el instalador falso, la víctima establecerá una reverse shell hacia tu máquina atacante.

**Instrucciones**

1. Prepara un archivo ZIP que incluya:

   - Un instalador de Office falso (por ejemplo, un ejecutable con nombre parecido a “LibreOffice_25.2.1_Win_x86-64.msi”) y un activador de office (esto será un script malicioso que indicamo luego como se creará). Lo podemos descargar de la web oficial ([Download LibreOffice | LibreOffice - Free and private office suite - Based on OpenOffice - Compatible with Microsoft](https://www.libreoffice.org/download/download-libreoffice/)).

   - Para crear el "activador" lo que haremos será:

     - Descargaremos un bypass de AMSI (podemos utilizar github para buscar alguno que funcione).

     - Una vez vemos que el bypass funcione deberemos crear un archivo ".ps1" que ejecute una reverse shell hacia nuestra máquina linux. Para esto podemos ayudarnos de páginas como https://revshells.com/ o incluso utilizar ChatGPT.

     - Luego integraremos el bypass de AMSI previo con el script para lanzar la reverse shell.

     - Por ultimo renombraremos el archivo como "activador.ps1"

       [^Nota]: Podemos realizar todo esto en la máquina victima Windows 10 antes de crearlo en la atacante Linux, de esta forma nos aseguramos de que todo funciona correctamente y nos facilitará la gestión.

       

2. Utilizando EvilGophish crearemos un correo creíble dirigido a nuestro “cliente” indicando que su licencia de Office ha sido renovada y que debe instalar la actualización.

3. Utilizaremos MailHog para enviar el correo desde nuestro entorno de pruebas.

4. Una vez enviemos el correo deberemos poner nuestra máquina atacante linux al a escucha por el puerto que indiquemos la reverse shell (normalmente se utiliza el 4444)

5. Luego de esto simularemos que somos el cliente y realizaremos los pasos del correo (descargaremos el zip y ejecutaremos el bypass)

6. Escucharemos la conexión inversa en nuestra máquina atacante y verificaremos que obtenemos la shell en el sistema objetivo.

**Herramientas**

- MailHog (`localhost:8025`)
- Netcat o herramienta equivalente para reverse shell
- Script o binario para bypass de AMSI

### Ejercicio 2: Captura de credenciales con phishing de página de inicio de sesión

**Objetivo**
 Diseñar y lanzar una campaña de phishing que suplante la página de inicio de sesión de Microsoft 365. El objetivo es capturar el nombre de usuario, la contraseña y el token de sesión de la víctima.

**Instrucciones**

1. Lo primero que deberemos hacer es configurar el dominio que queremos utilizar con el comando config `config domain midominio`
2. En EvilGophish, crearemos un nuevo “phishlet” o adaptaremos uno existente para replicar la pantalla de login de Microsoft. Podemos utilizar la ayuda del propio evilgophish con `help phishlets `
3. Configuraremos una campaña en EvilGophish que incluya:
   - Un correo que informe al usuario de que su cuenta ha sido comprometida.
   - Un enlace al servidor de phishing local.
4. Para la creación de nuestro enlace malicioso utilizaremos los lures de evilgnix3. Para la creación de un lure podemos ayudarnos de la documentación sobre esto de evilgnix3. `lures help`
5. Envía la campaña usando MailHog (de nuevo, en `localhost:8025`).
6. Cuando la víctima introduzca sus credenciales, revisa en EvilGophish los registros y exporta:
   - Nombre de usuario
   - Contraseña
   - Token de sesión (si está disponible)

**Notas**

- Este segundo ejercicio es más complejo y probablemente requiera continuar fuera del horario de laboratorio.
- Documenta cada paso: capturas de pantalla, configuración de phishlet, registros de credenciales, etc.

### Recordatorio

- Recuerda que este entorno es controlado y de uso exclusivo para prácticas; no reproduzcas estos ataques fuera de él.
