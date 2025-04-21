package py.edu.com.facitec.controller;

import java.util.List;
import java.util.Optional;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import py.edu.com.facitec.dto.AbastecimientoDTO;
import py.edu.com.facitec.model.Abastecimiento;
import py.edu.com.facitec.model.RecargaMovil;
import py.edu.com.facitec.service.AbastecimientoService;

@RestController
@RequestMapping("/abastecimientos")
public class AbastecimientoController {

	private final AbastecimientoService abastecimientoService;

	public AbastecimientoController(AbastecimientoService abastecimientoService) {
		this.abastecimientoService = abastecimientoService;
	}

	@GetMapping("/listar")
	public ResponseEntity<List<Abastecimiento>> listarAbastecimientos() {
		List<Abastecimiento> abastecimientos = abastecimientoService.listarAbastecimientos();
		return ResponseEntity.ok(abastecimientos);
	}

	@PostMapping("/insertar")
	public ResponseEntity<Abastecimiento> crearAbastecimiento(@RequestBody Abastecimiento abastecimiento) {
		Abastecimiento abastecimientoGuardado = abastecimientoService.guardarAbastecimiento(abastecimiento);
		return ResponseEntity.status(HttpStatus.CREATED).body(abastecimientoGuardado);
	}

	@PutMapping("/actualizar/{id_abastecimiento}")
	public ResponseEntity<Abastecimiento> actualizarAbastecimiento(@PathVariable Integer id_abastecimiento,
			@RequestBody Abastecimiento abastecimientoActualizado) {
		return abastecimientoService.buscarPorId(id_abastecimiento).map(abastecimientoExistente -> {
			abastecimientoExistente.setCant_litros(abastecimientoActualizado.getCant_litros());
			abastecimientoExistente.setCant_viajes(abastecimientoActualizado.getCant_viajes());
			abastecimientoExistente.setDescripcion(abastecimientoActualizado.getDescripcion());
			abastecimientoExistente.setFecha_finalizacion(abastecimientoActualizado.getFecha_finalizacion());
			abastecimientoExistente.setFecha_finalizacion(abastecimientoActualizado.getFecha_inicio());
			abastecimientoExistente.setBombero(abastecimientoActualizado.getBombero());
			abastecimientoExistente.setDepositoAgua(abastecimientoActualizado.getDepositoAgua());
			abastecimientoExistente.setMovil(abastecimientoActualizado.getMovil());
			
			Abastecimiento actualizada = abastecimientoService.guardarAbastecimiento(abastecimientoExistente);
			return ResponseEntity.ok(actualizada);
		}).orElse(ResponseEntity.notFound().build());
		

		
	}

	@DeleteMapping("/eliminar/{id}")
	public ResponseEntity<Void> eliminarAbastecimiento(@PathVariable Integer id) {
		abastecimientoService.eliminarAbastecimiento(id);
		return ResponseEntity.noContent().build();
	}

	@ExceptionHandler(IllegalArgumentException.class)
	public ResponseEntity<String> handleIllegalArgumentException(IllegalArgumentException ex) {
		return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(ex.getMessage());
	}
}