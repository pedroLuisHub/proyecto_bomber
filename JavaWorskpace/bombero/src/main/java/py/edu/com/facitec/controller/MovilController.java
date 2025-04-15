package py.edu.com.facitec.controller;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import lombok.AllArgsConstructor;
import py.edu.com.facitec.model.Movil;
import py.edu.com.facitec.service.MovilService;

@RestController
@RequestMapping("/movil")
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

	
}
