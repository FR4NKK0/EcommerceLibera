<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="entities.*" %>
<%@ page import="java.util.*" %>
<%@ page import="data.*" %>
<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" integrity="sha384-k6RqeWeci5ZR/Lv4MR0sA0FfDOMm2JgX/aTk5lZeg6MOc1pYNeZTk5cBz6QeV6y" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" href="style/bulma.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"> 
<meta charset="ISO-8859-1">
<title>Resumen de Compra</title>
<style>
        .container {
            margin-top: 2rem;
        }
        .form-section {
            background-color: #f5f5f5;
            padding: 2rem;
            border-radius: 5px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }
        .field label {
            font-weight: bold;
        }
        .mt-4 {
    	margin-right: 7rem; /* Puedes ajustar este valor según sea necesario */
		}
		.file-cta {
        background-color: #ffdd57 !important;
        color: rgba(0, 0, 0, 0.7) !important;
        border: none !important;
    }

    .file-name {
        border-color: #ffdd57 !important;
        border-width: 1px !important;
        border-style: solid !important;
        border-left: none !important;
    }

    .file-label {
        width: 100%;
    }

    .file-input:focus + .file-cta {
        border-color: #3273dc;
        box-shadow: 0 0 0 0.125em rgba(50, 115, 220, 0.25);
    }
    </style>
</head>
<body>

	<section class="section">
	            <div class="container">
	                <div class="box">
	                    <h2 class="title is-4 has-text-centered">Libera S.A.</h2>  
	                    <h4 class="subtitle is-6 has-text-centered">Membrives 8947</h4>  
	                    <h5 class="has-text-centered">Cel. +54 9 341 378-9010</h5>  
	                    <div class="table-container">
	            <% 
	                List<DetalleCompra> detalles = (List<DetalleCompra>) request.getAttribute("myDetalle");
	                DataProducto dp = new DataProducto();
	                if (detalles != null && !detalles.isEmpty()) {
	            %>            
	                <table class="table is-fullwidth is-striped is-hoverable">
	                    <thead>
	                        <tr>
	                            <th>ID</th>
	                            <th>Producto</th>
	                            <th>Cantidad</th>
	                            <th>Precio Unitario</th>
	                            <th>Subtotal</th>
	                        </tr>
	                    </thead>
	                    <tbody>
	                        <% 
	                            double total = 0;
	                            for (DetalleCompra detalle : detalles) {
	                                Producto producto = dp.getById(detalle.getIdproducto());
	                                total += detalle.getCantidad() * detalle.getPrecioCompra();
	                        %>
	                            <tr>
	                                <td><%= detalle.getId() %></td>
	                                <td>
	                                    <div class="columns is-vcentered">
	                                    	<figure class="image is-64x64">
	                                        	<img src="ControllerImg?id=<%= producto.getId() %>" alt="<%= producto.getNombre() %>" style="max-width: 100px;">
	                                        </figure>
	                                        <div class="column">
	                                            <%= producto.getNombre() %>
	                                        </div>
	                                    </div>
	                                </td>
	                                <td><%= detalle.getCantidad() %></td>
	                                <td>$<%= String.format("%.2f", detalle.getPrecioCompra()) %></td>
	                                <td>$<%= String.format("%.2f", detalle.getCantidad() * detalle.getPrecioCompra()) %></td>
	                            </tr>
	                        <% } %>
	                    </tbody>
	                    <tfoot>
	                        <tr>
	                            <th colspan="4" class="has-text-right">Total:</th>
	                            <th>$<%= String.format("%.2f", total) %></th>
	                        </tr>
	                    </tfoot>
	                </table>
	            <% } else { %>
	                <div class="notification is-warning">
	                    No se encontraron detalles para esta compra.
	                </div>
	            <% } %>
	            
	            <div class="buttons">
                <a href="Controller?accion=ListarCatalogo" class="button is-primary">
                    <span class="icon">
                        <i class="fas fa-arrow-left"></i>
                    </span>
                    <span>Salir</span>
                </a>
            </div>
	        </div>
	    </div>
	    </div>
    </section>

</body>
</html>