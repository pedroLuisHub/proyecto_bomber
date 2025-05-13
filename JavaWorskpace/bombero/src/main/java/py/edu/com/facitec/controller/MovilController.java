package py.edu.com.facitec.controller;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import lombok.AllArgsConstructor;
import py.edu.com.facitec.model.Bombero;
import py.edu.com.facitec.model.Movil;
import py.edu.com.facitec.service.MovilService;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.PathVariable;


@RestController
@RequestMapping("/moviles")
@AllArgsConstructor
public class MovilController {

	
	private MovilService movilService;
	
	
	@GetMapping("/lista")
	public ResponseEntity<List<Movil>> listarMoviles() {
		List<Movil> list = movilService.listarMoviles();
		return ResponseEntity.ok(list);
	}

	
	@PostMapping("/insertar")
	public ResponseEntity<Movil> crearMovil(@RequestBody Movil movil) {
		return ResponseEntity.ok(movilService.guardarMovil(movil));
	}

	
	@PutMapping("/actualizar/{id_movil}")
	public ResponseEntity<Movil> actualizarMovil(
	        @PathVariable Integer id_movil,
	        @RequestBody Movil movil) {
	    // Establecer el ID del bombero recibido en el cuerpo al ID de la URL
	    movil.setId_movil(id_movil);
	    Movil movilActualizado = movilService.guardarMovil(movil);
	    return ResponseEntity.ok(movilActualizado);
	}
	
	
	@DeleteMapping("/eliminar/{id_movil}")
	public void eliminarMovil(@PathVariable Integer id_movil) {
	    movilService.eliminarMovil(id_movil);
	}
		
}
