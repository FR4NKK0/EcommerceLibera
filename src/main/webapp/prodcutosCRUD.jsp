<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" type="text/css" href="style/bulma.css">
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body class="center">
		<div>
		<h3>Agregar nuevo producto</h3>
		</div>
		<hr>
		<br>
		<form action="Controller" method="post" enctype="multipart/form-data">
		    <label>Nombre: </label>
		    <input type="text" name="txtNom">
		    <label>Foto: </label>
		    <input type="file" name="fileFoto">
		    <label>Descripcion: </label>
		    <input type="text" name="txtDesc">
		    <label>Precio: </label>
		    <input type="text" name="numbPrecio">
		    <label>Stock: </label>
		    <input type="text" name="numbStock">
		    <label>Categoria: </label>
		    <input type="text" name="idCat">
		    <input type="submit" name="accion" value="Guardar">
		    <input type="submit" name="accion" value="Regresar">
		</form>
</body>
</html>