package py.edu.com.facitec.repository;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import py.edu.com.facitec.model.Abastecimiento;
import py.edu.com.facitec.model.RecargaMovil;

public interface AbastecimientoRepository extends JpaRepository<Abastecimiento, Integer>{
	
	@Query("SELECT a FROM Abastecimiento a WHERE a.fecha_inicio BETWEEN :fechaInicio AND :fechaFin")
	List<Abastecimiento> findByFechaBetween(@Param("fechaInicio") LocalDateTime fechaInicio,
			@Param("fechaFin") LocalDateTime fechaFin);


}
