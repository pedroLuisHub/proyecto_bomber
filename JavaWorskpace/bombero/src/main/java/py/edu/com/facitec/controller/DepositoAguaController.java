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
import py.edu.com.facitec.dto.DepositoAguaDTO;
import py.edu.com.facitec.model.DepositoAgua;
import py.edu.com.facitec.service.DepositoAguaService;

@RestController
@RequestMapping("/depositos")
@AllArgsConstructor
public class DepositoAguaController {

	private final DepositoAguaService depositoAguaService;

	@GetMapping("/lista")
    public ResponseEntity<List<DepositoAguaDTO>> listarDepositos() {
        return ResponseEntity.ok(depositoAguaService.listarDepositos());
    }
//	@GetMapping("/lista")
//	public ResponseEntity<List<DepositoAgua>> listarDepositoAguas() {
//		List<DepositoAgua> list = depositoAguaService.listarDepositos();
//		return ResponseEntity.ok(list);
//	}

	
	@GetMapping("/{id_deposito}")
	public ResponseEntity<DepositoAgua> buscarPorId(@PathVariable Integer id_deposito_agua) {
	    Optional<DepositoAgua> depositoOpt = depositoAguaService.buscarPorId(id_deposito_agua);
	    if (depositoOpt.isPresent()) {
	        return ResponseEntity.ok(depositoOpt.get());
	    }
	    return ResponseEntity.notFound().build();
	}
	
	
	@PostMapping("/insertar")
	public ResponseEntity<DepositoAgua> crearDepositoAgua(@RequestBody DepositoAgua depositoAgua) {
		return ResponseEntity.ok(depositoAguaService.guardarDeposito(depositoAgua));
	}

	
	@DeleteMapping("/{id_deposito}")
	public void eliminarDepositoAgua(@PathVariable Integer id_deposito) {
	    depositoAguaService.eliminarDeposito(id_deposito);
	}
		
	
	@PutMapping("/actualizar/{id_deposito}")
	public ResponseEntity<DepositoAgua> actualizarDepositoAgua(
	        @PathVariable Integer id_deposito,
	        @RequestBody DepositoAgua depositoAgua) {
	    // Establecer el ID del deposito recibido en el cuerpo al ID de la URL
	    depositoAgua.setId_deposito_agua(id_deposito);
	    DepositoAgua depositoActualizado = depositoAguaService.guardarDeposito(depositoAgua);
	    return ResponseEntity.ok(depositoActualizado);
	}
	
	
}
