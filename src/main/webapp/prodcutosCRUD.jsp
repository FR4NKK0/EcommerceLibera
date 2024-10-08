<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="entities.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" integrity="sha384-k6RqeWeci5ZR/Lv4MR0sA0FfDOMm2JgX/aTk5lZeg6MOc1pYNeZTk5cBz6QeV6y" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" href="style/bulma.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <meta charset="ISO-8859-1">
    <title>Agregar Nuevo Producto</title>
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
                <span aria-hidden="true"></span>
            </a>
        </div>

        <div id="navbarBasicExample" class="navbar-menu">
            <div class="navbar-start">
                <a class="navbar-item">Ofertas del Día</a>
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
                    <a class="navbar-link">More</a>
                    <div class="navbar-dropdown">
                        <a class="navbar-item">About</a>
                        <a class="navbar-item is-selected">Jobs</a>
                        <a class="navbar-item">Contact</a>
                        <hr class="navbar-divider">
                        <a class="navbar-item">Report an issue</a>
                    </div>
                </div>
            </div>

            <div class="navbar-end">
                <div class="navbar-item">
                    <div class="buttons">
                        <a class="button is-primary"><strong>Sign up</strong></a>
                        <a class="button is-light">Log in</a>
                        <a class="button is-light">
                            <span class="icon"><i class="fas fa-shopping-cart"></i></span>
                        </a>
                        <form action="Controller" method="post">
                            <div class="control">
                                <button type="submit" name="accion" value="Nuevo" class="button is-danger">Management</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </nav>

    <div class="container">
    <div class="form-section">
        

        <div class="table-container">
        <form action="Controller?accion=Listar" method="post" class="is-pulled-right" >
            <div class="field is-grouped">
                <div class="control is-pulled-right">
                    <button class="button is-link" type="submit" name="accion" value="Listar">Productos</button>
                </div>
                <div class="control is-pulled-right">
                    <button class="button is-link" type="button" onclick="openModal()">Agregar Nuevo Producto</button>
                </div>
            </div>
        </form>
            <h3 class="title is-4">Lista de Productos</h3>
            <hr>
            
        
            <table class="table is-striped is-bordered is-hoverable is-fullwidth">
			    <thead>
			        <tr>
			            <th>ID</th>
			            <th>Nombre</th>
			            <th>Imagen</th>
			            <th>Descripción</th>
			            <th>Precio</th>
			            <th>Stock</th>
			            <th>Acciones</th>
			        </tr>
			    </thead>
			    <tbody>
			        <% 
			            List<Producto> productos = (List<Producto>) request.getAttribute("productos");
			            if (productos != null) {
			                for (Producto p : productos) {
			        %>
			        <tr>
			            <td><%= p.getId() %></td>
			            <td><%= p.getNombre() %></td>
			            <td>
			                <img src="ControllerImg?id=<%= p.getId() %>" alt="<%= p.getNombre() %>" style="max-width: 100px;">
			            </td>
			            <td><%= p.getDescripcion() %></td>
			            <td><%= p.getPrecio() %></td>
			            <td><%= p.getStock() %></td>
			            <td>
			                <form action="Controller" method="post">
			                    <input type="hidden" name="id" value="<%= p.getId() %>">
			                    <div class="field is-grouped">
			                        <div class="control">
			                            <button class="button is-link" type="submit" name="accion" value="Edit">Edit</button>
			                        </div>
			                        <div class="control">
			                            <button class="button is-light" type="submit" name="accion" value="Delete">Delete</button>
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
</div>
    
    
<div class="modal" id="addProductModal">
        <div class="modal-background"></div>
        <div class="modal-content">
            <div class="box">
                <h3 class="title is-4">Agregar Nuevo Producto</h3>
                <form action="Controller?accion=Guardar" method="post" enctype="multipart/form-data">
                    <div class="field">
                        <label class="label">Nombre:</label>
                        <div class="control">
                            <input class="input" type="text" name="txtNom" required>
                        </div>
                    </div>
                    <div class="field">
					    <label class="label">Foto:</label>
					    <div class="file has-name is-fullwidth">
					        <label class="file-label">
					            <input class="file-input" type="file" name="fileFoto" id="fileFoto" required>
					            <span class="file-cta has-background-warning">
					                <span class="file-icon">
					                    <i class="fas fa-upload"></i>
					                </span>
					                <span class="file-label">
					                    Choose a file...
					                </span>
					            </span>
					            <span class="file-name has-background-warning-light">
					                No file chosen
					            </span>
					        </label>
					    </div>
					</div>
                    <div class="field">
                        <label class="label">Descripción:</label>
                        <div class="control">
                            <input class="input" type="text" name="txtDesc" required>
                        </div>
                    </div>
                    <div class="field">
                        <label class="label">Precio:</label>
                        <div class="control">
                            <input class="input" type="text" name="numbPrecio" required>
                        </div>
                    </div>
                    <div class="field">
                        <label class="label">Stock:</label>
                        <div class="control">
                            <input class="input" type="text" name="numbStock" required>
                        </div>
                    </div>
                    <div class="field">
                    <label class="label">Categoria:</label>
                    <div class="control">
                        <input class="input" type="text" name="nomCat" required>
                    </div>
                	</div>
                    <div class="field is-grouped">
                        <div class="control">
                            <button class="button is-link" type="submit" name="accion" value="Guardar">Guardar</button>
                        </div>
                        <div class="control">
                            <button class="button is-light" type="button" onclick="closeModal()">Cancelar</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
        <button class="modal-close is-large" aria-label="close" onclick="closeModal()"></button>
    </div>

    <script>
        function openModal() {
            document.getElementById('addProductModal').classList.add('is-active');
        }

        function closeModal() {
            document.getElementById('addProductModal').classList.remove('is-active');
        }
        
        document.addEventListener('DOMContentLoaded', (event) => {
            const fileInput = document.getElementById('fileFoto');
            fileInput.onchange = () => {
                if (fileInput.files.length > 0) {
                    const fileName = document.querySelector('.file-name');
                    fileName.textContent = fileInput.files[0].name;
                }
            }
        });
    </script>
    
    
</body>
</html>    
  

