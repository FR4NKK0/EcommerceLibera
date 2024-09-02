package servlet;

import jakarta.servlet.ServletException;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.*;

import data.*;
import entities.*;

/**
 * Servlet implementation class ControllerImg
 */
public class ControllerImg extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private DataProducto dp= new DataProducto();
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ControllerImg() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		try {
			if(request.getParameter("id")!="") {
				int id = Integer.parseInt(request.getParameter("id"));
				dp.listarImg(id, response);}
			else {
				response.getWriter().write("No se ha proporcionado un ID válido o no hay productos cargados.");
			}
		} catch(Exception e){
			 e.printStackTrace();
		       response.getWriter().write("Ocurrió un error al procesar la solicitud.");
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
