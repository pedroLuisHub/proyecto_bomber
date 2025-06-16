package py.edu.com.facitec.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import py.edu.com.facitec.model.Ciudadano;

public interface CiudadanoRepository extends JpaRepository<Ciudadano, Integer> {

	Optional<Ciudadano> findByDocumento(String documento);
	
	List<Ciudadano> findByNombreContaining(String nombre);
	
    @Query("SELECT c FROM Ciudadano c WHERE " +
            "UPPER(SUBSTRING(c.nombre, 1, 1)) BETWEEN UPPER(:letraInicio) AND UPPER(:letraFin)")
     List<Ciudadano> findByNombreRango(
         @Param("letraInicio") String letraInicio,
         @Param("letraFin") String letraFin);

}
