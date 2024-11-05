<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="entities.*" %><%@ page import="data.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Carrito de compras</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" integrity="sha384-k6RqeWeci5ZR/Lv4MR0sA0FfDOMm2JgX/aTk5lZeg6MOc1pYNeZTk5cBz6QeV6y" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" href="style/bulma.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">    
    <style>
        .product-image {
            width: 100px;
            height: 100px;
            object-fit: cover;
        }
        .table td {
            vertical-align: middle;
        }
    </style>
</head>
<body>
   <nav class="navbar has-shadow is-spaced is-warning" role="navigation" aria-label="main navigation">
        <div class="navbar-brand">
            <a class="navbar-item" href="Controller?accion=ListarCatalogo">
                <img src="style/iconcarrito.png" alt="Home" class="logo-image">
            </a>
            <a role="button" class="navbar-burger" aria-label="menu" aria-expanded="false" data-target="navbarBasicExample">
                <span aria-hidden="true"></span>
                <span aria-hidden="true"></span>
                <span aria-hidden="true"></span>
            </a>
        </div>

        <div id="navbarBasicExample" class="navbar-menu">
            <div class="navbar-start">
                <a class="navbar-item">
                    Ofertas del Día
                </a>
                <div class="navbar-item">
                    <form>
                        <div class="control has-icons-left">
                            <input class="input" type="text" placeholder="Search">
                            <span class="icon is-left">
                                <i class="fas fa-search"></i>
                            </span>
                        </div>
                    </form>
                </div>
            </div>

            <div class="navbar-end">
                <div class="navbar-item">
                    <div class="buttons">
                        <% 
                            Persona user = (Persona) session.getAttribute("user");
                            if (user == null) { 
                        %>
                            <!-- Mostrar Sign up y Sign in solo si no hay usuario logueado -->
                            <a class="button is-primary" id="btn-signup">
                                <strong>Sign up</strong>
                            </a>
                            <a class="button is-light" id="signInButton">
                                Sign in
                            </a>
                        <% 
                            } else {
                            	boolean isAdmin = false;
                            	Rol rol= new Rol();
                            	rol.setDescripcion("admin");
                            	DataRol dataRol= new DataRol();
                            	rol=dataRol.getByDesc(rol);
                            	isAdmin = user.hasRol(rol);
                        %>
                            <a class="nav-link button is-light" href="Controller?accion=Carrito">
                                <i class="fas fa-cart-plus">
                                (<label style="color: orange"> ${contador} </label>)</i>Carrito                          
                            </a>
                            
                            <% if (isAdmin) { %>
                                <div class="navbar-item has-dropdown is-hoverable">
                                <a class="navbar-link">
                                    <i ></i> Management
                                </a>
                                <div class="navbar-dropdown">                               
                                	<a class="navbar-item" href="Controller?accion=Listar">
                                        Productos
                                    </a>
                                    <a class="navbar-item" href="Controller?accion=ListarCategorias">
                                        Categorias
                                    </a>
                                    <a class="navbar-item" href="Controller?accion=ListarPersonas">
                                        Usuarios
                                    </a>
                                	</div>
                                </div>
                            <% } %>
                            
                            <!-- Dropdown para el usuario logueado -->
                            <div class="navbar-item has-dropdown is-hoverable">
                                <a class="navbar-link">
                                    <i class="fas fa-user"></i> <%= user.getNombre() %>
                                </a>
                                <div class="navbar-dropdown">
                                    <a class="navbar-item" href="Controller?accion=Perfil">
                                        Mi perfil
                                    </a>
                                    <a class="navbar-item" onclick="openModalTarjeta()">
									    Añadir Tarjeta
									</a>
                                    <a class="navbar-item"  onclick="openModalAgregarSaldo()">
									    Agregar Saldo
									</a>
                                    <a class="navbar-item" href="Controller?accion=MisCompras">
                                        Mis compras
                                    </a>
                                    <hr class="navbar-divider">
                                    <a class="navbar-item" href="Controller?accion=SignOut">
                                        Sign out
                                    </a>
                                </div>
                            </div>
                        <% } %>
                    </div>
                </div>
            </div>
        </div>
    </nav>

    <section class="section">
        <div class="container">
            <h1 class="title">Carrito de Compras</h1>
            <div class="columns">
                <div class="column is-8">
                    <table class="table is-fullwidth is-striped is-hoverable">
                        <thead>
                            <tr>
                                <th>ITEM</th>
                                <th>NOMBRES</th>
                                <th>DESCRIPCION</th>
                                <th>PRECIO</th>
                                <th>CANTIDAD</th>
                                <th>SUBTOTAL</th>
                                <th>ACCION</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                            List<Carrito> listaCarrito = (List<Carrito>)request.getAttribute("carrito");
                            
                            
                            if (listaCarrito != null && !listaCarrito.isEmpty()) {
                                for (Carrito c : listaCarrito) {
                            %>
                                <tr>
                                    <td><%= c.getItem() %></td>
                                    <td><%= c.getNombres() %></td>
                                    <td><%= c.getDescripcion() %> 
                                    <img src="ControllerImg?id=<%=c.getIdProducto() %>" width="100" height="100"> 
                                    </td>
                                    <td>$<%= String.format("%.2f", c.getPrecioCompra()) %></td>
                                    <td>
									    <input type="hidden" class="idpro" value="<%= c.getIdProducto() %>">
									    <input 
									        type="number" 
									        class="input is-primary is-small text-center Cantidad" 
									        value="<%= c.getCantidad() %>" 
									        min="1"
									        style="width: 80px; text-align: center;"
									    >
									</td>
                                    <td>$<%= String.format("%.2f", c.getSubTotal()) %></td>
                                    <td>                                                                                  
                                       	<input type="hidden" class="idp" value="<%= c.getIdProducto() %>">
										<button class="button is-danger btnDelete">
										    <span class="icon is-small">
										        <i class="fas fa-trash-alt"></i>
										    </span>
										</button>                                       
                                    </td>
                                </tr>
                            <%
                                }
                            } else {
                            %>
                                <tr>
                                    <td colspan="7" class="has-text-centered">No hay productos en el carrito</td>
                                </tr>
                            <%
                            }
                            %>
                        </tbody>
                    </table>
                </div>
                <div class="column is-4">
                    <div class="card">
                        <header class="card-header">
                            <p class="card-header-title">
                                Generar Compra
                            </p>
                        </header>
                        <div class="card-content">
                            <div class="field">
                                <label class="label">Subtotal:</label>
                                <div class="control">
                                    <input type="text" readonly class="input" value="$${totalPagar}0">
                                </div>
                            </div>
                            <div class="field">
                                <label class="label">Descuento:</label>
                                <div class="control">
                                    <input type="text" readonly class="input" value="$0.00">
                                </div>
                            </div>
                            <div class="field">
                                <label class="label">Total a Pagar:</label>
                                <div class="control">
                                    <input type="text" readonly class="input" value="$${totalPagar}0">
                                </div>
                            </div>
                        </div>
                        <footer class="card-footer">
                           <button id="openPaymentModal" class="card-footer-item button is-info is-fullwidth">Comprar</button>
                        </footer>
                    </div>
                </div>
            </div>
        </div>
    </section>
    
	<div class="modal" id="paymentModal">
        <div class="modal-background"></div>
        <div class="modal-card">
            <header class="modal-card-head">
                <p class="modal-card-title">Confirmación de Pago</p>
                <button class="delete" aria-label="close" id="closeModal"></button>
            </header>
            <section class="modal-card-body">
                <form id="paymentForm" action="Controller?accion=RealizarPago" method="post" enctype="form-data">
                    <div class="field">
                        <label class="label">Nombre en la tarjeta</label>
                        <div class="control">
                            <input class="input" type="text" name="nombre" placeholder="Nombre completo" required>
                        </div>
                    </div>
                    <div class="field">
                        <label class="label">Número de la tarjeta</label>
                        <div class="control">
                            <input class="input" type="text" name="numero" placeholder="1234 5678 9101 1121" maxlength="19" required>
                        </div>
                    </div>
                    <div class="field is-flex">
                        <div class="control mr-2">
                            <label class="label">Fecha de expiración</label>
                            <input class="input" type="text" placeholder="MM/AA" name="fecha" maxlength="5" required>
                        </div>
                        <div class="control">
                            <label class="label">CVV</label>
                            <input class="input" type="text" name="cvv" placeholder="123" maxlength="3" required>
                        </div>
                    </div>
                </form>
            </section>
            <footer class="modal-card-foot">
                <button type="submit" form="paymentForm" class="button is-success" name="accion" value="RealizarPago">Pagar ahora</button>
                <button class="button" id="cancelPayment">Cancelar</button>
            </footer>
        </div>
    </div>

	<div class="modal" id="addTarjetaModal">
	    <div class="modal-background"></div>
		    <div class="modal-content">
		        <div class="box">
		            <h3 class="title is-4">Agregar Nueva Tarjeta</h3>
		            <form action="Controller?accion=GuardarTarjeta" method="post">
		                <div class="field">
                    <label class="label">Número de Tarjeta:</label>
	                    <div class="control">
		                        <input class="input" type="text" name="numeroTarjeta" id="numeroTarjeta" required 
		                               pattern="[0-9]{4}-[0-9]{4}-[0-9]{4}-[0-9]{4}" 
		                               title="Formato: xxxx-xxxx-xxxx-xxxx"
		                               placeholder="xxxx-xxxx-xxxx-xxxx"
		                               maxlength="19">
		                    </div>
		                </div>
		                <div class="field">
		                    <label class="label">Nombre del titular de la tarjeta:</label>
		                    <div class="control">
		                        <input class="input" type="text" name="nombreTarjeta" required>
		                    </div>
		                </div>
		                <div class="field">
		                    <label class="label">Fecha de Vencimiento:</label>
		                    <div class="control">
		                        <input class="input" type="text" name="fechaTarjeta" required pattern="(0[1-9]|1[0-2])\/[0-9]{2}" title="Formato MM/YY">
		                    </div>
		                </div>
		                <div class="field">
		                    <label class="label">CVV:</label>
		                    <div class="control">
		                        <input class="input" type="text" name="cvvTarjeta" required pattern="\d{3,4}" title="3 o 4 dígitos">
		                    </div>
		                </div>
		                <div class="field">
		                    <label class="label">Saldo Inicial:</label>
		                    <div class="control">
		                        <input class="input" type="number" name="saldoTarjeta" step="0.01" required>
		                    </div>
		                </div>
		                <div class="field is-grouped">
		                    <div class="control">
		                        <button class="button is-link" type="submit">Guardar</button>
		                    </div>
		                    <div class="control">
		                        <button class="button is-light" type="button" onclick="closeModalTarjeta()">Cancelar</button>
		                    </div>
		                </div>
		            </form>
		        </div>
		    </div>
	    <button class="modal-close is-large" aria-label="close" onclick="closeModalTarjeta()"></button>
	</div>
    
    <div class="modal" id="agregarSaldoModal">
	    <div class="modal-background"></div>
		    <div class="modal-content">
		        <div class="box">
		            <h3 class="title is-4">Agregar Saldo</h3>
		            <form id="agregarSaldoForm" action="Controller?accion=AñadirSaldo" method="post">
		                <div class="field">
		                    <label class="label">Número de Tarjeta:</label>
		                    <div class="control">
		                        <input class="input" type="text" name="numeroTarjeta" id="numeroTarjetaSaldo" required 
		                               pattern="[0-9]{4}-[0-9]{4}-[0-9]{4}-[0-9]{4}" 
		                               title="Formato: 2222-2222-2222-2222"
		                               placeholder="2222-2222-2222-2222"
		                               maxlength="19">
		                    </div>
		                </div>
		                <div class="field">
		                    <label class="label">Saldo a Agregar:</label>
		                    <div class="control">
		                        <input class="input" type="number" name="saldoAgregar" step="0.01" min="0.01" required>
		                    </div>
		                </div>
		                <div class="field is-grouped">
		                    <div class="control">
		                        <button class="button is-link" type="submit">Agregar Saldo</button>
		                    </div>
		                    <div class="control">
		                        <button class="button is-light" type="button" onclick="closeModalAgregarSaldo()">Cancelar</button>
		                    </div>
		                </div>
		            </form>
		        </div>
		    </div>
	    <button class="modal-close is-large" aria-label="close" onclick="closeModalAgregarSaldo()"></button>
	</div>
	
	<div class="modal" id="confirmacionModal">
	    <div class="modal-background"></div>
	    <div class="modal-content">
	        <div class="box">
	            <h3 class="title is-4">Confirmación</h3>
	            <p id="mensajeConfirmacion"></p>
	            <button class="button is-success" onclick="closeConfirmacionModal()">Aceptar</button>
	        </div>
	    </div>
	</div>

    <script>
        // Abrir el modal de pago
        document.getElementById('openPaymentModal').addEventListener('click', () => {
            document.getElementById('paymentModal').classList.add('is-active');
        });

        // Cerrar el modal
        document.getElementById('closeModal').addEventListener('click', () => {
            document.getElementById('paymentModal').classList.remove('is-active');
        });
        document.getElementById('cancelPayment').addEventListener('click', () => {
            document.getElementById('paymentModal').classList.remove('is-active');
        });
    </script>
    <script>
        document.addEventListener('DOMContentLoaded', () => {
            const $navbarBurgers = Array.prototype.slice.call(document.querySelectorAll('.navbar-burger'), 0);
            if ($navbarBurgers.length > 0) {
                $navbarBurgers.forEach( el => {
                    el.addEventListener('click', () => {
                        const target = el.dataset.target;
                        const $target = document.getElementById(target);
                        el.classList.toggle('is-active');
                        $target.classList.toggle('is-active');
                    });
                });
            }
        });
    </script>
    <script>
        document.addEventListener('DOMContentLoaded', () => {
            // Get all "navbar-burger" elements
            const navbarBurgers = Array.prototype.slice.call(document.querySelectorAll('.navbar-burger'), 0);

            // Check if there are any navbar burgers
            if (navbarBurgers.length > 0) {
                // Add a click event on each of them
                navbarBurgers.forEach(el => {
                    el.addEventListener('click', () => {
                        // Get the target from the "data-target" attribute
                        const target = el.dataset.target;
                        const $target = document.getElementById(target);

                        // Toggle the "is-active" class on both the "navbar-burger" and the "navbar-menu"
                        el.classList.toggle('is-active');
                        $target.classList.toggle('is-active');
                    });
                });
            }
        });
    </script>
    <script>
function openModalTarjeta() {
    document.getElementById('addTarjetaModal').classList.add('is-active');
}

function closeModalTarjeta() {
    document.getElementById('addTarjetaModal').classList.remove('is-active');
}

document.addEventListener('DOMContentLoaded', (event) => {
    var modals = document.querySelectorAll('.modal-background, .modal-close');
    modals.forEach(function(el) {
        el.addEventListener('click', function() {
            closeModalTarjeta();
        });
    });

    document.querySelector('#addTarjetaModal form').addEventListener('submit', function(e) {
        if (!this.checkValidity()) {
            e.preventDefault();
            alert('Por favor, complete todos los campos correctamente.');
        }
    });
});

function openModalAgregarSaldo() {
    document.getElementById('agregarSaldoModal').classList.add('is-active');
}

function closeModalAgregarSaldo() {
    document.getElementById('agregarSaldoModal').classList.remove('is-active');
}

function openConfirmacionModal(mensaje) {
    document.getElementById('mensajeConfirmacion').textContent = mensaje;
    document.getElementById('confirmacionModal').classList.add('is-active');
}

function closeConfirmacionModal() {
    document.getElementById('confirmacionModal').classList.remove('is-active');
    location.reload(); 
}

document.addEventListener('DOMContentLoaded', (event) => {
    document.getElementById('numeroTarjetaSaldo').addEventListener('input', function (e) {
        var target = e.target, position = target.selectionEnd,
            length = target.value.length;
        
        target.value = target.value.replace(/[^\d]/g, '').replace(/(.{4})/g, '$1-').trim();
        target.value = target.value.substring(0, 19);
        
        if(target.value.length !== length) {
            target.selectionEnd = position;
        }
    });

    document.getElementById('agregarSaldoForm').addEventListener('submit', function(e) {
        e.preventDefault();
        if (this.checkValidity()) {
            var formData = new FormData(this);
            fetch('Controller?accion=AñadirSaldo', {
                method: 'POST',
                body: formData
            })
            .then(response => response.text())
            .then(data => {
                closeModalAgregarSaldo();
                openConfirmacionModal(data);
            })
            .catch(error => {
                console.error('Error:', error);
                alert('Ocurrió un error al agregar el saldo');
            });
        } else {
            alert('Por favor, complete todos los campos correctamente.');
        }
    });
});
</script>
    
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="js/funciones.js"></script>
</body>
</html>