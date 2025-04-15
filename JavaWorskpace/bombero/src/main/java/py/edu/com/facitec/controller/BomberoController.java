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
import py.edu.com.facitec.model.Bombero;
import py.edu.com.facitec.service.BomberoService;

@RestController
@RequestMapping("/bomberos")
@AllArgsConstructor
public class BomberoController {

	private final BomberoService bomberoService;

	@GetMapping("/lista")
	public ResponseEntity<List<Bombero>> listarBomberos() {
		List<Bombero> list = bomberoService.listarBomberos();
		return ResponseEntity.ok(list);
	}

	
	@GetMapping("/{id_bombero}")
	public ResponseEntity<Bombero> buscarPorId(@PathVariable Long id_bombero) {
	    Optional<Bombero> bomberoOpt = bomberoService.buscarPorId(id_bombero);
	    if (bomberoOpt.isPresent()) {
	        return ResponseEntity.ok(bomberoOpt.get());
	    }
	    return ResponseEntity.notFound().build();
	}
	
	
	@PostMapping("/insertar")
	public ResponseEntity<Bombero> crearBombero(@RequestBody Bombero bombero) {
		return ResponseEntity.ok(bomberoService.guardarBombero(bombero));
	}

	
	@DeleteMapping("/{id_bombero}")
	public void eliminarBombero(@PathVariable Long id_bombero) {
	    bomberoService.eliminarBombero(id_bombero);
	}
		
	
	@PutMapping("/actualizar/{id_bombero}")
	public ResponseEntity<Bombero> actualizarBombero(
	        @PathVariable Long id_bombero,
	        @RequestBody Bombero bombero) {
	    // Establecer el ID del bombero recibido en el cuerpo al ID de la URL
	    bombero.setId_bombero(id_bombero);
	    Bombero bomberoActualizado = bomberoService.guardarBombero(bombero);
	    return ResponseEntity.ok(bomberoActualizado);
	}
	}