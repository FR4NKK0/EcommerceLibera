<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="entities.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Editar Producto</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bulma@0.9.4/css/bulma.min.css">
    <script src="https://kit.fontawesome.com/a076d05399.js"></script>
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
    <div class="container">
        <div class="form-section">
            <h1 class="title">Editar Producto</h1>
            <% if (request.getAttribute("error") != null) { %>
                <div class="notification is-danger">
                    <%= request.getAttribute("error") %>
                </div>
            <% } %>
            <% Producto producto = (Producto) request.getAttribute("producto"); %>
            <form action="Controller?accion=ActualizarProducto" method="post" enctype="multipart/form-data">
                <input type="hidden" name="id" value="<%= producto.getId() %>">
                
                <div class="field">
                    <label class="label">Nombre:</label>
                    <div class="control">
                        <input class="input" type="text" name="txtNom" value="<%= producto.getNombre() %>" required>
                    </div>
                </div>

                <div class="field">
                    <label class="label">Foto actual:</label>
                    <img src="ControllerImg?id=<%= producto.getId() %>" alt="<%= producto.getNombre() %>" style="max-width: 200px;">
                </div>

                <div class="field">
                    <label class="label">Nueva Foto (opcional):</label>
                    <div class="file has-name is-fullwidth">
                        <label class="file-label">
                            <input class="file-input" type="file" name="fileFoto" id="fileFoto">
                            <span class="file-cta">
                                <span class="file-icon">
                                    <i class="fas fa-upload"></i>
                                </span>
                                <span class="file-label">
                                    Choose a file...
                                </span>
                            </span>
                            <span class="file-name">
                                No file chosen
                            </span>
                        </label>
                    </div>
                </div>

                <div class="field">
                    <label class="label">Descripción:</label>
                    <div class="control">
                        <textarea class="textarea" name="txtDesc" required><%= producto.getDescripcion() %></textarea>
                    </div>
                </div>

                <div class="field">
                    <label class="label">Precio:</label>
                    <div class="control">
                        <input class="input" type="number" step="0.01" name="numbPrecio" value="<%= producto.getPrecio() %>" required>
                    </div>
                </div>

                <div class="field">
                    <label class="label">Stock:</label>
                    <div class="control">
                        <input class="input" type="number" name="numbStock" value="<%= producto.getStock() %>" required>
                    </div>
                </div>

                <div class="field">
                    <label class="label">Categoría:</label>
                    <div class="control">
                        <input class="input" type="text" name="nomCat" value="<%= producto.getCat().getNombre() %>" required>
                    </div>
                </div>

                <div class="field is-grouped">
                    <div class="control">
                        <button class="button is-link" type="submit">Actualizar</button>
                    </div>
                    <div class="control">
                        <a class="button is-link is-light" href="prodcutosCRUD.jsp">Cancelar</a>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <script>
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