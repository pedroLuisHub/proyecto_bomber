package py.edu.com.facitec.model;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonProperty;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import jakarta.persistence.Transient;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "deposito_agua")
@Data
@EqualsAndHashCode(callSuper = false)
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class DepositoAgua {

	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id_deposito_agua;
	@Column(nullable = false)
	private String latitud;
	@Column(nullable = false)
	private String longitud;
	@Column(nullable = false)
	private double capacidad;
	@Column(length = 45, nullable = false)
	private String estado;
	
	
	@ManyToOne
	@JoinColumn(nullable = false)
	private Ciudadano ciudadano;
	
	
	@OneToMany(mappedBy = "depositoAgua")
	@JsonIgnore
	private List<RecargaMovil> recargamovil;
	
	
	@OneToMany(mappedBy = "depositoAgua")
	@JsonIgnore
	private List <Abastecimiento> abastecimiento;
	
	
	@Transient
	@JsonProperty("id_ciudadano")
	private Integer ciudadanoId;
	
	
//	//getters y setters
//	private int getId_deposito_agua() {
//		return id_deposito_agua;
//	}
//	private void setId_deposito_agua(int id_deposito_agua) {
//		this.id_deposito_agua = id_deposito_agua;
//	}
//	private String getLatitud() {
//		return latitud;
//	}
//	private void setLatitud(String latitud) {
//		this.latitud = latitud;
//	}
//	private String getLongitud() {
//		return longitud;
//	}
//	private void setLongitud(String longitud) {
//		this.longitud = longitud;
//	}
//	private double getCapacidad() {
//		return capacidad;
//	}
//	private void setCapacidad(double capacidad) {
//		this.capacidad = capacidad;
//	}
//	private String getEstado() {
//		return estado;
//	}
//	private void setEstado(String estado) {
//		this.estado = estado;
//	}
//	
	
	
}
