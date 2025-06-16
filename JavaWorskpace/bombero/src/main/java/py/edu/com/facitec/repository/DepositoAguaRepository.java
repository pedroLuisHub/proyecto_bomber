package py.edu.com.facitec.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import py.edu.com.facitec.model.DepositoAgua;

public interface DepositoAguaRepository extends JpaRepository<DepositoAgua, Integer>{
	
    @Query("SELECT d FROM DepositoAgua d WHERE " +
            "d.capacidad BETWEEN :numMin AND :numMax")
     List<DepositoAgua> findByCapacidadRango(
         @Param("numMin") Double numMin,
         @Param("numMax") Double numMax);

}