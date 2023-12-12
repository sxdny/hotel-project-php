# Reservas

Toda la información sobre las reservas, facturas, etc.

## Secuencia

Secuencia:
1. Reservar (done)
2. Check-In
3. Check-Out
4. Emisión de la factura.

Alternativas:
- Cancelado.
- No disponible.

### ¿Cómo?

En la página de editar reservas, seleccionaremos la reserva del cliente y actualizaremos el estado de esta.

### Check-In

El proceso de Check-In será manual. Cuando el cliente llegue al hotel, el recepcionista preguntará los datos del cliente y cambiará el estado a la reserva a **Check-In**.

### Check-Out

El proceso de Check-Out también será manual. Cuando los dias de la reseva hayan llegado a su fin y el cliente haya devuelto la llave de acceso a la llave, el recepcionista cambiará el estado de la reserva a **Check-Out.**

### Emisión de la factura.

Antes de emitir la factura al cliente, tendremos que tener en cuenta lo siguiente:

- Contar los dias que ha estado hospedado en la habitación (po si se han añadido dias)
- Contar los extras (más adelante)

**¿Donde?**

Cuando el recepcionista le de Check-Out, aparecerá una página para realizar el pago (se imprimirá también un archivo con todos los datos). El cliente después lo paga y esta se para a un historial de factura (para las estadísticas)

**¿Cómo hacerlo?**

### Cancelar reserva

Tener en cuenta todo esto:

- Un cliente podrá cancelar su reserva siempre y cuando esta no esté en el límite (no la puede cancelar el mismo dia)
- Al cancelar la reserva, esta **no se elimina**, sino que pasa a un estado de **Cancelada**. Cuando la reserva cancelada llegue a su fin, esta se tendrá que borrar (para no consumir espacio en la base de datos)

Hacer una función de SQL que se encarge de calcular todos estos datos para después hacer la query desde PHP.

Código:

```sql
SELECT * FROM tables WHERE id = 1;
```

---

No es lo mismo eliminar que ocultar (reservas)

