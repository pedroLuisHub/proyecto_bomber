package py.edu.com.facitec.service;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;
import py.edu.com.facitec.model.Movil;
import py.edu.com.facitec.repository.MovilRepository;

@Service
@AllArgsConstructor
public class MovilService {

	private MovilRepository movilRepository;
	
	
	public List<Movil> listarMoviles(){
		return movilRepository.findAll();
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
	
	
}