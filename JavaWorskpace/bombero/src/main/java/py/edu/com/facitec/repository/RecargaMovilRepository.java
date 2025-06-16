package py.edu.com.facitec.repository;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import py.edu.com.facitec.model.RecargaMovil;

public interface RecargaMovilRepository extends JpaRepository<RecargaMovil, Integer> {

	@Query("SELECT r FROM RecargaMovil r WHERE r.fecha_hora BETWEEN :fechaInicio AND :fechaFin")
	List<RecargaMovil> findByFechaBetween(@Param("fechaInicio") LocalDateTime fechaInicio,
			@Param("fechaFin") LocalDateTime fechaFin);

}