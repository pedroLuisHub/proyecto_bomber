package py.edu.com.facitec.service;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;
import py.edu.com.facitec.model.Ciudadano;
import py.edu.com.facitec.repository.CiudadanoRepository;

@Service
@AllArgsConstructor
public class CiudadanoService {
	
	private CiudadanoRepository ciudadanoRepository;
	
	
	public List<Ciudadano> listarCiudadanos() {
		return ciudadanoRepository.findAll();
	}
	 
	 
	
	public Optional<Ciudadano> buscarPorId(Integer id) {
		return ciudadanoRepository.findById(id);
	}
	
	
	
	public Ciudadano guardarCiudadano(Ciudadano ciudadano) {
		return ciudadanoRepository.save(ciudadano);
	}
	
	
	
	public void eliminarCiudadano(Integer id) {
		ciudadanoRepository.deleteById(id);
	}
	

}
