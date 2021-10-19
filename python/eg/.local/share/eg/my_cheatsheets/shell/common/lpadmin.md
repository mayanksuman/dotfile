# lpadmin
		configure cups printers and classes

## Examples:

- Add ip address of an ipp-everywhere printer with security [-E -v]

	lpadmin -p {{printer_name}} -E -v ipp://{{printer_ip_address}}/ipp/print -m everywhere
