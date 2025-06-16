package py.edu.com.facitec.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import py.edu.com.facitec.model.Bombero;
import py.edu.com.facitec.model.Movil;

public interface MovilRepository extends JpaRepository<Movil, Integer> {

	List<Movil> findByDescripcionContaining(String descripcion);
	
    @Query("SELECT m FROM Movil m WHERE " +
            "UPPER(SUBSTRING(m.descripcion, 1, 1)) BETWEEN UPPER(:letraInicio) AND UPPER(:letraFin)")
     List<Movil> findByNombreRango(
         @Param("letraInicio") String letraInicio,
         @Param("letraFin") String letraFin);

}
