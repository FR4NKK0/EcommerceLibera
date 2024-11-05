package data;
import java.sql.PreparedStatement; 
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

import entities.Carrito;
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
}

