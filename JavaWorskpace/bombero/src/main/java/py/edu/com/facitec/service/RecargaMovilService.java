package py.edu.com.facitec.service;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;
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
	private MovilRepository movilRepository;
    private DepositoAguaRepository depositoAguaRepository;
    private BomberoRepository bomberoRepository;
	
	
	public RecargaMovil guardarRecargaMovil(RecargaMovil recargaMovil) {
		
//		DepositoAgua depositoAgua = depositoAguaRepository.findById(recargaMovil.getDepositoAgua().getId_deposito_agua())
//                .orElseThrow(() -> new IllegalArgumentException("Depósito no encontrado con id: " + recargaMovil.getDepositoAgua().getId_deposito_agua()));
//        Movil movil = movilRepository.findById(recargaMovil.getMovil().getId_movil())
//                .orElseThrow(() -> new IllegalArgumentException("Móvil no encontrado con id: " + recargaMovil.getMovil().getId_movil()));
//        Bombero bombero = bomberoRepository.findById(recargaMovil.getBombero().getId_bombero())
//                .orElseThrow(() -> new IllegalArgumentException("Bombero no encontrado con id: " + recargaMovil.getBombero().getId_bombero()));
//		
//		recargaMovil.setDepositoAgua(depositoAgua);
//        recargaMovil.setMovil(movil);
//        recargaMovil.setBombero(bombero);
//
//        return recargaMovilRepository.save(recargaMovil);
		
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
