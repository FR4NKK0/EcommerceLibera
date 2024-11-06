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
<title>Mis Compras</title>
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



	<div class="container">
        <div class="form-section">
            <div class="table-container">
                <h3 class="title is-4">Mis Compras</h3>
                <hr>
                
                <table class="table is-striped is-bordered is-hoverable is-fullwidth">
                    <thead>
                        <tr>
                            <th>ID Compra</th>
                            <th>ID Pago</th>
                            <th>Fecha</th>
                            <th>Monto</th>
                            <th>Estado</th>
                            <th>Detalles</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% 
                            if (user != null) {
                                List<Compra> compras = (List<Compra>) request.getAttribute("misCompras");
                                if (compras != null && !compras.isEmpty()) {
                                    for (Compra comp : compras) {
                        %>
                        <tr>
                            <td><%= comp.getId() %></td>
                            <td><%= comp.getIdpago() %></td>
                            <td><%= comp.getFecha() %></td>
                            <td>$<%= String.format("%.2f", comp.getMonto()) %></td>
                            <td><%= comp.getEstado() %></td>
                            <td>
                                <form action="Controller" method="post" style="display: inline;">
                                        <input type="hidden" name="accion" value="Detalles">
                                        <input type="hidden" name="idcompra" value="<%= comp.getId() %>">
                                        <button type="submit" class="button is-small is-info">
                                            <span class="icon is-small">
                                                <i class="fas fa-info-circle"></i>
                                            </span>
                                            <span>Ver Detalles</span>
                                        </button>
                                </form>
                            </td>
                        </tr>
                        <% 
                                    }
                                } else {
                        %>
                        <tr>
                            <td colspan="5" class="has-text-centered">No tienes compras registradas.</td>
                        </tr>
                        <%
                                }
                            } else {
                        %>
                        <tr>
                            <td colspan="5" class="has-text-centered">Debes iniciar sesión para ver tus compras.</td>
                        </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
            </div>
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
</body>
</html>