package py.edu.com.facitec.service;

import java.util.List;
import java.util.Optional;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;
import py.edu.com.facitec.model.Bombero;
import py.edu.com.facitec.model.Ciudadano;
import py.edu.com.facitec.model.Ciudadano;
import py.edu.com.facitec.repository.CiudadanoRepository;

@Service
@AllArgsConstructor
public class CiudadanoService {
	
	private CiudadanoRepository ciudadanoRepository;
	private  GenerarReporte generarReporte;
	
	
	public List<Ciudadano> listarCiudadanos(String condition) {
		return ciudadanoRepository.findByNombreContaining(condition);
	}
	 
	 
	
	public Optional<Ciudadano> buscarPorId(Integer id) {
		return ciudadanoRepository.findById(id);
	}
	
	
	
	public Ciudadano guardarCiudadano(Ciudadano ciudadano) {
		Optional<Ciudadano> existente = ciudadanoRepository.findByDocumento(ciudadano.getDocumento());
		
		
		if (existente.isPresent()) {
		    Integer idExistente = existente.get().getId_ciudadano();
		    Integer idActual = ciudadano.getId_ciudadano();

		    if (idActual == null || !idActual.equals(idExistente)) {
		        throw new IllegalArgumentException("Ya existe un ciudadano con esta cédula.");
		    }
		}

		return ciudadanoRepository.save(ciudadano);
	}
	
	
	
	public void eliminarCiudadano(Integer id) {
		ciudadanoRepository.deleteById(id);
	}
	
	public ResponseEntity<?> reporteCiudadano(String timeOffSet, String filtroDesde, String filtroHasta) {
		
	List<Ciudadano> ciudadanos = ciudadanoRepository.findByNombreRango(filtroDesde, filtroHasta);
	
	//String filtro = "Desde " + filtroDesde + " hasta " + filtroHasta;
	return generarReporte.crearReporte(timeOffSet, "", "ListadoCiudadano", ciudadanos);
}
	

}
