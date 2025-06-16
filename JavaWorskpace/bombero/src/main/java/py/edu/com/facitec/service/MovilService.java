package py.edu.com.facitec.service;

import java.util.List;
import java.util.Optional;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;
import py.edu.com.facitec.model.Movil;
import py.edu.com.facitec.repository.MovilRepository;

@Service
@AllArgsConstructor
public class MovilService {

	private MovilRepository movilRepository;
	private GenerarReporte generarReporte;
	
	
	public List<Movil> listarMoviles(String condition){
		return movilRepository.findByDescripcionContaining(condition);
	}
	
	
	public Optional<Movil> buscarPorId(Integer id) {
		return movilRepository.findById(id);
	}
	
	
	public Movil guardarMovil(Movil movil) {
		return movilRepository.save(movil);
	}
	
	
	public void eliminarMovil(Integer id) {
		movilRepository.deleteById(id);
	}
	
	public ResponseEntity<?> reporteMovil(String timeOffSet, String filtroDesde, String filtroHasta) {
		
	List<Movil> moviles = movilRepository.findByNombreRango(filtroDesde, filtroHasta);
	
	//String filtro = "Desde " + filtroDesde + " hasta " + filtroHasta;
	return generarReporte.crearReporte(timeOffSet, "", "ListadoMoviles", moviles);
 }
}