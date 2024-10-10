package servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.IOException;
import java.io.InputStream;
import java.util.*;
import entities.*;
import data.*;


@MultipartConfig
public class Controller extends HttpServlet {
    private static final long serialVersionUID = 1L;
       
    private DataProducto dp = new DataProducto();
    private DataCategoria dc = new DataCategoria();
    private List<Carrito> listaCarrito = new ArrayList<>();
    int item;
    double totalPagar=0.0;
    int cantidad = 1;
    

    public Controller() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String accion = request.getParameter("accion");
        if (accion == null) {
            accion = "ListarCatalogo";
        }
        processRequest(request, response, accion);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String accion = request.getParameter("accion");
        if (accion == null) {
            accion = "ListarCatalogo";
        }
        processRequest(request, response, accion);
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response, String accion) throws ServletException, IOException {
        switch (accion) {
            case "ListarCatalogo":
                listarCatalogo(request, response);
                break;
            case "Listar":
                listarProductos(request, response);
                break;
            case "Edit":
                editarProducto(request, response);
                break;
            case "ActualizarProducto":
                actualizarProducto(request, response);
                break;
            case "Guardar":
                guardarProducto(request, response);
                break;
            case "Delete":
                eliminarProducto(request, response);
                break;
            case "AgregarCarrito":
            	agregarCarrito(request, response);
            	break;
            case "Carrito":
            	
            	break;
            default:
                listarCatalogo(request, response);
                break;
        }
    }

    private void listarCatalogo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Producto> catalogo = dp.getAll();
        request.setAttribute("productos", catalogo);
        request.getRequestDispatcher("index.jsp").forward(request, response);
    }

    private void listarProductos(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Producto> productos = dp.getAll();
        request.setAttribute("productos", productos);
        request.getRequestDispatcher("prodcutosCRUD.jsp").forward(request, response);
    }

    private void editarProducto(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            Producto producto = dp.getById(id);
            if (producto != null) {
                request.setAttribute("producto", producto);
                request.getRequestDispatcher("editarProducto.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Producto no encontrado.");
                listarProductos(request, response);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "ID de producto inválido.");
            listarProductos(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error al procesar la solicitud de edición.");
            listarProductos(request, response);
        }
    }

    private void actualizarProducto(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
            listarProductos(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Ocurrió un error al actualizar el producto.");
            request.getRequestDispatcher("editarProducto.jsp").forward(request, response);
        }
    }

    private void guardarProducto(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String nom = request.getParameter("txtNom");
            Part part = request.getPart("fileFoto");
            InputStream inputStream = part.getInputStream(); 
            String desc = request.getParameter("txtDesc");
            double precio = Double.parseDouble(request.getParameter("numbPrecio"));
            int stock = Integer.parseInt(request.getParameter("numbStock"));
            String nombreCat = request.getParameter("nomCat");

            Categoria cat = dc.getByName(nombreCat);
            if (cat != null) {
                Producto p = new Producto();
                p.setNombre(nom);
                p.setFoto(inputStream);
                p.setDescripcion(desc);
                p.setPrecio(precio);
                p.setStock(stock);
                p.setCat(cat);

                dp.add(p);
                listarProductos(request, response);
            } else {
                response.sendRedirect("error.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
    
    private void agregarCarrito(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	try {
    		int idp=Integer.parseInt(request.getParameter("id"));
    		Producto p = new Producto();
    		p=dp.getById(idp);
    		item=item+1;
    		Carrito car=new Carrito();
    		car.setItem(item);
    		car.setIdProducto(p.getId());
    		car.setNombres(p.getNombre());
    		car.setDescripcion(p.getDescripcion());
    		car.setPrecioCompra(p.getPrecio());
    		car.setCantidad(cantidad);
    		car.setSubTotal(cantidad*p.getPrecio());
    		listaCarrito.add(car);
    		request.setAttribute("contador", listaCarrito.size());
    		request.getRequestDispatcher("Controller?accion=ListarCatalogo").forward(request, response);
    	}catch(Exception e){
    		
    	}
    }
    
    private void eliminarProducto(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Implementar lógica de eliminación aquí
        listarProductos(request, response);
    }
}