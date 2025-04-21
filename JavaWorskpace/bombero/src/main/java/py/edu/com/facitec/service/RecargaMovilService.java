package py.edu.com.facitec.service;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;
import py.edu.com.facitec.model.DepositoAgua;
import py.edu.com.facitec.model.RecargaMovil;
import py.edu.com.facitec.repository.DepositoAguaRepository;
import py.edu.com.facitec.repository.RecargaMovilRepository;

@Service
@AllArgsConstructor
public class RecargaMovilService {

	private RecargaMovilRepository recargaMovilRepository;
	private DepositoAguaRepository depositoAguaRepository;

	
	
	public RecargaMovil guardarRecargaMovil(RecargaMovil recargaMovil) {
		
		DepositoAgua deposito = depositoAguaRepository.findById(recargaMovil.getDepositoAgua().getId_deposito_agua())
		        .orElseThrow(() -> new RuntimeException("Depósito no encontrado"));

		recargaMovil.setDepositoAgua(deposito);
		
		 return recargaMovilRepository.save(recargaMovil);
		
	}
	
	
	public List<RecargaMovil> listarRecargas() {
        return recargaMovilRepository.findAll();
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
	
	
	
}
