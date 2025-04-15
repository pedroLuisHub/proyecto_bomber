package py.edu.com.facitec.model;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonProperty;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import jakarta.persistence.Transient;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "movil")
@Data
@EqualsAndHashCode(callSuper = false)
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Movil {

	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id_movil;
	@Column(length = 45, nullable = false)
	private String descripcion;
	@Column(nullable = false)
	private double capacidad_tanque;
	@Column(length = 45, nullable = false)
	private String estado;
	@Column( nullable = false)
	private String tutorial_abastecimiento;
	
	
	@OneToMany(mappedBy = "movil")
	@JsonIgnore
	private List <RecargaMovil> recargaMovil;
	
	
	@OneToMany(mappedBy = "movil")
	@JsonIgnore
	private List<Abastecimiento> abastecimiento;
	
	
	
//	//Getters y Setters
//	private int getId_movil() {
//		return id_movil;
//	}
//	private void setId_movil(int id_movil) {
//		this.id_movil = id_movil;
//	}
//	private String getDescripcion() {
//		return descripcion;
//	}
//	private void setDescripcion(String descripcion) {
//		this.descripcion = descripcion;
//	}
//	private double getCapacidad_tanque() {
//		return capacidad_tanque;
//	}
//	private void setCapacidad_tanque(double capacidad_tanque) {
//		this.capacidad_tanque = capacidad_tanque;
//	}
//	private String getEstado() {
//		return estado;
//	}
//	private void setEstado(String estado) {
//		this.estado = estado;
//	}
//	private String getTutorial_abastecimiento() {
//		return tutorial_abastecimiento;
//	}
//	private void setTutorial_abastecimiento(String tutorial_abastecimiento) {
//		this.tutorial_abastecimiento = tutorial_abastecimiento;
//	}
//	
	
	
	
}
