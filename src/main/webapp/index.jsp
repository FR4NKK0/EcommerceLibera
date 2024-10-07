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
            <a class="navbar-item" href="index.jsp">
                <img src="style/iconcarrito.png" alt="Home" class="logo-image">
            </a>

            <a role="button" class="navbar-burger" aria-label="menu" aria-expanded="false" data-target="navbarBasicExample">
                <span aria-hidden="true"></span>
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
                <div class="navbar-item has-dropdown is-hoverable">
                    <a class="navbar-link">
                        More
                    </a>

                    <div class="navbar-dropdown">
                        <a class="navbar-item">
                            About
                        </a>
                        <a class="navbar-item is-selected">
                            Jobs
                        </a>
                        <a class="navbar-item">
                            Contact
                        </a>
                        <hr class="navbar-divider">
                        <a class="navbar-item">
                            Report an issue
                        </a>
                    </div>
                </div>
            </div>

            <div class="navbar-end">
                <div class="navbar-item">
                    <div class="buttons">
                        <a class="button is-primary">
                            <strong>Sign up</strong>
                        </a>
                        <a class="button is-light">
                            Log in
                        </a>
                        <a class="button is-light">
                            <span class="icon">
                                <i class="fas fa-shopping-cart"></i>
                            </span>
                        </a>
                        <form action="Controller" method="post">
                            <div class="control">
                                <button type="submit" name="accion" value="Listar" class="button is-danger">Management</button>
                            </div>
                        </form>
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
                    List<Producto> productos = (List<Producto>) request.getAttribute("productos");
                    if (productos != null && !productos.isEmpty()) {
                        for (Producto producto : productos) {
                    %>
                    <div class="column is-one-third">
                        <div class="card">
                            <header class="card-header">
                                <p class="card-header-title">
                                    <label><%= producto.getNombre() %></label>
                                </p>
                            </header>
                            <div class="card-content">
                                <div class="content">
                                    <p><i><%= producto.getDescripcion() %></i></p>
                                    <figure class="image is-4by3">
                                        <img src="ControllerImg?id=<%= producto.getId() %>" alt="<%= producto.getNombre() %>">
                                    </figure>
                                </div>
                            </div>
                            <footer class="card-footer">
                                <p class="card-footer-item">
                                    Precio: $<%= String.format("%.2f", producto.getPrecio()) %> | Stock: <%= producto.getStock() %>
                                </p>
                            </footer>
                            <div class="card-footer">
                                <a href="Controller?accion=AgregarCarrito&id=<%= producto.getId() %>" class="card-footer-item button is-info">Agregar a carrito</a>
                                <a href="Controller?accion=ComprarAhora&id=<%= producto.getId() %>" class="card-footer-item button is-danger">Comprar</a>
                            </div>
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
</body>
</html>
