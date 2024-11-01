package entities;

public class DetalleCompra {
	 int id;
	    int idcompra;
	    int idproducto;
	    int cantidad;
	    double precioCompra;
	    

	    public DetalleCompra() {
	    }

	    public DetalleCompra(int id, int idcompra, int idproducto, int cantidad, double precioCompra) {
	        this.id = id;
	        this.idcompra = idcompra;
	        this.idproducto = idproducto;
	        this.cantidad = cantidad;
	        this.precioCompra = precioCompra;
	    }

	    public int getId() {
	        return id;
	    }

	    public void setId(int id) {
	        this.id = id;
	    }

	    public int getIdcompra() {
	        return idcompra;
	    }

	    public void setIdcompra(int idcompra) {
	        this.idcompra = idcompra;
	    }

	    public int getIdproducto() {
	        return idproducto;
	    }

	    public void setIdproducto(int idproducto) {
	        this.idproducto = idproducto;
	    }

	    public int getCantidad() {
	        return cantidad;
	    }

	    public void setCantidad(int cantidad) {
	        this.cantidad = cantidad;
	    }

	    public double getPrecioCompra() {
	        return precioCompra;
	    }

	    public void setPrecioCompra(double precioCompra) {
	        this.precioCompra = precioCompra;
	    }

}
