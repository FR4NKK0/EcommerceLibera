package data;

import entities.*;


import java.sql.*;
import java.util.LinkedList;
//import java.util.Scanner;

public class DataPersona {
	
	public LinkedList<Persona> getAll(){
		DataRol dr=new DataRol();
		Statement stmt=null;
		ResultSet rs=null;
		LinkedList<Persona> pers= new LinkedList<>();
		
		try {
			stmt= DbConnector.getInstancia().getConn().createStatement();
			rs= stmt.executeQuery("select id,nombre,apellido,tipo_doc,nro_doc,email,tel,habilitado from persona");
			//intencionalmente no se recupera la password
			if(rs!=null) {
				while(rs.next()) {
					Persona p=new Persona();
					p.setDocumento(new Documento());
					p.setId(rs.getInt("id"));
					p.setNombre(rs.getString("nombre"));
					p.setApellido(rs.getString("apellido"));
					p.getDocumento().setTipo(rs.getString("tipo_doc"));
					p.getDocumento().setNro(rs.getString("nro_doc"));
					p.setEmail(rs.getString("email"));
					p.setTel(rs.getString("tel"));
					
					p.setHabilitado(rs.getBoolean("habilitado"));
					
					dr.setRoles(p);
					
					pers.add(p);
				}
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
			
		} finally {
			try {
				if(rs!=null) {rs.close();}
				if(stmt!=null) {stmt.close();}
				DbConnector.getInstancia().releaseConn();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		
		return pers;
	}
	
	public Persona getByUser(Persona per) {
		DataRol dr=new DataRol();
		Persona p=null;
		PreparedStatement stmt=null;
		ResultSet rs=null;
		try {
			stmt=DbConnector.getInstancia().getConn().prepareStatement(
					"select id,nombre,apellido,tipo_doc,nro_doc,email,tel,habilitado from persona where email=? and password=?"
					);
			stmt.setString(1, per.getEmail());
			stmt.setString(2, per.getPassword());
			rs=stmt.executeQuery();
			if(rs!=null && rs.next()) {
				p=new Persona();
				p.setDocumento(new Documento());
				p.setId(rs.getInt("id"));
				p.setNombre(rs.getString("nombre"));
				p.setApellido(rs.getString("apellido"));
				p.getDocumento().setTipo(rs.getString("tipo_doc"));
				p.getDocumento().setNro(rs.getString("nro_doc"));
				p.setEmail(rs.getString("email"));
				p.setTel(rs.getString("tel"));
				p.setHabilitado(rs.getBoolean("habilitado"));
				//
				dr.setRoles(p);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs!=null) {rs.close();}
				if(stmt!=null) {stmt.close();}
				DbConnector.getInstancia().releaseConn();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return p;
	}
	
	public Persona getByDocumento(Persona per) {
		DataRol dr=new DataRol();
		Persona p=null;
		PreparedStatement stmt=null;
		ResultSet rs=null;
		try {
			stmt=DbConnector.getInstancia().getConn().prepareStatement(
					"select id,nombre,apellido,tipo_doc,nro_doc,email,tel,habilitado from persona where tipo_doc=? and nro_doc=?"
					);
			stmt.setString(1, per.getDocumento().getTipo());
			stmt.setString(2, per.getDocumento().getNro());
			rs=stmt.executeQuery();
			if(rs!=null && rs.next()) {
				p=new Persona();
				p.setDocumento(new Documento());
				p.setId(rs.getInt("id"));
				p.setNombre(rs.getString("nombre"));
				p.setApellido(rs.getString("apellido"));
				p.getDocumento().setTipo(rs.getString("tipo_doc"));
				p.getDocumento().setNro(rs.getString("nro_doc"));
				p.setEmail(rs.getString("email"));
				p.setTel(rs.getString("tel"));
				p.setHabilitado(rs.getBoolean("habilitado"));
				//
				dr.setRoles(p);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs!=null) {rs.close();}
				if(stmt!=null) {stmt.close();}
				DbConnector.getInstancia().releaseConn();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return p;
	}
	
	public Persona getByEmail(Persona p) {
	    PreparedStatement stmt = null;
	    ResultSet rs = null;
	    Persona persona = null;

	    try {
	        stmt = DbConnector.getInstancia().getConn().prepareStatement(
	            "SELECT * FROM persona WHERE email = ?"
	        );
	        stmt.setString(1, p.getEmail());
	        rs = stmt.executeQuery();

	        if (rs != null && rs.next()) {
	            persona = new Persona();
	            persona.setId(rs.getInt("id"));
	            persona.setNombre(rs.getString("nombre"));
	            persona.setApellido(rs.getString("apellido"));
	            persona.setEmail(rs.getString("email"));
	            persona.setTel(rs.getString("tel"));
	            persona.setHabilitado(rs.getBoolean("habilitado"));
	            // Aquí puedes completar el mapeo de los demás atributos de Persona si es necesario
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

	    return persona;
	}
	
	public LinkedList <Persona> getByApellido(String ape) {
		DataRol dr=new DataRol();
		Persona p=null;
		PreparedStatement stmt=null;
		ResultSet rs=null;
		LinkedList<Persona> pers= new LinkedList<>();
		try {
			stmt=DbConnector.getInstancia().getConn().prepareStatement(
					"select id,nombre,apellido,tipo_doc,nro_doc,email,tel,habilitado from persona where apellido=?"
					);
			stmt.setString(1, ape);
			rs=stmt.executeQuery();
			if(rs!=null) {
				while(rs.next()) {
					p=new Persona();
					p.setDocumento(new Documento());
					p.setId(rs.getInt("id"));
					p.setNombre(rs.getString("nombre"));
					p.setApellido(rs.getString("apellido"));
					p.getDocumento().setTipo(rs.getString("tipo_doc"));
					p.getDocumento().setNro(rs.getString("nro_doc"));
					p.setEmail(rs.getString("email"));
					p.setTel(rs.getString("tel"));
					p.setHabilitado(rs.getBoolean("habilitado"));
					//
					dr.setRoles(p);
					pers.add(p);
					
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs!=null) {rs.close();}
				if(stmt!=null) {stmt.close();}
				DbConnector.getInstancia().releaseConn();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return pers;
	}
	
	public Persona add(Persona p) {
	    PreparedStatement stmt = null;
	    ResultSet keyResultSet = null;
	    int idPersona = -1;

	    try {
	        // Validar que no exista una persona con el mismo email
	        if (getByEmail(p) != null) {
	            throw new SQLException("Ya existe una persona con el email: " + p.getEmail());
	        }

	        // Validar que no exista una persona con el mismo número de documento
	        if (getByDocumento(p) != null) {
	            throw new SQLException("Ya existe una persona con el número de documento: " + p.getDocumento().getNro());
	        }

	        // Insertar la persona en la base de datos
	        stmt = DbConnector.getInstancia().getConn().prepareStatement(
	            "INSERT INTO persona(nombre, apellido, tipo_doc, nro_doc, email, password, tel, habilitado) VALUES (?, ?, ?, ?, ?, ?, ?, ?)",
	            PreparedStatement.RETURN_GENERATED_KEYS
	        );

	        // Setear los valores en el statement
	        stmt.setString(1, p.getNombre());
	        stmt.setString(2, p.getApellido());
	        stmt.setString(3, p.getDocumento().getTipo());
	        stmt.setString(4, p.getDocumento().getNro());
	        stmt.setString(5, p.getEmail());
	        stmt.setString(6, p.getPassword());
	        stmt.setString(7, p.getTel());
	        stmt.setBoolean(8, p.isHabilitado());

	        // Ejecutar la inserción
	        stmt.executeUpdate();

	        // Obtener el ID generado para la persona
	        keyResultSet = stmt.getGeneratedKeys();
	        if (keyResultSet != null && keyResultSet.next()) {
	            idPersona = keyResultSet.getInt(1);
	            p.setId(idPersona);
	        }

	        // Insertar los roles de la persona en la tabla rol_persona
	        if (p.roles != null && !p.roles.isEmpty()) {
	            stmt = DbConnector.getInstancia().getConn().prepareStatement(
	                "INSERT INTO rol_persona(id_persona, id_rol) VALUES (?, ?)"
	            );
	            for (Integer idRol : p.roles.keySet()) {
	                stmt.setInt(1, idPersona); // ID de la persona recién generada
	                stmt.setInt(2, idRol); // ID del rol
	                stmt.executeUpdate();
	            }
	        }

	    } catch (SQLException e) {
	        e.printStackTrace();
	        // Aquí se podría manejar el error de una forma más específica, como lanzarlo a capas superiores para informar al usuario
	    } finally {
	        // Cerrar los recursos
	        try {
	            if (keyResultSet != null) keyResultSet.close();
	            if (stmt != null) stmt.close();
	            DbConnector.getInstancia().releaseConn();
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }

	    return p;
	}


	 

	
	public Persona put(Persona p) {
		PreparedStatement stmt= null;
		try {
			stmt=DbConnector.getInstancia().getConn().
					prepareStatement(
							"UPDATE persona SET nombre=?, apellido=?, tipo_doc=?, nro_doc=?, email=?, password=?, tel=?, habilitado=? WHERE id=?");
			stmt.setString(1, p.getNombre());
			stmt.setString(2, p.getApellido());
			stmt.setString(3, p.getDocumento().getTipo());
			stmt.setString(4, p.getDocumento().getNro());
			stmt.setString(5, p.getEmail());
			stmt.setString(6, p.getPassword());
			stmt.setString(7, p.getTel());
			stmt.setBoolean(8, p.isHabilitado());
			stmt.setInt(9, p.getId());
			stmt.executeUpdate();
		} catch (SQLException e) {
            e.printStackTrace();
		} finally {
            try {
                if(stmt!=null)stmt.close();
                DbConnector.getInstancia().releaseConn();
            } catch (SQLException e) {
            	e.printStackTrace();
            }
		}
	return p;	
	}
	
	public Persona delete(Persona p) {
		PreparedStatement stmt= null;
		try {
			stmt=DbConnector.getInstancia().getConn().
					prepareStatement(
							"DELETE FROM persona WHERE id=?");
			stmt.setInt(1, p.getId());
			stmt.executeUpdate();
		} catch (SQLException e) {
            e.printStackTrace();
		} finally {
            try {
                if(stmt!=null)stmt.close();
                DbConnector.getInstancia().releaseConn();
            } catch (SQLException e) {
            	e.printStackTrace();
            }
		}
	return p;	
	}
		
		

	
}
