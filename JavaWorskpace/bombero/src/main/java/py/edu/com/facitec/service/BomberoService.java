package py.edu.com.facitec.service;

import java.util.List;
import java.util.Optional;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;
import py.edu.com.facitec.model.Bombero;
import py.edu.com.facitec.repository.BomberoRepository;

@Service
@AllArgsConstructor
public class BomberoService {

	private BomberoRepository bomberoRepository;
	private GenerarReporte generarReporte;
	
	
	public List<Bombero> listarBomberos(String condition) {
		return bomberoRepository.findByNombreContaining(condition);
	}
	 
	
	public Optional<Bombero> buscarPorId(Long id) {
		return bomberoRepository.findById(id);
	}
	
	
	public Bombero guardarBombero(Bombero bombero) {
		Optional<Bombero> existente = bomberoRepository.findByDocumento(bombero.getDocumento());

	    if (existente.isPresent() && (bombero.getId_bombero() == null || !existente.get().getId_bombero().equals(bombero.getId_bombero()))) {
	        throw new IllegalArgumentException("Ya existe un bombero con esta cédula.");
	    }

		return bomberoRepository.save(bombero);
	}
	
	
	public void eliminarBombero(Long id) {
		bomberoRepository.deleteById(id);
	}
	
	
	public ResponseEntity<?> reporteBombero(String timeOffSet, String filtroDesde, String filtroHasta) {
	
	List<Bombero> bomberos = bomberoRepository.findByNombreRango(filtroDesde, filtroHasta);
	
	//String filtro = "Desde " + filtroDesde + " hasta " + filtroHasta;
	return generarReporte.crearReporte(timeOffSet, "", "ListadoBomberos", bomberos);
}
	
	
}
