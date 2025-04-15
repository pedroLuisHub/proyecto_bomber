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
import py.edu.com.facitec.service.AbastecimientoService;

@RestController
@RequestMapping("/abastecimientos")
public class AbastecimientoController {

    private final AbastecimientoService abastecimientoService;

    public AbastecimientoController(AbastecimientoService abastecimientoService) {
        this.abastecimientoService = abastecimientoService;
    }

//    @GetMapping("/listar")
//    public ResponseEntity<List<AbastecimientoDTO>> listarAbastecimientos() {
//        List<AbastecimientoDTO> abastecimientos = abastecimientoService.listarAbastecimientos();
//        return ResponseEntity.ok(abastecimientos);
//    }
//
//    @GetMapping("/{id}")
//    public ResponseEntity<Abastecimiento> buscarPorId(@PathVariable Integer id) {
//        Optional<Abastecimiento> abastecimiento = abastecimientoService.buscarPorId(id);
//        return abastecimiento.map(ResponseEntity::ok)
//                            .orElseGet(() -> ResponseEntity.status(HttpStatus.NOT_FOUND).build());
//    }

    @PostMapping("/insertar")
    public ResponseEntity<Abastecimiento> crearAbastecimiento(@RequestBody Abastecimiento abastecimiento) {
        Abastecimiento abastecimientoGuardado = abastecimientoService.guardarAbastecimiento(abastecimiento);
        return ResponseEntity.status(HttpStatus.CREATED).body(abastecimientoGuardado);
    }

//    @PutMapping("/actualizar/{id_abastecimiento}")
//    public ResponseEntity<Abastecimiento> actualizarAbastecimiento(@PathVariable Integer id_abastecimiento, @RequestBody Abastecimiento abastecimiento) {
//        Optional<Abastecimiento> abastecimientoExistente = abastecimientoService.buscarPorId(id_abastecimiento);
//        if (abastecimientoExistente.isEmpty()) {
//            return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
//        }
//        abastecimiento.setId_abastecimiento(id_abastecimiento);
//        Abastecimiento abastecimientoActualizado = abastecimientoService.guardarAbastecimiento(abastecimiento);
//        return ResponseEntity.ok(abastecimientoActualizado);
//    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> eliminarAbastecimiento(@PathVariable Integer id) {
        abastecimientoService.eliminarAbastecimiento(id);
        return ResponseEntity.noContent().build();
    }

    @ExceptionHandler(IllegalArgumentException.class)
    public ResponseEntity<String> handleIllegalArgumentException(IllegalArgumentException ex) {
        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(ex.getMessage());
    }
}