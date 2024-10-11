<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="entities.*" %>
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
            <a class="navbar-item" href="Controller?accion=ListarCatalogo" >
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
                        <a class="nav-link button is-light" href="Controller?accion=ListarCatalogo">
                            Seguir Comprando                          
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
                                    <td><%= c.getCantidad() %></td>
                                    <td>$<%= String.format("%.2f", c.getSubTotal()) %></td>
                                    <td>
                                        <div class="buttons are-small">
                                            <button class="button is-info">
                                                <span class="icon is-small">
                                                    <i class="fas fa-edit"></i>
                                                </span>
                                            </button>
                                            <button class="button is-danger">
                                                <span class="icon is-small">
                                                    <i class="fas fa-trash-alt"></i>
                                                </span>
                                            </button>
                                        </div>
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
                            <a href="#" class="card-footer-item button is-info is-fullwidth">Realizar Pago</a>
                            <a href="#" class="card-footer-item button is-danger is-fullwidth">Generar Compra</a>
                        </footer>
                    </div>
                </div>
            </div>
        </div>
    </section>

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
</body>
</html>