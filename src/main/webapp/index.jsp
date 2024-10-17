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
    <title>Eccomerce Libera</title>
    <style>
        .button.is-red {
            background-color: #ff3860; /* Rojo Bulma */
            color: white;
            border: none;
        }
        .navbar-item .button.is-red {
            margin-left: 1rem; /* Espacio entre botones */
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
                        %>
                            <!-- Mostrar opciones si el usuario está logueado -->
                            <a class="nav-link button is-light" href="Controller?accion=Carrito">
                                <i class="fas fa-cart-plus">
                                (<label style="color: orange"> ${contador} </label>)</i>Carrito                          
                            </a>
                            
                            <% if (user.isHabilitado()) { %>
                                <!-- Mostrar Management si el usuario está habilitado -->
                                <form action="Controller" method="post">
                                    <div class="control">
                                        <button type="submit" name="accion" value="Listar" class="button is-danger">Management</button>
                                    </div>
                                </form>
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
   <section class="section">
	    <div class="container">
	        <h1 class="title">Catálogo de Productos</h1>
	        <div class="container mt-4">
	            <div class="columns is-multiline">
	                <% 
	                List<Producto> catalogo = (List<Producto>) request.getAttribute("productos");
	                boolean userLoggedIn = request.getSession().getAttribute("user") != null;
	
	                if (catalogo != null && !catalogo.isEmpty()) {
	                    for (Producto p : catalogo) {
	                %>
	                <div class="column is-one-third">
	                    <div class="card">
	                        <header class="card-header">
	                            <p class="card-header-title">
	                                <%= p.getNombre() %>
	                            </p>
	                        </header>
	                        <div class="card-content">
	                            <div class="content">
	                                <p class="is-italic has-text-weight-bold is-size-4 mb-2">$<%= String.format("%.2f", p.getPrecio()) %></p>
	                                <figure class="image is-4by3">
	                                    <img src="ControllerImg?id=<%= p.getId() %>" alt="<%= p.getNombre() %>">
	                                </figure>
	                            </div>
	                        </div>
	                        <footer class="card-footer">
	                            <div class="card-footer-item is-flex is-flex-direction-column is-align-items-flex-start">
	                                <p class="mb-2"><%= p.getDescripcion() %></p>
	                                <div class="buttons">
	                                    <% if (userLoggedIn) { %>
	                                        <a href="Controller?accion=AgregarCarrito&id=<%= p.getId() %>" class="button is-info is-outlined">Agregar al carrito</a>
	                                    <% } else { %>
	                                        <a class="button is-info is-outlined is-disabled"  title="Inicie sesión para agregar al carrito" style="pointer-events: none;">Agregar al carrito</a>
	                                    <% } %>
	                                    <a href="Controller?accion=ComprarAhora&id=<%= p.getId() %>" class="button is-danger">Comprar</a>
	                                </div>
	                            </div>
	                        </footer>
	                    </div>
	                </div>
	                <% 
	                    }
	                } else {
	                %>
	                <div class="column">
	                    <p class="has-text-centered">No hay productos disponibles en este momento.</p>
	                </div>
	                <%
	                }
	                %>
	            </div>
	        </div>
	    </div>
	</section>
	
	

    <% if (request.getAttribute("error") != null) { %>
        <div class="notification is-danger">
            <%= request.getAttribute("error") %>
        </div>
    <% } %>
    
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
</body>
</html>
