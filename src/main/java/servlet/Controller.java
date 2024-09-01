package servlet;

import jakarta.servlet.ServletException;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.InputStream;
import java.util.*;
import entities.*;
import data.DataProducto;
import jakarta.servlet.http.Part;


/**
 * Servlet implementation class Controller
 */
public class Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	DataProducto dp= new DataProducto();
	List<Producto> productos = new ArrayList<Producto>();
	Producto p= new Producto();
	
	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
		throws ServletException, IOException{
		String accion=request.getParameter("accion");
		productos=dp.getAll();
		switch (accion) {
			case "ejemplo":
			
				break;
			case "Nuevo":
				request.getRequestDispatcher("prodcutosCRUD.jsp");
				break;
			case "Home":
				request.getRequestDispatcher("prodcutosCRUD.jsp");
			default:
				request.setAttribute("productos", productos);
				request.getRequestDispatcher("index.jsp").forward(request, response);
		
		}
	}
	
    public Controller() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String accion=request.getParameter("accion");
		System.out.println(accion);
		switch (accion) {
			case "ejemplo":
				break;
			case "Nuevo":
	            // Redirigir a productosCRUD.jsp
	            request.getRequestDispatcher("prodcutosCRUD.jsp").forward(request, response);
	            break;
			case "Guardar":
				try {
					System.out.println("Entre a guardar");
                    // Obtener los parámetros del formulario
                    String nom = request.getParameter("txtNom");

                    Part part = request.getPart("fileFoto");
                    InputStream inputStream = part.getInputStream();

                    String desc = request.getParameter("txtDesc");
                    double precio = Double.parseDouble(request.getParameter("numbPrecio"));
                    int stock = Integer.parseInt(request.getParameter("numbStock"));
                    int idcat = Integer.parseInt(request.getParameter("idCat"));

                    Categoria cat = new Categoria();
                    cat.setId(idcat);

                    Producto p = new Producto();
                    p.setNombre(nom);
                    p.setFoto(inputStream);
                    p.setDescripcion(desc);
                    p.setPrecio(precio);
                    p.setStock(stock);
                    p.setCat(cat);

                    // Guardar el producto en la base de datos
                    System.out.println("antes del add");
                    dp.add(p);
                    System.out.println("despues del add");
                    // Redirigir después de guardar
                    request.getRequestDispatcher("Controller?accion=Nuevo").forward(request, response);
                } catch (Exception e) {
                    e.printStackTrace();
                    response.sendRedirect("error.jsp"); // Página de error si algo falla
                }
                break;
	        // Agrega casos adicionales si es necesario
	        default:
	            // Redirige a una página de error o a la página principal si la acción no está definida
	            response.sendRedirect("index.jsp");
	            break;
		
		}
	}

}
