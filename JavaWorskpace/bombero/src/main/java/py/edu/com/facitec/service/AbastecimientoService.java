package py.edu.com.facitec.service;


import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;
import py.edu.com.facitec.model.Abastecimiento;
import py.edu.com.facitec.model.Bombero;
import py.edu.com.facitec.model.DepositoAgua;
import py.edu.com.facitec.model.Movil;
import py.edu.com.facitec.repository.AbastecimientoRepository;
import py.edu.com.facitec.repository.BomberoRepository;
import py.edu.com.facitec.repository.DepositoAguaRepository;
import py.edu.com.facitec.repository.MovilRepository;


@Service
@AllArgsConstructor
public class AbastecimientoService {

    private final AbastecimientoRepository abastecimientoRepository;
    private final DepositoAguaRepository depositoAguaRepository;
    private final BomberoRepository bomberoRepository;
    private final MovilRepository movilRepository;

//    public List<AbastecimientoDTO> listarAbastecimientos() {
//        return abastecimientoRepository.findAll().stream()
//                .map(abastecimiento -> new AbastecimientoDTO(
//                        abastecimiento.getId_abastecimiento(),
//                        abastecimiento.getFecha_inicio(),
//                        abastecimiento.getFecha_finalizacion(),
//                        abastecimiento.getCant_litros(),
//                        abastecimiento.getDescripcion(),
//                        abastecimiento.getCant_viajes(),
//                        abastecimiento.getDepositoAgua() != null ? abastecimiento.getDepositoAgua().getId_deposito_agua() : null,
//                        abastecimiento.getMovil() != null ? abastecimiento.getMovil().getId_movil() : null,
//                        abastecimiento.getBombero() != null ? abastecimiento.getBombero().getId_bombero() : null
//                ))
//                .collect(Collectors.toList());
//    }
//	
//	
//	public Optional<AbastecimientoDTO> buscarPorId(Integer id) {
//        return abastecimientoRepository.findById(id)
//                .map(abastecimiento -> new AbastecimientoDTO(
//                        abastecimiento.getId_abastecimiento(),
//                        abastecimiento.getFecha_inicio(),
//                        abastecimiento.getFecha_finalizacion(),
//                        abastecimiento.getCant_litros(),
//                        abastecimiento.getDescripcion(),
//                        abastecimiento.getCant_viajes(),
//                        abastecimiento.getDepositoAgua() != null ? abastecimiento.getDepositoAgua().getId_deposito_agua() : null,
//                        abastecimiento.getMovil() != null ? abastecimiento.getMovil().getId_movil() : null,
//                        abastecimiento.getBombero() != null ? abastecimiento.getBombero().getId_bombero() : null
//                ));
//    }
    // Guardar un abastecimiento
    public Abastecimiento guardarAbastecimiento(Abastecimiento abastecimiento) {
//        // Verificar que las relaciones no sean null
//        if (abastecimiento.getDepositoAgua() == null || abastecimiento.getDepositoAgua().getId_deposito_agua() == null) {
//            throw new IllegalArgumentException("El depósito de agua es obligatorio");
//        }
//        if (abastecimiento.getBombero() == null || abastecimiento.getBombero().getId_bombero() == null) {
//            throw new IllegalArgumentException("El bombero es obligatorio");
//        }
//        if (abastecimiento.getMovil() == null || abastecimiento.getMovil().getId_movil() == null) {
//            throw new IllegalArgumentException("El móvil es obligatorio");
//        }

        // Buscar las entidades relacionadas
        DepositoAgua depositoAgua = depositoAguaRepository.findById(abastecimiento.getDepositoAgua().getId_deposito_agua())
                .orElseThrow(() -> new IllegalArgumentException("Depósito no encontrado con id: " + abastecimiento.getDepositoAgua().getId_deposito_agua()));
        Bombero bombero = bomberoRepository.findById(abastecimiento.getBombero().getId_bombero())
                .orElseThrow(() -> new IllegalArgumentException("Bombero no encontrado con id: " + abastecimiento.getBombero().getId_bombero()));
        Movil movil = movilRepository.findById(abastecimiento.getMovil().getId_movil())
                .orElseThrow(() -> new IllegalArgumentException("Móvil no encontrado con id: " + abastecimiento.getMovil().getId_movil()));

        // Establecer las relaciones
        abastecimiento.setDepositoAgua(depositoAgua);
        abastecimiento.setBombero(bombero);
        abastecimiento.setMovil(movil);

        return abastecimientoRepository.save(abastecimiento);
    }

    // Eliminar un abastecimiento por ID
    public void eliminarAbastecimiento(Integer id) {
        if (!abastecimientoRepository.existsById(id)) {
            throw new IllegalArgumentException("Abastecimiento no encontrado con id: " + id);
        }
        abastecimientoRepository.deleteById(id);
    }
}