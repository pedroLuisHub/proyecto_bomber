package py.edu.com.facitec.service;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;
import py.edu.com.facitec.model.Bombero;
import py.edu.com.facitec.repository.BomberoRepository;

@Service
@AllArgsConstructor
public class BomberoService {

	private BomberoRepository bomberoRepository;
	
	
	public List<Bombero> listarBomberos() {
		return bomberoRepository.findAll();
	}
	 
	 
	
	public Optional<Bombero> buscarPorId(Long id) {
		return bomberoRepository.findById(id);
	}
	
	
	
	public Bombero guardarBombero(Bombero bombero) {
		return bomberoRepository.save(bombero);
	}
	
	
	
	public void eliminarBombero(Long id) {
		bomberoRepository.deleteById(id);
	}
	
	
}
