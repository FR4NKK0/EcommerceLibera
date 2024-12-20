package data;
import java.sql.PreparedStatement; 
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

import entities.*;

public class DataCompra {

    int r = 0;

    public int Pagar(double monto, int idtarjeta) {
        PreparedStatement stmt = null;
        try {
            stmt = DbConnector.getInstancia().getConn().prepareStatement("INSERT INTO pago(monto, idtarjeta) VALUES(?,?)");

            stmt.setDouble(1, monto);
            stmt.setInt(2, idtarjeta);

            r = stmt.executeUpdate();

        } catch (SQLException e) {
            System.err.println("Error " + e);
        } finally {
            if (stmt != null) {
                try {
                    stmt.close();
                } catch (SQLException e) {
                    System.err.println("Error al cerrar el PreparedStatement: " + e);
                }
            }
        }
        return r;
    }

    public Tarjeta GetTarjeta(String numero) {
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Tarjeta t = new Tarjeta();
        try {
            stmt = DbConnector.getInstancia().getConn().prepareStatement("SELECT * FROM tarjeta t WHERE numero=?");
            stmt.setString(1, numero);
            rs = stmt.executeQuery();
            while (rs.next()) {
                t.setId(rs.getInt(1));
                t.setNumero(rs.getString(2));
                t.setNombre(rs.getString(3));
                t.setFecha(rs.getString(4));
                t.setCodigo(rs.getString(5));
                t.setSaldo(rs.getDouble(6));
            }
        } catch (SQLException e) {
            System.err.println("Error " + e);
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {
                    System.err.println("Error al cerrar ResultSet: " + e);
                }
            }
            if (stmt != null) {
                try {
                    stmt.close();
                } catch (SQLException e) {
                    System.err.println("Error al cerrar PreparedStatement: " + e);
                }
            }
        }
        return t;
    }
    
    public Tarjeta GetTarjetaById(Tarjeta t) {
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            stmt = DbConnector.getInstancia().getConn().prepareStatement("SELECT * FROM tarjeta t WHERE id=?");
            stmt.setInt(1, t.getId());
            rs = stmt.executeQuery();
            while (rs.next()) {
                t.setId(rs.getInt(1));
                t.setNumero(rs.getString(2));
                t.setNombre(rs.getString(3));
                t.setFecha(rs.getString(4));
                t.setCodigo(rs.getString(5));
                t.setSaldo(rs.getDouble(6));
            }
        } catch (SQLException e) {
            System.err.println("Error " + e);
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {
                    System.err.println("Error al cerrar ResultSet: " + e);
                }
            }
            if (stmt != null) {
                try {
                    stmt.close();
                } catch (SQLException e) {
                    System.err.println("Error al cerrar PreparedStatement: " + e);
                }
            }
        }
        return t;
    }
    
    public void addTarjeta(Tarjeta t) {
    	PreparedStatement stmt = null;
    	try {
    		stmt = DbConnector.getInstancia().getConn().prepareStatement(
                    "INSERT INTO tarjeta (numero, nombre, fecha, cvv, saldo) VALUES (?, ?, ?, ?, ?)",
                    PreparedStatement.RETURN_GENERATED_KEYS);
            stmt.setString(1, t.getNumero());
            stmt.setString(2, t.getNombre());
            stmt.setString(3, t.getFecha());
            stmt.setString(4, t.getCodigo());
            stmt.setDouble(5, t.getSaldo());
            r = stmt.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Error " + e);
        } finally {
            if (stmt != null) {
                try {
                    stmt.close();
                } catch (SQLException e) {
                    System.err.println("Error al cerrar PreparedStatement: " + e);
                }
            }
        }
    }
    
    public int ActualizaSaldo(Double monto, int id) {
        PreparedStatement stmt = null;
        try {
            stmt = DbConnector.getInstancia().getConn().prepareStatement("UPDATE tarjeta set saldo=? where id=?");
            stmt.setDouble(1, monto);
            stmt.setInt(2, id);
            r = stmt.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Error al Guardar los Datos" + e);
        } finally {
            if (stmt != null) {
                try {
                    stmt.close();
                } catch (SQLException e) {
                    System.err.println("Error al cerrar PreparedStatement: " + e);
                }
            }
        }
        return r;
    }

    public int GetIdDelUltimoPago() {
        int idPago = 0;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            stmt = DbConnector.getInstancia().getConn().prepareStatement("SELECT max(id) FROM pago");
            rs = stmt.executeQuery();
            if (rs != null && rs.next()) {
                idPago = rs.getInt(1);
            }
        } catch (SQLException e) {
            System.err.println("Error " + e);
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {
                    System.err.println("Error al cerrar ResultSet: " + e);
                }
            }
            if (stmt != null) {
                try {
                    stmt.close();
                } catch (SQLException e) {
                    System.err.println("Error al cerrar PreparedStatement: " + e);
                }
            }
        }
        return idPago;
    }

    public int GenerarCompra(Compra compra) {
        PreparedStatement stmt = null;
        try {
            stmt = DbConnector.getInstancia().getConn().prepareStatement(
                    "INSERT INTO compra (idpersona, idpago, fecha, monto, estado) VALUES (?, ?, ?, ?, ?)",
                    PreparedStatement.RETURN_GENERATED_KEYS);
            stmt.setInt(1, compra.getPersona().getId());
            stmt.setInt(2, compra.getIdpago());
            stmt.setString(3, compra.getFecha());
            stmt.setDouble(4, compra.getMonto());
            stmt.setString(5, compra.getEstado());
            r = stmt.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Error " + e);
        } finally {
            if (stmt != null) {
                try {
                    stmt.close();
                } catch (SQLException e) {
                    System.err.println("Error al cerrar PreparedStatement: " + e);
                }
            }
        }
        return r;
    }

    public int guardarDetalle_compra(DetalleCompra dc) {
        PreparedStatement stmt = null;
        try {
            stmt = DbConnector.getInstancia().getConn().prepareStatement("INSERT INTO detalle_compra (idcompra, idproducto, cantidad, precio_compra) VALUES(?,?,?,?)");
            stmt.setInt(1, dc.getIdcompra());
            stmt.setInt(2, dc.getIdproducto());
            stmt.setInt(3, dc.getCantidad());
            stmt.setDouble(4, dc.getPrecioCompra());
            r = stmt.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Error " + e);
        } finally {
            if (stmt != null) {
                try {
                    stmt.close();
                } catch (SQLException e) {
                    System.err.println("Error al cerrar PreparedStatement: " + e);
                }
            }
        }
        return r;
    }

    public int getIdDeUltimaCompra() {
        int idC = 0;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            stmt = DbConnector.getInstancia().getConn().prepareStatement("SELECT MAX(id) from compra");
            rs = stmt.executeQuery();
            while (rs.next()) {
                idC = rs.getInt(1);
            }
        } catch (SQLException e) {
            System.err.println("Error " + e);
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {
                    System.err.println("Error al cerrar ResultSet: " + e);
                }
            }
            if (stmt != null) {
                try {
                    stmt.close();
                } catch (SQLException e) {
                    System.err.println("Error al cerrar PreparedStatement: " + e);
                }
            }
        }
        return idC;
    }
    
    
    public List<DetalleCompra> getDetalles(int idcompra){
    	List<DetalleCompra> detalles = new ArrayList<DetalleCompra>();
    	PreparedStatement stmt = null;
 	    ResultSet rs = null;
 	    try {
 	    	stmt = DbConnector.getInstancia().getConn().prepareStatement(
 		            "SELECT * FROM detalle_compra WHERE idcompra = ? order by iddetalle");
 	    	stmt.setInt(1, idcompra);
	        rs = stmt.executeQuery();
	        while (rs.next()) {
	            DetalleCompra detalle = new DetalleCompra();
	            detalle.setId(rs.getInt("iddetalle"));
	            detalle.setIdcompra(rs.getInt("idcompra"));
	            detalle.setIdproducto(rs.getInt("idproducto"));
	            detalle.setCantidad(rs.getInt("cantidad"));
	            detalle.setPrecioCompra(rs.getDouble("precio_compra"));
	            
	            detalles.add(detalle);
	        }
 	    }catch(Exception e) {
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
    	return detalles;
    }
    
    public List<Compra> getAll(){
    	List<Compra> compras= new ArrayList<Compra>();
    	PreparedStatement stmt = null;
 	    ResultSet rs = null;
        DataPersona personaDAO = new DataPersona();
 	   try {
	    	stmt = DbConnector.getInstancia().getConn().prepareStatement(
		            "SELECT * FROM compra order by fecha desc");
	        rs = stmt.executeQuery();
	        while (rs.next()) {
	            Compra comp = new Compra();
	            Persona per = new Persona();
	            comp.setId(rs.getInt("id"));
	            per.setId(rs.getInt("idpersona"));
	            per= personaDAO.getById(per);
	            System.out.println(per.getApellido());
	            comp.setPersona(per);
	            System.out.println(comp.getPersona().getApellido());
	            comp.setIdpago(rs.getInt("idpago"));
	            comp.setFecha(rs.getString("fecha"));
	            comp.setMonto(rs.getDouble("monto"));
	            comp.setEstado(rs.getString("estado"));
	            
	            compras.add(comp);
	        }
	    }catch(SQLException e) {
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
   	return compras;
   }
    
    public List<Compra> getMisCompras(int idpersona) {
    	List<Compra> misCompras = new ArrayList<Compra>();
    	PreparedStatement stmt = null;
 	    ResultSet rs = null;
 	    try {
 	    	stmt = DbConnector.getInstancia().getConn().prepareStatement(
 		            "SELECT id, idpago, fecha, monto, estado FROM compra WHERE idpersona = ? order by fecha desc");
 	    	stmt.setInt(1, idpersona);
	        rs = stmt.executeQuery();
	        while (rs.next()) {
	            Compra comp = new Compra();
	            comp.setId(rs.getInt("id"));
	            comp.setIdpago(rs.getInt("idpago"));
	            comp.setFecha(rs.getString("fecha"));
	            comp.setMonto(rs.getDouble("monto"));
	            comp.setEstado(rs.getString("estado"));
	            
	            misCompras.add(comp);
	        }
 	    }catch(SQLException e) {
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
    	return misCompras;
    }
    
    public void actualizaEstado(Compra comp) {
    	PreparedStatement stmt = null;
 	    ResultSet rs = null;
 	    try {
 	    	stmt = DbConnector.getInstancia().getConn().prepareStatement(
 		            "UPDATE compra SET estado=? WHERE id = ?");
 	    	stmt.setString(1, comp.getEstado());
 	    	stmt.setInt(2, comp.getId());
	        stmt.executeUpdate();	       
 	    }catch(SQLException e) {
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
    }
    
    public List<Pago> getAllPagos(){
    	List<Pago> pagos= new ArrayList<Pago>();
    	PreparedStatement stmt = null;
 	    ResultSet rs = null;
 	    DataCompra dc= new DataCompra();
 	   try {
	    	stmt = DbConnector.getInstancia().getConn().prepareStatement(
		            "SELECT * FROM pago order by id desc");
	        rs = stmt.executeQuery();
	        while (rs.next()) {
	            Pago p = new Pago();
	            Tarjeta t = new Tarjeta();
	            p.setId(rs.getInt("id"));
	            p.setMonto(rs.getDouble("monto"));
	            t.setId(rs.getInt("idtarjeta"));
	            t= dc.GetTarjetaById(t);
	            p.setTarjeta(t);
	            
	            pagos.add(p);
	        }
	    }catch(SQLException e) {
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
   	return pagos;
   }
    
}

