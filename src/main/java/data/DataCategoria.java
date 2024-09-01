package data;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

import entities.Categoria;



public class DataCategoria {
	
	public void add(Categoria cat) {
		PreparedStatement stmt= null;
		ResultSet keyResultSet=null;
		try {
			stmt=DbConnector.getInstancia().getConn().
					prepareStatement(
							"insert into categoria(nombre) values(?)",
							PreparedStatement.RETURN_GENERATED_KEYS
							);
			stmt.setString(1, cat.getNombre());
			stmt.executeUpdate();
			
			keyResultSet=stmt.getGeneratedKeys();
            if(keyResultSet!=null && keyResultSet.next()){
                cat.setId(keyResultSet.getInt(1));
            }

			
		} catch (SQLException e) {
            e.printStackTrace();
		} finally {
            try {
                if(keyResultSet!=null)keyResultSet.close();
                if(stmt!=null)stmt.close();
                DbConnector.getInstancia().releaseConn();
            } catch (SQLException e) {
            	e.printStackTrace();
            }
		}

	}
	
	public void update(Categoria cat) {
	    PreparedStatement stmt = null;
	    try {
	        stmt = DbConnector.getInstancia().getConn().prepareStatement(
	            "UPDATE categoria SET nombre = ? WHERE id = ?");
	        stmt.setString(1, cat.getNombre());
	        stmt.setInt(2, cat.getId());
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
	            "DELETE FROM categoria WHERE id = ?");
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
	
	public List<Categoria> getAll() {
	    List<Categoria> categorias = new ArrayList<>();
	    PreparedStatement stmt = null;
	    ResultSet rs = null;
	    try {
	        stmt = DbConnector.getInstancia().getConn().prepareStatement(
	            "SELECT * FROM categoria");
	        rs = stmt.executeQuery();
	        while (rs.next()) {
	            Categoria cat = new Categoria();
	            cat.setId(rs.getInt("id"));
	            cat.setNombre(rs.getString("nombre"));
	            categorias.add(cat);
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
	    return categorias;
	}
	
	public Categoria getById(int id) {
	    Categoria cat = null;
	    PreparedStatement stmt = null;
	    ResultSet rs = null;
	    try {
	        stmt = DbConnector.getInstancia().getConn().prepareStatement(
	            "SELECT * FROM categoria WHERE id = ?");
	        stmt.setInt(1, id);
	        rs = stmt.executeQuery();
	        if (rs.next()) {
	            cat = new Categoria();
	            cat.setId(rs.getInt("id"));
	            cat.setNombre(rs.getString("nombre"));
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
	    return cat;
	}
	
	public Categoria getByName(String nombre) {
	    Categoria cat = null;
	    PreparedStatement stmt = null;
	    ResultSet rs = null;
	    try {
	        stmt = DbConnector.getInstancia().getConn().prepareStatement(
	            "SELECT * FROM categoria WHERE nombre = ?");
	        stmt.setString(1, nombre);
	        rs = stmt.executeQuery();
	        if (rs.next()) {
	            cat = new Categoria();
	            cat.setId(rs.getInt("id"));
	            cat.setNombre(rs.getString("nombre"));
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
	    return cat;
	}
	
}
