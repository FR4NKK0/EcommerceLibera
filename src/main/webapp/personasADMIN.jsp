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
    <div class="form-section">
        <div class="table-container">
            <form action="Controller?accion=ListarPersonas" method="post" class="is-pulled-right">
                <div class="field is-grouped">
                    <div class="control is-pulled-right">                       
                    </div>
                </div>
            </form>
            <h3 class="title is-4">Lista de Personas</h3>
            <hr>

            <table class="table is-striped is-bordered is-hoverable is-fullwidth">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Documento</th>
                        <th>Nombre</th>
                        <th>Apellido</th>
                        <th>Email</th>
                        <th>Teléfono</th>
                        <th>Habilitado</th>
                        <th>Roles</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                        LinkedList<Persona> personas = (LinkedList<Persona>) request.getAttribute("personas");
                        if (personas != null) {
                            for (Persona p : personas) {
                    %>
                    <tr>
                        <td><%= p.getId() %></td>
                        <td><%= p.getDocumento().getTipo() + ": " + p.getDocumento().getNro() %></td>
                        <td><%= p.getNombre() %></td>
                        <td><%= p.getApellido() %></td>
                        <td><%= p.getEmail() %></td>
                        <td><%= p.getTel() %></td>
                        <td><%= p.isHabilitado() ? "Sí" : "No" %></td>
                        <td>
                            <% 
                                for (Map.Entry<Integer, Rol> entry : p.roles.entrySet()) {
                                    out.print(entry.getValue().getDescripcion() + "<br>");
                                }
                            %>
                        </td>
                        <td>
                            <div class="field is-grouped">
                                <div class="control">
                                    <button class="button is-link is-small" onclick="asignarRol(<%= p.getId() %>)">
                                        <span class="icon is-small">
                                            <i class="fas fa-user-tag"></i>
                                        </span>
                                        <span>Asignar Rol</span>
                                    </button>
                                    <button class="button is-danger is-small" onclick="quitarRol(<%= p.getId() %>)">
									    <span class="icon is-small">
									        <i class="fas fa-user-minus"></i>
									    </span>
									    <span>Quitar Rol</span>
									</button>
									<button class="button is-warning is-small" onclick="toggleHabilitado(<%= p.getId() %>, <%= p.isHabilitado() %>)">
						                <span class="icon is-small">
						                    <i class="fas fa-toggle-on"></i>
						                </span>
						                <span>Toggle Habilitado</span>
						            </button>
                                </div>
                            </div>
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
</div>

<div id="modalAsignarRol" class="modal">
    <div class="modal-background"></div>
    <div class="modal-card">
        <header class="modal-card-head">
            <p class="modal-card-title">Asignar Rol</p>
            <button class="delete" aria-label="close" onclick="closeModalAsignarRol()"></button>
        </header>
        <section class="modal-card-body">
            <form id="formAsignarRol">
                <input type="hidden" id="personaId" name="id">
                <div class="field">
                    <label class="label">Rol</label>
                    <div class="control">
                        <div class="select">
                            <select id="rolDescripcion" name="rolDescripcion">
                                <option value="user">User</option>
                                <option value="admin">Admin</option>
                            </select>
                        </div>
                    </div>
                </div>
            </form>
        </section>
        <footer class="modal-card-foot">
            <button class="button is-success" onclick="guardarRol()">Guardar</button>
            <button class="button" onclick="closeModalAsignarRol()">Cancelar</button>
        </footer>
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


<script>
function asignarRol(id) {
    document.getElementById('personaId').value = id;
    openModalAsignarRol();
}

function openModalAsignarRol() {
    document.getElementById('modalAsignarRol').classList.add('is-active');
}

function closeModalAsignarRol() {
    document.getElementById('modalAsignarRol').classList.remove('is-active');
}

function guardarRol() {
    const formData = new FormData(document.getElementById('formAsignarRol'));
    
    fetch('Controller?accion=AsignarRol', {
        method: 'POST',
        body: formData
    })
    .then(response => response.text())
    .then(data => {
        if (data.startsWith('SUCCESS')) {
            alert('Rol asignado exitosamente');
            closeModalAsignarRol();
            location.reload(); // Recargar la página para mostrar los cambios
        } else {
            alert('Error al asignar el rol: ' + data);
        }
    })
    .catch((error) => {
        console.error('Error:', error);
        alert('Ocurrió un error al asignar el rol');
    });
}

function quitarRol(id) {
    const rolDescripcion = prompt("Ingrese el rol a quitar (user o admin):");
    if (rolDescripcion !== null && (rolDescripcion === "user" || rolDescripcion === "admin")) {
        const formData = new FormData();
        formData.append('id', id);
        formData.append('rolDescripcion', rolDescripcion);

        fetch('Controller?accion=QuitarRol', {
            method: 'POST',
            body: formData
        })
        .then(response => response.text())
        .then(data => {
            if (data.startsWith('SUCCESS')) {
                alert('Rol quitado exitosamente');
                location.reload(); // Recargar la página para mostrar los cambios
            } else {
                alert('Error al quitar el rol: ' + data);
            }
        })
        .catch((error) => {
            console.error('Error:', error);
            alert('Ocurrió un error al quitar el rol');
        });
    }
}

function toggleHabilitado(id, estadoActual) {
    if (confirm('¿Está seguro que desea cambiar el estado de habilitación de esta persona?')) {
        fetch('Controller?accion=ToggleHabilitado', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: 'id=' + id + '&estadoActual=' + estadoActual
        })
        .then(response => response.text())
        .then(data => {
            if (data.startsWith('SUCCESS')) {
                alert('Estado de habilitación cambiado exitosamente');
                location.reload();
            } else {
                alert('Error al cambiar el estado de habilitación: ' + data);
            }
        })
        .catch((error) => {
            console.error('Error:', error);
            alert('Ocurrió un error al cambiar el estado de habilitación');
        });
    }
}
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