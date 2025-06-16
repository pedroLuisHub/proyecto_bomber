package py.edu.com.facitec.service;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;
import py.edu.com.facitec.dto.DepositoAguaDTO;
import py.edu.com.facitec.model.Bombero;
import py.edu.com.facitec.model.Ciudadano;
import py.edu.com.facitec.model.DepositoAgua;
import py.edu.com.facitec.repository.CiudadanoRepository;
import py.edu.com.facitec.repository.DepositoAguaRepository;

@Service
@AllArgsConstructor
public class DepositoAguaService {

	private DepositoAguaRepository depositoAguaRepository;
	private CiudadanoRepository ciudadanoRepository;
	private GenerarReporte generarReporte;

	public List<DepositoAguaDTO> listarDepositos() {
		return depositoAguaRepository.findAll().stream()
				.map(deposito -> new DepositoAguaDTO(deposito.getId_deposito_agua(), deposito.getLatitud(),
						deposito.getLongitud(), deposito.getCapacidad(), deposito.getEstado(), deposito.getCiudadano()))
				.collect(Collectors.toList());
	}
//	public List<DepositoAgua> listarDepositos() {
//		return depositoAguaRepository.findAll();
//	}

	public DepositoAgua guardarDeposito(DepositoAgua depositoAgua) {
		Ciudadano ciudadano = ciudadanoRepository.findById(depositoAgua.getCiudadano().getId_ciudadano())
				.orElseThrow(() -> new IllegalArgumentException(
						"Ciudadano no encontrado con id: " + depositoAgua.getCiudadano().getId_ciudadano()));
		depositoAgua.setCiudadano(ciudadano);
		return depositoAguaRepository.save(depositoAgua);
	}

	public Optional<DepositoAgua> buscarPorId(Integer id) {
		return depositoAguaRepository.findById(id);
	}

	public void eliminarDeposito(Integer id) {
		depositoAguaRepository.deleteById(id);
	}
	
	public ResponseEntity<?> reporteDeposito(String timeOffSet, double numMin, double numMax) {
		
	List<DepositoAgua> depositos = depositoAguaRepository.findByCapacidadRango(numMin, numMax);
	
	//String filtro = "Desde " + filtroDesde + " hasta " + filtroHasta;
	return generarReporte.crearReporte(timeOffSet, "", "ListadoDepositos", depositos);
}

}
