package py.edu.com.facitec.controller;

import java.util.List;
import java.util.Optional;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import py.edu.com.facitec.model.RecargaMovil;
import py.edu.com.facitec.service.RecargaMovilService;

@RestController
@RequestMapping("/recargas")
public class RecargaMovilController {

	private final RecargaMovilService recargaMovilService;

	public RecargaMovilController(RecargaMovilService recargaMovilService) {
		this.recargaMovilService = recargaMovilService;
	}

	@GetMapping("/listar")
	public ResponseEntity<List<RecargaMovil>> listarRecargas() {
		List<RecargaMovil> recargas = recargaMovilService.listarRecargas();
		return ResponseEntity.ok(recargas);
	}

	@PostMapping("/insertar")
	public ResponseEntity<RecargaMovil> crearRecargaMovil(@RequestBody RecargaMovil recargaMovil) {
		RecargaMovil nueva = recargaMovilService.guardarRecargaMovil(recargaMovil);
		return ResponseEntity.ok(nueva);
	}

	@PutMapping("/actualizar/{id_recarga_movil}")
	public ResponseEntity<RecargaMovil> actualizarRecarga(@PathVariable Integer id_recarga_movil,
			@RequestBody RecargaMovil recargaActualizada) {

		// Opción 1: buscar si la recarga existe
		return recargaMovilService.buscarPorId(id_recarga_movil).map(recargaExistente -> {
			// Actualizamos los campos
			recargaExistente.setDescripcion(recargaActualizada.getDescripcion());
			recargaExistente.setCantidad_litros(recargaActualizada.getCantidad_litros());
			recargaExistente.setBombero(recargaActualizada.getBombero());
			recargaExistente.setMovil(recargaActualizada.getMovil());
			recargaExistente.setDepositoAgua(recargaActualizada.getDepositoAgua());
			recargaExistente.setFecha_hora(recargaActualizada.getFecha_hora());

			RecargaMovil actualizada = recargaMovilService.guardarRecargaMovil(recargaExistente);
			return ResponseEntity.ok(actualizada);
		}).orElse(ResponseEntity.notFound().build());
	}

	@DeleteMapping("/eliminar/{id_recarga_movil}")
	public void eliminarRecargaMovil(@PathVariable Integer id_recarga_movil) {
		recargaMovilService.eliminarRecargaMovil(id_recarga_movil);
	}

}
