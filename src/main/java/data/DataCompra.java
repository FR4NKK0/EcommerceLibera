package data;
import java.sql.PreparedStatement; 
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

import entities.Carrito;
import entities.*;

public class DataCompra {
	
	int r=0;
	
	public int GenerarCompra(Compra compra) {
		int idcompra;
		PreparedStatement stmt = null;
	    ResultSet rs = null;
	    try {
	    	stmt = DbConnector.getInstancia().getConn().prepareStatement(
		            "INSERT INTO compra (idpersona, idpago, fecha, monto, estado) VALUES (?, ?, ?, ?, ?)",
		            PreparedStatement.RETURN_GENERATED_KEYS);
	    	stmt.setInt(1, compra.getPersona().getId());
	    	stmt.setInt(2, compra.getIdpago());
	    	stmt.setString(3, compra.getFecha());
	    	stmt.setDouble(3, compra.getMonto());
	    	stmt.setString(5, compra.getEstado());
	    	r=stmt.executeUpdate();
	    	
	    	String sql="SELECT @@IDENTITY AS id";
	    	rs=stmt.executeQuery(sql);
	    	rs.next();
	    	idcompra=rs.getInt("id");
	    	rs.close();
	    	
	    	for(Carrito detalle : compra.getDetallecompras()){
	    		stmt = DbConnector.getInstancia().getConn().prepareStatement("INSERT INTO detalle_compra (idcompra, idproducto, cantidad, precio_compra) VALUES(?,?,?,?)",
	    				PreparedStatement.RETURN_GENERATED_KEYS);
	    		stmt.setInt(1, idcompra);
	    		stmt.setInt(2, detalle.getIdProducto());
	    		stmt.setInt(3, detalle.getCantidad());
	    		stmt.setDouble(4, detalle.getPrecioCompra());
	    		r=stmt.executeUpdate();
	    	}
	    }catch(SQLException e){
	    	
	    }
		return r;
	}
}
