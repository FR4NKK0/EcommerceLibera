package servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.InputStream;
import java.util.*;
import entities.*;
import data.*;
import jakarta.servlet.http.Part;


/**
 * Servlet implementation class Controller
 */
@MultipartConfig
public class Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	DataProducto dp= new DataProducto();
	List<Producto> productos = new ArrayList<Producto>();
	Producto p= new Producto();
	DataCategoria dc= new DataCategoria();
	
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
		if (accion != null) {
		switch (accion) {
			case "Listar":
				List<Producto> productos=dp.getAll();
				request.setAttribute("productos", productos);
				request.getRequestDispatcher("prodcutosCRUD.jsp").forward(request, response);
				break;
			case "ListarCatalogo":
				List<Producto> catalogo=dp.getAll();
				request.setAttribute("productos", catalogo);
				request.getRequestDispatcher("index.jsp").forward(request, response);
				break;
			case "Delete":
	            // Redirigir a productosCRUD.jsp
	            request.getRequestDispatcher("prodcutosCRUD.jsp").forward(request, response);
	            
	            break;
			case "Edit":
				try {
                    int id = Integer.parseInt(request.getParameter("id"));
                    Producto producto = dp.getById(id);
                    if (producto != null) {
                        request.setAttribute("producto", producto);
                        request.getRequestDispatcher("editarProducto.jsp").forward(request, response);
                    } else {
                        request.setAttribute("error", "Producto no encontrado.");
                        request.getRequestDispatcher("prodcutosCRUD.jsp").forward(request, response);
                    }
                } catch (NumberFormatException e) {
                    request.setAttribute("error", "ID de producto inválido.");
                    request.getRequestDispatcher("prodcutosCRUD.jsp").forward(request, response);
                } catch (Exception e) {
                    e.printStackTrace();
                    request.setAttribute("error", "Error al procesar la solicitud de edición.");
                    request.getRequestDispatcher("prodcutosCRUD.jsp").forward(request, response);
                }
                break;
			case "ActualizarProducto":
				try {
                    int idProducto = Integer.parseInt(request.getParameter("id"));
                    String nombre = request.getParameter("txtNom");
                    String descripcion = request.getParameter("txtDesc");
                    double precio = Double.parseDouble(request.getParameter("numbPrecio"));
                    int stock = Integer.parseInt(request.getParameter("numbStock"));
                    String nombreCat = request.getParameter("nomCat");

                    Producto productoActualizar = dp.getById(idProducto);
                    productoActualizar.setNombre(nombre);
                    productoActualizar.setDescripcion(descripcion);
                    productoActualizar.setPrecio(precio);
                    productoActualizar.setStock(stock);

                    Categoria cat = dc.getByName(nombreCat);
                    if (cat != null) {
                        productoActualizar.setCat(cat);
                    }

                    Part filePart = request.getPart("fileFoto");
                    if (filePart != null && filePart.getSize() > 0) {
                        if (filePart.getContentType().startsWith("image/")) {
                            InputStream inputStream = filePart.getInputStream();
                            productoActualizar.setFoto(inputStream);
                        } else {
                            request.setAttribute("error", "Por favor, sube solo archivos de imagen.");
                            request.getRequestDispatcher("editarProducto.jsp").forward(request, response);
                            return;
                        }
                    }

                    dp.update(productoActualizar);
                    request.getRequestDispatcher("prodcutosCRUD.jsp").forward(request, response);
                    
                } catch (Exception e) {
                    e.printStackTrace();
                    request.setAttribute("error", "Ocurrió un error al actualizar el producto.");
                    request.getRequestDispatcher("editarProducto.jsp").forward(request, response);
                }
                break;
			case "Guardar":
				try {
                    // Obtener los parámetros del formulario
                    String nom = request.getParameter("txtNom");

                    Part part = request.getPart("fileFoto");
                    InputStream inputStream = part.getInputStream(); 

                    String desc = request.getParameter("txtDesc");
                    double precio = Double.parseDouble(request.getParameter("numbPrecio"));
                    int stock = Integer.parseInt(request.getParameter("numbStock"));
                    String nombreCat = request.getParameter("nomCat");
                    //int idcat = Integer.parseInt(request.getParameter("idCat"));

                    Categoria cat = new Categoria();
                    cat.setNombre(nombreCat);
                    cat= dc.getByName(cat.getNombre());
                    
                    if (cat != null) {
                    Producto p = new Producto();
                    p.setNombre(nom);
                    p.setFoto(inputStream);
                    p.setDescripcion(desc);
                    p.setPrecio(precio);
                    p.setStock(stock);
                    p.setCat(cat);

                    // Guardar el producto en la base de datos           
                    dp.add(p);
                    // Redirigir después de guardar
                    
                    request.getRequestDispatcher("Controller?accion=Listar").forward(request, response);}
                    else {response.sendRedirect("error.jsp");}
                } catch (Exception e) {
                    e.printStackTrace();
                    response.sendRedirect("error.jsp"); // Página de error si algo falla
                }
                break;
			case "Regresar":
				try {
					response.sendRedirect("index.jsp");
					break;
				}catch(Exception e){
					e.printStackTrace();
					response.sendRedirect("error.jsp");
				}
	        // Agrega casos adicionales si es necesario
	        default:
	            // Redirige a una página de error o a la página principal si la acción no está definida
	            response.sendRedirect("index.jsp");
	            break;
		
		}
		} else {
			accion = "ListarCatalogo";
		}
	}

}
