<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="entities.*" %>
<%@ page import="java.util.*" %>

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
    	margin-right: 7rem; /* Puedes ajustar este valor seg�n sea necesario */
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
                    Ofertas del D�a
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
                        %>
                            <!-- Mostrar opciones si el usuario est� logueado -->
                            <a class="nav-link button is-light" href="Controller?accion=Carrito">
                                <i class="fas fa-cart-plus">
                                (<label style="color: orange"> ${contador} </label>)</i>Carrito                          
                            </a>
                            
                            <% if (user.isHabilitado()) { %>
                                <!-- Mostrar Management si el usuario est� habilitado -->
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
    
     <div class="container">
                    <div class="level">
                        <div class="level-left">
                            <h3 class="title is-4">Lista de Categor�as</h3>
                        </div>
                        <div class="level-right">
                            <button class="button is-primary" onclick="openModalCategoria()">
                                <span class="icon">
                                    <i class="fas fa-plus"></i>
                                </span>
                                <span>Agregar Nueva Categor�a</span>
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
	            <p class="modal-card-title">Confirmar Eliminaci�n</p>
	            <button class="delete" aria-label="close" onclick="cerrarModalConfirmacion()"></button>
	        </header>
	        <section class="modal-card-body">
	            <p>�Est�s seguro de que deseas eliminar esta categor�a? Esta acci�n no se puede deshacer.</p>
	        </section>
	        <footer class="modal-card-foot">
	            <!-- Formulario de eliminaci�n -->
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
	            <p class="modal-card-title">Editar Categor�a</p>
	            <button class="delete" aria-label="close" onclick="cerrarModalEditCategoria()"></button>
	        </header>
	        <form action="Controller" method="post">
	            <section class="modal-card-body">
	                <!-- Campo oculto para el ID de la categor�a -->
	                <input type="hidden" name="id" id="categoriaId">
	                <div class="field">
	                    <label class="label">Nombre de la Categor�a</label>
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

<script type="text/javascript">


function openModalCategoria() {
    document.getElementById('modalCategoria').classList.add('is-active');
}

// Funci�n para cerrar el modal
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
    // Asigna el ID de la categor�a al campo oculto del formulario de eliminaci�n
    document.getElementById('deleteCategoriaId').value = id;

    // Muestra el modal de confirmaci�n
    document.getElementById('modalConfirmacion').classList.add('is-active');
}

function cerrarModalConfirmacion() {
    // Oculta el modal de confirmaci�n
    document.getElementById('modalConfirmacion').classList.remove('is-active');
}
</script>
</html>