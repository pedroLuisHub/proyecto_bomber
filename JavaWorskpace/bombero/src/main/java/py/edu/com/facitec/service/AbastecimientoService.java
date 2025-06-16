package py.edu.com.facitec.service;


import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;
import py.edu.com.facitec.model.Abastecimiento;
import py.edu.com.facitec.model.Bombero;
import py.edu.com.facitec.model.DepositoAgua;
import py.edu.com.facitec.model.Movil;
import py.edu.com.facitec.model.RecargaMovil;
import py.edu.com.facitec.repository.AbastecimientoRepository;
import py.edu.com.facitec.repository.BomberoRepository;
import py.edu.com.facitec.repository.DepositoAguaRepository;
import py.edu.com.facitec.repository.MovilRepository;


@Service
@AllArgsConstructor
public class AbastecimientoService {

    private final AbastecimientoRepository abastecimientoRepository;
    private final DepositoAguaRepository depositoAguaRepository;
    private final BomberoRepository bomberoRepository;
    private final MovilRepository movilRepository;
	private GenerarReporte generarReporte;
    
    
    
    public List<Abastecimiento> listarAbastecimientos(){
    	return abastecimientoRepository.findAll();
    }

    
	public Optional<Abastecimiento> buscarPorId(Integer id) {
        return abastecimientoRepository.findById(id);
    }
    
	public Abastecimiento actualizarAbastecimiento(Abastecimiento abastecimiento, Integer id_abastecimiento) {
		
		Abastecimiento actualizada = this.guardarAbastecimiento(abastecimiento);
		
		return actualizada;
			
	}
    
    
    // Guardar un abastecimiento
    public Abastecimiento guardarAbastecimiento(Abastecimiento abastecimiento) {

        // Buscar las entidades relacionadas
        DepositoAgua depositoAgua = depositoAguaRepository.findById(abastecimiento.getDepositoAgua().getId_deposito_agua())
                .orElseThrow(() -> new IllegalArgumentException("Depósito no encontrado con id: " + abastecimiento.getDepositoAgua().getId_deposito_agua()));
        Bombero bombero = bomberoRepository.findById(abastecimiento.getBombero().getId_bombero())
                .orElseThrow(() -> new IllegalArgumentException("Bombero no encontrado con id: " + abastecimiento.getBombero().getId_bombero()));
        Movil movil = movilRepository.findById(abastecimiento.getMovil().getId_movil())
                .orElseThrow(() -> new IllegalArgumentException("Móvil no encontrado con id: " + abastecimiento.getMovil().getId_movil()));

        // Establecer las relaciones
        abastecimiento.setDepositoAgua(depositoAgua);
        abastecimiento.setBombero(bombero);
        abastecimiento.setMovil(movil);

        return abastecimientoRepository.save(abastecimiento);
    }

    // Eliminar un abastecimiento por ID
    public void eliminarAbastecimiento(Integer id) {
        if (!abastecimientoRepository.existsById(id)) {
            throw new IllegalArgumentException("Abastecimiento no encontrado con id: " + id);
        }
        abastecimientoRepository.deleteById(id);
    }
    
	public ResponseEntity<?> reporteAbastecimiento(String timeOffSet, String fechaInicioString, String fechaFinalString) {

		  // Parsear como LocalDate primero
      LocalDate fechaInicioDate = LocalDate.parse(fechaInicioString);
      LocalDate fechaFinDate = LocalDate.parse(fechaFinalString);
      
      // Convertir a LocalDateTime
      LocalDateTime fechaInicio = fechaInicioDate.atStartOfDay();
      LocalDateTime fechaFin = fechaFinDate.atTime(23, 59, 59);

		List<Abastecimiento> abastecimientos = abastecimientoRepository.findByFechaBetween(fechaInicio, fechaFin);

		// String filtro = "Desde " + filtroDesde + " hasta " + filtroHasta;
		return generarReporte.crearReporte(timeOffSet, "", "ListadoAbastecimientos", abastecimientos);
	}
    
}