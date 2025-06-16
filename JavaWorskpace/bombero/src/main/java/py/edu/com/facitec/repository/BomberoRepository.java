package py.edu.com.facitec.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import py.edu.com.facitec.model.Bombero;

public interface BomberoRepository extends JpaRepository<Bombero, Long> {

	Optional<Bombero> findByDocumento(String documento);
	
	List<Bombero> findByNombreContaining(String nombre);
	
    @Query("SELECT b FROM Bombero b WHERE " +
            "UPPER(SUBSTRING(b.nombre, 1, 1)) BETWEEN UPPER(:letraInicio) AND UPPER(:letraFin)")
     List<Bombero> findByNombreRango(
         @Param("letraInicio") String letraInicio,
         @Param("letraFin") String letraFin);
}

