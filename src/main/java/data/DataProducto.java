package data;

import entities.*;


import jakarta.servlet.http.*;

import java.io.*;
import java.sql.*;
import java.util.*;

public class DataProducto {
	
	
	int r=0;
	
	public List<Producto> getAll() {
	    List<Producto> productos = new ArrayList<>();
	    PreparedStatement stmt = null;
	    ResultSet rs = null;
	    try {
	        stmt = DbConnector.getInstancia().getConn().prepareStatement(
	            "SELECT * FROM producto");
	        rs = stmt.executeQuery();
	        while (rs.next()) {
	            Producto prod = new Producto();
	            prod.setId(rs.getInt("id"));
	            prod.setNombre(rs.getString("nombre"));
	            prod.setFoto(rs.getBinaryStream("foto")); // Assuming foto is stored as a binary stream
	            prod.setDescripcion(rs.getString("descripcion"));
	            prod.setPrecio(rs.getDouble("precio"));
	            prod.setStock(rs.getInt("stock"));

	            // Load Categoria using DataCategoria.getById
	            DataCategoria dataCategoria = new DataCategoria();
	            Categoria categoria = dataCategoria.getById(rs.getInt("categoria_id"));
	            prod.setCat(categoria);
	            
	            productos.add(prod);
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        try {
	            if (rs != null) rs.close();
	            if (stmt != null) stmt.close();
	            DbConnector.getInstancia().releaseConn();
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }
	    return productos;
	}
	
	public void listarImg(int id, HttpServletResponse response) {
	    PreparedStatement stmt = null;
	    ResultSet rs = null;
	    InputStream inputStream = null;
	    OutputStream outputStream = null;
	    BufferedInputStream bufferedInputStream = null;
	    BufferedOutputStream bufferedOutputStream = null;    

	    try {
	        // Obtener el OutputStream de la respuesta
	        outputStream = response.getOutputStream();
	        

	        // Crear el PreparedStatement con la consulta SQL
	        stmt = DbConnector.getInstancia().getConn().prepareStatement(
	                "SELECT foto FROM producto WHERE id = ?");
	        

	        // Establecer el valor del parámetro
	        stmt.setInt(1, id);
	        

	        // Ejecutar la consulta
	        rs = stmt.executeQuery();
	        

	        // Procesar el ResultSet
	        if (rs != null && rs.next()) {
	            
	            inputStream = rs.getBinaryStream("foto");
	        } else {
	            System.out.println("No se encontraron datos para el ID proporcionado.");
	        }

	        // Asegurarse de que el inputStream no sea nulo antes de continuar
	        if (inputStream != null) {
	            bufferedInputStream = new BufferedInputStream(inputStream);
	            bufferedOutputStream = new BufferedOutputStream(outputStream);
	            int i;
	           
	            while ((i = bufferedInputStream.read()) != -1) {
	                bufferedOutputStream.write(i);
	            }
	            
	        } else {
	            System.out.println("InputStream es nulo, enviando error 404.");
	            response.sendError(HttpServletResponse.SC_NOT_FOUND); // Imagen no encontrada
	        }
	        
	    } catch (Exception e) {
	        System.err.println("Error al listar la imagen del producto: " + e.getMessage());
	        e.printStackTrace();

	    } finally {
	        try {
	            // Cerrar recursos si no son nulos
	            if (rs != null) {
	                rs.close();
	                
	            }
	            if (stmt != null) {
	                stmt.close();
	                
	            }
	            if (bufferedInputStream != null) {
	                bufferedInputStream.close();
	                
	            }
	            if (bufferedOutputStream != null) {
	                bufferedOutputStream.close();
	                
	            }
	            DbConnector.getInstancia().releaseConn();
	            System.out.println("Conexión liberada.");
	        } catch (SQLException e) {
	            System.err.println("Error al cerrar recursos de la base de datos: " + e.getMessage());
	            e.printStackTrace();
	        } catch (IOException e) {
	            System.err.println("Error al cerrar streams: " + e.getMessage());
	            e.printStackTrace();
	        }
	    }
	}


	
	public Producto getById(int id) {
	    Producto prod = null;
	    PreparedStatement stmt = null;
	    ResultSet rs = null;
	    try {
	        stmt = DbConnector.getInstancia().getConn().prepareStatement(
	            "SELECT * FROM producto WHERE id = ?");
	        stmt.setInt(1, id);
	        rs = stmt.executeQuery();
	        if (rs.next()) {
	            prod = new Producto();
	            prod.setId(rs.getInt("id"));
	            prod.setNombre(rs.getString("nombre"));
	            prod.setFoto(rs.getBinaryStream("foto")); // Assuming foto is stored as a binary stream
	            prod.setDescripcion(rs.getString("descripcion"));
	            prod.setPrecio(rs.getDouble("precio"));
	            prod.setStock(rs.getInt("stock"));

	            // Load Categoria using DataCategoria.getById
	            DataCategoria dataCategoria = new DataCategoria();
	            Categoria categoria = dataCategoria.getById(rs.getInt("categoria_id"));
	            prod.setCat(categoria);
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        try {
	            if (rs != null) rs.close();
	            if (stmt != null) stmt.close();
	            DbConnector.getInstancia().releaseConn();
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }
	    return prod;
	}

	
	public List<Producto> getByDesc(String descripcion) {
	    List<Producto> productos = new ArrayList<>();
	    PreparedStatement stmt = null;
	    ResultSet rs = null;
	    try {
	        stmt = DbConnector.getInstancia().getConn().prepareStatement(
	            "SELECT * FROM producto WHERE descripcion LIKE ?");
	        stmt.setString(1, "%" + descripcion + "%");
	        rs = stmt.executeQuery();
	        while (rs.next()) {
	            Producto prod = new Producto();
	            prod.setId(rs.getInt("id"));
	            prod.setNombre(rs.getString("nombre"));
	            prod.setFoto(rs.getBinaryStream("foto")); // Assuming foto is stored as a binary stream
	            prod.setDescripcion(rs.getString("descripcion"));
	            prod.setPrecio(rs.getDouble("precio"));
	            prod.setStock(rs.getInt("stock"));

	            // Load Categoria using DataCategoria.getById
	            DataCategoria dataCategoria = new DataCategoria();
	            Categoria categoria = dataCategoria.getById(rs.getInt("categoria_id"));
	            prod.setCat(categoria);
	            
	            productos.add(prod);
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        try {
	            if (rs != null) rs.close();
	            if (stmt != null) stmt.close();
	            DbConnector.getInstancia().releaseConn();
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }
	    return productos;
	}
	
	public List<Producto> getByName(String nombre) {
	    List<Producto> productos = new ArrayList<>();
	    PreparedStatement stmt = null;
	    ResultSet rs = null;
	    try {
	        stmt = DbConnector.getInstancia().getConn().prepareStatement(
	            "SELECT * FROM producto WHERE nombre LIKE ?");
	        stmt.setString(1, "%" + nombre + "%");
	        rs = stmt.executeQuery();
	        while (rs.next()) {
	            Producto prod = new Producto();
	            prod.setId(rs.getInt("id"));
	            prod.setNombre(rs.getString("nombre"));
	            prod.setFoto(rs.getBinaryStream("foto")); // Assuming foto is stored as a binary stream
	            prod.setDescripcion(rs.getString("descripcion"));
	            prod.setPrecio(rs.getDouble("precio"));
	            prod.setStock(rs.getInt("stock"));

	            // Load Categoria using DataCategoria.getById
	            DataCategoria dataCategoria = new DataCategoria();
	            Categoria categoria = dataCategoria.getById(rs.getInt("categoria_id"));
	            prod.setCat(categoria);
	            
	            productos.add(prod);
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        try {
	            if (rs != null) rs.close();
	            if (stmt != null) stmt.close();
	            DbConnector.getInstancia().releaseConn();
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }
	    return productos;
	}


	public List<Producto> getPorCat(int categoriaId) {
	    List<Producto> productos = new ArrayList<>();
	    PreparedStatement stmt = null;
	    ResultSet rs = null;
	    try {
	        stmt = DbConnector.getInstancia().getConn().prepareStatement(
	            "SELECT * FROM producto WHERE categoria_id = ?");
	        stmt.setInt(1, categoriaId);
	        rs = stmt.executeQuery();
	        while (rs.next()) {
	            Producto prod = new Producto();
	            prod.setId(rs.getInt("id"));
	            prod.setNombre(rs.getString("nombre"));
	            prod.setFoto(rs.getBinaryStream("foto")); // Assuming foto is stored as a binary stream
	            prod.setDescripcion(rs.getString("descripcion"));
	            prod.setPrecio(rs.getDouble("precio"));
	            prod.setStock(rs.getInt("stock"));

	            // Load Categoria using DataCategoria.getById
	            DataCategoria dataCategoria = new DataCategoria();
	            Categoria categoria = dataCategoria.getById(categoriaId);
	            prod.setCat(categoria);

	            productos.add(prod);
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        try {
	            if (rs != null) rs.close();
	            if (stmt != null) stmt.close();
	            DbConnector.getInstancia().releaseConn();
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }
	    return productos;
	}
	
	public void add(Producto prod) {
	    PreparedStatement stmt = null;
	    ResultSet keyResultSet = null;
	    try {
	        stmt = DbConnector.getInstancia().getConn().prepareStatement(
	            "INSERT INTO producto (nombre, foto, descripcion, precio, stock, categoria_id) VALUES (?, ?, ?, ?, ?, ?)",
	            PreparedStatement.RETURN_GENERATED_KEYS
	        );
	        stmt.setString(1, prod.getNombre());
	        stmt.setBlob(2, prod.getFoto()); // Assuming foto is stored as a Blob
	        stmt.setString(3, prod.getDescripcion());
	        stmt.setDouble(4, prod.getPrecio());
	        stmt.setInt(5, prod.getStock());
	        stmt.setInt(6, prod.getCat().getId()); // Assuming cat is a Categoria with an ID
	        stmt.executeUpdate();

	        keyResultSet = stmt.getGeneratedKeys();
	        if (keyResultSet != null && keyResultSet.next()) {
	            prod.setId(keyResultSet.getInt(1));
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        try {
	            if (keyResultSet != null) keyResultSet.close();
	            if (stmt != null) stmt.close();
	            DbConnector.getInstancia().releaseConn();
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }
	}
	
	public void update(Producto prod) {
	    PreparedStatement stmt = null;
	    try {
	        stmt = DbConnector.getInstancia().getConn().prepareStatement(
	            "UPDATE producto SET nombre = ?, foto = ?, descripcion = ?, precio = ?, stock = ?, categoria_id = ? WHERE id = ?");
	        stmt.setString(1, prod.getNombre());
	        stmt.setBlob(2, prod.getFoto()); // Assuming foto is stored as a Blob
	        stmt.setString(3, prod.getDescripcion());
	        stmt.setDouble(4, prod.getPrecio());
	        stmt.setInt(5, prod.getStock());
	        stmt.setInt(6, prod.getCat().getId()); // Assuming cat is a Categoria with an ID
	        stmt.setInt(7, prod.getId());
	        stmt.executeUpdate();
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        try {
	            if (stmt != null) stmt.close();
	            DbConnector.getInstancia().releaseConn();
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }
	}

	public void delete(int id) {
	    PreparedStatement stmt = null;
	    try {
	        stmt = DbConnector.getInstancia().getConn().prepareStatement(
	            "DELETE FROM producto WHERE id = ?");
	        stmt.setInt(1, id);
	        stmt.executeUpdate();
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        try {
	            if (stmt != null) stmt.close();
	            DbConnector.getInstancia().releaseConn();
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }
	}
	
	public int ActualizarStock(Producto p) {
		PreparedStatement stmt = null;
		try {
			stmt=DbConnector.getInstancia().getConn().prepareStatement("UPDATE producto set stock=stock-? WHERE id=?");
			stmt.setInt(1, p.getStock());
			stmt.setInt(2, p.getId());
			r=stmt.executeUpdate();
		}catch(SQLException e) {
			System.err.println("Error al actualizar Stock" + e);
		}
		return r;
	}

	


}
