$(document).ready(function(){
    $(document).on('click', '.btnDelete', function(e){
        e.preventDefault();
        var idp = $(this).prev('.idp').val();
        confirmarEliminacion(idp);
    });

    function confirmarEliminacion(idp) {
        Swal.fire({
            title:'¿Estas seguro?',
            text:"¿Quieres sacar este producto del carrito?",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Si, eliminar',
            cancelButtonText: 'Cancelar'
        }).then((result) => {
            if (result.isConfirmed) {
                eliminar(idp);
            }
        });
    }

    function eliminar(idp){
        var url = "Controller?accion=Delete";
        $.ajax({
            type: 'POST',
            url: url,
            data: {idp: idp},
            success: function(response){
                Swal.fire(
                    '¡Eliminado!',
                    'El producto ha sido eliminado del carrito.',
                    'success'
                ).then(() => {
                    location.reload();
                });
            },
            error: function(xhr, status, error){
                Swal.fire(
                    'Error',
                    'No se pudo eliminar el producto del carrito.',
                    'error'
                );
                console.error("Error:", error);
            }
        });
    }
    
    $(document).on('change', '.Cantidad', function() {
        var idp = $(this).siblings('.idpro').val();
        var cantidad = $(this).val();
        var url = "Controller?accion=ActualizarCantidad";

        $.ajax({
            type: 'POST',
            url: url,
            data: { idpro: idp, Cantidad: cantidad },
            success: function(response) {
                // Aquí puedes manejar una respuesta exitosa, por ejemplo, mostrar un mensaje
                Swal.fire(
                    '¡Actualizado!',
                    'La cantidad del producto ha sido actualizada.',
                    'success'
                ).then(() => {
                    location.reload(); // Recarga la página si es necesario
                });
            },
            error: function(xhr, status, error) {
                Swal.fire(
                    'Error',
                    'No se pudo actualizar la cantidad del producto.',
                    'error'
                );
                console.error("Error:", error);
            }
        });
    });
});