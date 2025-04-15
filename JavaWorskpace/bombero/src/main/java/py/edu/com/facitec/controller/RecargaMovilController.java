package py.edu.com.facitec.controller;

import java.util.List;
import java.util.Optional;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
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
        RecargaMovil recargaGuardada = recargaMovilService.guardarRecargaMovil(recargaMovil);
        return ResponseEntity.status(HttpStatus.CREATED).body(recargaGuardada);
    }
 
    
    @PutMapping("actualizar/{id_recarga}")
    public ResponseEntity<RecargaMovil> actualizarRecargaMovil(@PathVariable Integer id, @RequestBody RecargaMovil recargaMovil) {
        Optional<RecargaMovil> recargaExistente = recargaMovilService.buscarPorId(id);
        if (recargaExistente.isEmpty()) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
        }
        recargaMovil.setId_recarga_movil(id); // Asegurar que el ID sea el mismo
        RecargaMovil recargaActualizada = recargaMovilService.guardarRecargaMovil(recargaMovil);
        return ResponseEntity.ok(recargaActualizada);
    }
    
}
