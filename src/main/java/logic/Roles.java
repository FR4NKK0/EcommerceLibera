package logic;

import data.DataRol;
import entities.*;

public class Roles {
	private DataRol dr;
	
	public Roles() {
		dr = new DataRol();
	}
	
	public Rol validate(Rol r) {
		return dr.getById(r);
	}
	
	public void setRols(Persona p) {
		 dr.setRoles(p);
	}
}
