package logic;
import java.text.SimpleDateFormat;
import java.util.Calendar;
public class FechaHoy {
	public static Calendar calendar = Calendar.getInstance();
	private static String fecha;
	
	public FechaHoy() {		
	}
	
	public String FechaHoy() {	
		SimpleDateFormat sdf= new SimpleDateFormat("dd-MM-yyyy");
		fecha = sdf.format(calendar.getTime());
		return fecha;
	}
	
	public static String FechaBD() {
		SimpleDateFormat sdf= new SimpleDateFormat("yyyy-MM-dd");
		fecha = sdf.format(calendar.getTime());
		return fecha;
	}
}
