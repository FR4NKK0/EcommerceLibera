package entities;

public class Pago {
	private int id;
	private double monto;
	private Tarjeta tarjeta;
	
	public Pago() {		
	}
	
	public Pago(int id, double monto, Tarjeta tarjeta) {
		super();
		this.id = id;
		this.monto = monto;
		this.tarjeta= tarjeta;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public double getMonto() {
		return monto;
	}

	public void setMonto(double monto) {
		this.monto = monto;
	}

	public Tarjeta getTarjeta() {
		return tarjeta;
	}

	public void setTarjeta(Tarjeta tarjeta) {
		this.tarjeta = tarjeta;
	}
	
	
	
	
}
