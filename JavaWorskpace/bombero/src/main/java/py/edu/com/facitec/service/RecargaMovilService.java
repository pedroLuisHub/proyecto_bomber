package py.edu.com.facitec.service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;
import py.edu.com.facitec.dto.RecargaDTO;
import py.edu.com.facitec.model.Bombero;
import py.edu.com.facitec.model.DepositoAgua;
import py.edu.com.facitec.model.Movil;
import py.edu.com.facitec.model.RecargaMovil;
import py.edu.com.facitec.repository.BomberoRepository;
import py.edu.com.facitec.repository.DepositoAguaRepository;
import py.edu.com.facitec.repository.MovilRepository;
import py.edu.com.facitec.repository.RecargaMovilRepository;

@Service
@AllArgsConstructor
public class RecargaMovilService {

	private RecargaMovilRepository recargaMovilRepository;
	private DepositoAguaRepository depositoAguaRepository;
	private MovilRepository movilRepository;
	private BomberoRepository bomberoRepository;
	private GenerarReporte generarReporte;

	public List<RecargaDTO> listarRecargas() {
		return recargaMovilRepository.findAll().stream()
				.map(recarga -> new RecargaDTO(recarga.getId_recarga_movil(), recarga.getFecha_hora(),
						recarga.getDescripcion(), recarga.getCantidad_litros(), recarga.getMovil(),
						recarga.getBombero(), recarga.getDepositoAgua()))
				.collect(Collectors.toList());
	}

	public RecargaMovil guardarRecargaMovil(RecargaMovil recargaMovil) {

		DepositoAgua depositoAgua = depositoAguaRepository
				.findById(recargaMovil.getDepositoAgua().getId_deposito_agua())
				.orElseThrow(() -> new IllegalArgumentException(
						"Depósito no encontrado con id: " + recargaMovil.getDepositoAgua().getId_deposito_agua()));
		Bombero bombero = bomberoRepository.findById(recargaMovil.getBombero().getId_bombero())
				.orElseThrow(() -> new IllegalArgumentException(
						"Bombero no encontrado con id: " + recargaMovil.getBombero().getId_bombero()));
		Movil movil = movilRepository.findById(recargaMovil.getMovil().getId_movil())
				.orElseThrow(() -> new IllegalArgumentException(
						"Móvil no encontrado con id: " + recargaMovil.getMovil().getId_movil()));

		// Establecer las relaciones
		recargaMovil.setDepositoAgua(depositoAgua);
		recargaMovil.setBombero(bombero);
		recargaMovil.setMovil(movil);

		return recargaMovilRepository.save(recargaMovil);
	}

	public Optional<RecargaMovil> buscarPorId(Integer id) {
		return recargaMovilRepository.findById(id);
	}

	public void eliminarRecargaMovil(Integer id) {
		if (!recargaMovilRepository.existsById(id)) {
			throw new IllegalArgumentException("Recarga no encontrada con id: " + id);
		}
		recargaMovilRepository.deleteById(id);
	}

	public ResponseEntity<?> reporteRecarga(String timeOffSet, String fechaInicioString, String fechaFinalString) {

		  // Parsear como LocalDate primero
        LocalDate fechaInicioDate = LocalDate.parse(fechaInicioString);
        LocalDate fechaFinDate = LocalDate.parse(fechaFinalString);
        
        // Convertir a LocalDateTime
        LocalDateTime fechaInicio = fechaInicioDate.atStartOfDay();
        LocalDateTime fechaFin = fechaFinDate.atTime(23, 59, 59);

		List<RecargaMovil> recargas = recargaMovilRepository.findByFechaBetween(fechaInicio, fechaFin);

		// String filtro = "Desde " + filtroDesde + " hasta " + filtroHasta;
		return generarReporte.crearReporte(timeOffSet, "", "ListadoRecargas", recargas);
	}

}
