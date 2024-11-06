<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="entities.*" %>
<%@ page import="java.util.*" %>
<%@ page import="data.*" %>

<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="style/bulma.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <meta charset="ISO-8859-1">
    <title>Categorias</title>
    <style>
        .button.is-red {
            background-color: #ff3860; /* Rojo Bulma */
            color: white;
            border: none;
        }
        .navbar-item .button.is-red {
            margin-left: 1rem; /* Espacio entre botones */
        }
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
                    <form action="Controller" method="GET">
					    <div class="field has-addons">
					        <div class="control has-icons-left">
					            <input class="input" type="text" name="txtBuscar" placeholder="Buscar producto">
					            <span class="icon is-left">
					                <i class="fas fa-search"></i>
					            </span>
					        </div>
					        <div class="control">
					            <button class="button is-info" type="submit">Buscar</button>
					        </div>
					        <input type="hidden" name="accion" value="BuscarProducto">
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
                                    <a class="navbar-item" href="Controller?accion=ListarCompras">
                                        Compras
                                    </a>
                                    <a class="navbar-item" href="Controller?accion=ListarPagos">
                                        Pagos
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
    
<%
        boolean isAdmin = false;
        if (user != null) {
            Rol rol = new Rol();
            rol.setDescripcion("admin");
            DataRol dataRol = new DataRol();
            rol = dataRol.getByDesc(rol);
            isAdmin = user.hasRol(rol);
        }

        if (isAdmin) {
    %>
    
     <div class="container">
                    <div class="level">
                        <div class="level-left">
                            <h3 class="title is-4">Lista de Categorías</h3>
                        </div>
                        <div class="level-right">
                            <button class="button is-primary" onclick="openModalCategoria()">
                                <span class="icon">
                                    <i class="fas fa-plus"></i>
                                </span>
                                <span>Agregar Nueva Categoría</span>
                            </button>
                        </div>
                    </div>
                    
                    <div class="table-container">
                        <table class="table is-striped is-bordered is-hoverable is-fullwidth">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Nombre</th>
                                    <th>Acciones</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% 
                                    List<Categoria> categorias = (List<Categoria>) request.getAttribute("categorias");
                                    if (categorias != null) {
                                        for (Categoria c : categorias) {
                                %>
                                <tr>
                                    <td><%= c.getId() %></td>
                                    <td><%= c.getNombre() %></td>
                                    <td>
                                        <form action="Controller" method="post">
                                        <input type="hidden" name="id" value="<%= c.getId() %>">
                                        <div class="field is-grouped">
                                            
                                                <div class="control">
											        <button class="button is-small is-link" type="button" onclick="abrirModalEditCategoria('<%= c.getId() %>', '<%= c.getNombre() %>')">Edit</button>
											    </div>
                                            
                                            <div class="control">
                                                <button class="button is-small is-danger" type="button" onclick="abrirModalConfirmacion('<%= c.getId() %>')">Delete</button>
                                            </div>
                                        </div>
                                    </form>
                                    </td>
                                </tr>
                                <% 
                                        }
                                    }
                                %>
                            </tbody>
                        </table>
                    </div>
                </div>   
      
	<div id="modalConfirmacion" class="modal">
	    <div class="modal-background"></div>
	    <div class="modal-card">
	        <header class="modal-card-head">
	            <p class="modal-card-title">Confirmar Eliminación</p>
	            <button class="delete" aria-label="close" onclick="cerrarModalConfirmacion()"></button>
	        </header>
	        <section class="modal-card-body">
	            <p>¿Estás seguro de que deseas eliminar esta categoría? Esta acción no se puede deshacer.</p>
	        </section>
	        <footer class="modal-card-foot">
	            <!-- Formulario de eliminación -->
	            <form id="formDeleteCategoria" action="Controller" method="post">
	                <input type="hidden" name="id" id="deleteCategoriaId">
	                <button class="button is-danger" type="submit" name="accion" value="DeleteCategoria">Eliminar</button>
	                <button class="button" type="button" onclick="cerrarModalConfirmacion()">Cancelar</button>
	            </form>
	        </footer>
	    </div>
	</div>      
                
    <div id="modalEditCategoria" class="modal">
	    <div class="modal-background"></div>
	    <div class="modal-card">
	        <header class="modal-card-head">
	            <p class="modal-card-title">Editar Categoría</p>
	            <button class="delete" aria-label="close" onclick="cerrarModalEditCategoria()"></button>
	        </header>
	        <form action="Controller" method="post">
	            <section class="modal-card-body">
	                <!-- Campo oculto para el ID de la categoría -->
	                <input type="hidden" name="id" id="categoriaId">
	                <div class="field">
	                    <label class="label">Nombre de la Categoría</label>
	                    <div class="control">
	                        <input class="input" type="text" name="nombre" id="categoriaNombre" required>
	                    </div>
	                </div>
	            </section>
	            <footer class="modal-card-foot">
	                <button class="button is-success" type="submit" name="accion" value="EditCategoria">Guardar cambios</button>
	                <button class="button" type="button" onclick="cerrarModalEditCategoria()">Cancelar</button>
	            </footer>
	        </form>
	    </div>
	</div>
                
<div id="modalCategoria" class="modal">
    <div class="modal-background" onclick="closeModalCategoria()"></div>
    <div class="modal-card">
        <div class="box">
                <h3 class="title is-4">Agregar Nueva Categoria</h3>
                <form action="Controller?accion=CrearCategoria" method="post" >
                    <div class="field">
                        <label class="label">Nombre:</label>
                        <div class="control">
                            <input class="input" type="text" name="txtNom" required>
                        </div>
                    </div>
        <div class="field is-grouped">
                        <div class="control">
                            <button class="button is-link" type="submit" name="accion" value="CrearCategoria">Guardar</button>
                        </div>
                        <div class="control">
                            <button class="button is-light" type="button" onclick="closeModalCategoria()">Cancelar</button>
                        </div>
                    </div>
                </form>
              </div>
    </div>
</div>

 <div class="modal" id="modal-register">
        <div class="modal-background"></div>
        <div class="modal-card">
            <header class="modal-card-head">
                <p class="modal-card-title">Registrar Persona</p>
                <button class="delete" aria-label="close" id="btn-close"></button>
            </header>
            <section class="modal-card-body">
                <form action="Controller?accion=Registrar" method="post" enctype="form-data">
                    <div class="field">
                        <label class="label">Tipo de Documento</label>
                        <div class="control">
                            <div class="select">
                                <select name="tipo_doc">
                                    <option value="dni">DNI</option>
                                    <option value="cuit">CUIT</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="field">
                        <label class="label">Número de Documento</label>
                        <div class="control">
                            <input class="input" type="text" name="numero_doc" placeholder="Número de documento" required>
                        </div>
                    </div>
                    <div class="field">
                        <label class="label">Nombre</label>
                        <div class="control">
                            <input class="input" type="text" name="nombre" placeholder="Nombre" required>
                        </div>
                    </div>
                    <div class="field">
                        <label class="label">Apellido</label>
                        <div class="control">
                            <input class="input" type="text" name="apellido" placeholder="Apellido" required>
                        </div>
                    </div>
                    <div class="field">
                        <label class="label">Email</label>
                        <div class="control">
                            <input class="input" type="email" name="email" placeholder="Email" required>
                        </div>
                    </div>
                    <div class="field">
                        <label class="label">Teléfono</label>
                        <div class="control">
                            <input class="input" type="text" name="telefono" placeholder="Teléfono" required>
                        </div>
                    </div>
                    <div class="field">
                        <label class="label">Contraseña</label>
                        <div class="control">
                            <input class="input" type="password" id="password" name="password" placeholder="Contraseña" required>
                        </div>
                    </div>
                    <div class="field">
                        <label class="label">Confirmar Contraseña</label>
                        <div class="control">
                            <input class="input" type="password" id="confirm-password" placeholder="Confirmar contraseña" required>
                        </div>
                        <p class="help is-danger" id="password-error" style="display: none;">Las contraseñas no coinciden</p>
                    </div>                   
                    <div class="field is-grouped">
                        <div class="control">
                            <button type="submit" class="button is-link">Registrar</button>
                        </div>
                        <div class="control">
                            <button type="button" class="button is-light" id="btn-cancel">Cancelar</button>
                        </div>
                    </div>
                </form>
            </section>
        </div>
    </div>
    
	<div class="modal" id="signInModal">
	    <div class="modal-background"></div>
	    <div class="modal-card">
	        <header class="modal-card-head">
	            <p class="modal-card-title">Sign in</p>
	            <button class="delete" aria-label="close" id="closeSignInModal"></button>
	        </header>
	        <section class="modal-card-body">
	            <form id="signInForm" method="post" action="Controller">
	                <div class="field">
	                    <label class="label">Email</label>
	                    <div class="control">
	                        <input class="input" type="email" name="email" placeholder="e.g. john@example.com" required>
	                    </div>
	                </div>
	                <div class="field">
	                    <label class="label">Password</label>
	                    <div class="control">
	                        <input class="input" type="password" name="password" placeholder="********" required>
	                    </div>
	                </div>
	                <input type="hidden" name="accion" value="SignIn">
	                <footer class="modal-card-foot">
	                    <button type="submit" class="button is-primary">Sign in</button>
	                    <button type="button" class="button" id="cancelSignIn">Cancel</button>
	                </footer>
	            </form>
	        </section>
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
	    document.addEventListener('DOMContentLoaded', () => {
	        // Referencias a elementos
	        const signInButton = document.getElementById('signInButton');
	        const signInModal = document.getElementById('signInModal');
	        const closeSignInModal = document.getElementById('closeSignInModal');
	        const cancelSignIn = document.getElementById('cancelSignIn');
	
	        // Mostrar modal de Sign in
	        signInButton.addEventListener('click', () => {
	            signInModal.classList.add('is-active');
	        });
	
	        // Cerrar modal de Sign in
	        closeSignInModal.addEventListener('click', () => {
	            signInModal.classList.remove('is-active');
	        });
	        cancelSignIn.addEventListener('click', () => {
	            signInModal.classList.remove('is-active');
	        });
	    });
	</script>
	
    <script>
        document.addEventListener('DOMContentLoaded', () => {
            const modal = document.getElementById('modal-register');
            const btnSignUp = document.getElementById('btn-signup');
            const btnClose = document.getElementById('btn-close');
            const btnCancel = document.getElementById('btn-cancel');
            const form = document.getElementById('register-form');
            const password = document.getElementById('password');
            const confirmPassword = document.getElementById('confirm-password');
            const passwordError = document.getElementById('password-error');

            // Abrir modal
            btnSignUp.addEventListener('click', () => {
                modal.classList.add('is-active');
            });

            // Cerrar modal
            btnClose.addEventListener('click', () => {
                modal.classList.remove('is-active');
            });

            btnCancel.addEventListener('click', () => {
                modal.classList.remove('is-active');
            });

            // Validar que las contraseñas coincidan antes de enviar el formulario
            form.addEventListener('submit', (e) => {
                if (password.value !== confirmPassword.value) {
                    e.preventDefault();
                    passwordError.style.display = 'block';
                } else {
                    passwordError.style.display = 'none';
                }
            });
        });
    </script>

<script type="text/javascript">


function openModalCategoria() {
    document.getElementById('modalCategoria').classList.add('is-active');
}

// Función para cerrar el modal
function closeModalCategoria() {
    document.getElementById('modalCategoria').classList.remove('is-active');
}



function abrirModalEditCategoria(id, nombre) {
    document.getElementById('categoriaId').value = id;
    document.getElementById('categoriaNombre').value = nombre;
    document.getElementById('modalEditCategoria').classList.add('is-active');
}

function cerrarModalEditCategoria() {
    document.getElementById('modalEditCategoria').classList.remove('is-active');
}

function abrirModalConfirmacion(id) {
    // Asigna el ID de la categoría al campo oculto del formulario de eliminación
    document.getElementById('deleteCategoriaId').value = id;

    // Muestra el modal de confirmación
    document.getElementById('modalConfirmacion').classList.add('is-active');
}

function cerrarModalConfirmacion() {
    // Oculta el modal de confirmación
    document.getElementById('modalConfirmacion').classList.remove('is-active');
}
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

<%
        } else {
    %>
    <div class="container">
        <div class="notification is-danger">
            <p>No tienes permiso para ver esta página. Por favor, contacta a un administrador si crees que esto es un error.</p>
        </div>
    </div>
    <%
        }
    %>
</body>
</html>