package py.edu.com.facitec.controller;

import java.util.List;
import java.util.Optional;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import lombok.AllArgsConstructor;
import py.edu.com.facitec.model.Ciudadano;
import py.edu.com.facitec.service.CiudadanoService;

@RestController
@RequestMapping("/ciudadanos")
@AllArgsConstructor
public class CiudadanoController {

	private final CiudadanoService ciudadanoService;
	
	
	@GetMapping("/lista")
	public ResponseEntity<List<Ciudadano>> listarCiudadanos() {
		List<Ciudadano> list = ciudadanoService.listarCiudadanos();
		return ResponseEntity.ok(list);
	}

	
	
	@GetMapping("/{id_ciudadano}")
	public ResponseEntity<Ciudadano> buscarPorId(@PathVariable Integer id_ciudadano) {
	    Optional<Ciudadano> ciudadanoOpt = ciudadanoService.buscarPorId(id_ciudadano);
	    if (ciudadanoOpt.isPresent()) {
	        return ResponseEntity.ok(ciudadanoOpt.get());
	    }
	    return ResponseEntity.notFound().build();
	}
	
	
	@PostMapping("/insertar")
	public ResponseEntity<Ciudadano> crearCiudadano(@RequestBody Ciudadano ciudadano) {
		return ResponseEntity.ok(ciudadanoService.guardarCiudadano(ciudadano));
	}
	
	@DeleteMapping("/eliminar/{id_ciudadano}")
	public void eliminarCiudadano(@PathVariable Integer id_ciudadano) {
	    ciudadanoService.eliminarCiudadano(id_ciudadano);
	}
	
	
	@PutMapping("/actualizar/{id_ciudadano}")
	public ResponseEntity<Ciudadano> actualizarCiudadano(
	        @PathVariable Integer id_ciudadano,
	        @RequestBody Ciudadano ciudadano) {
	    // Establecer el ID del ciudadano recibido en el cuerpo al ID de la URL
	    ciudadano.setId_ciudadano(id_ciudadano);
	    Ciudadano ciudadanoActualizado = ciudadanoService.guardarCiudadano(ciudadano);
	    return ResponseEntity.ok(ciudadanoActualizado);
	}
}
