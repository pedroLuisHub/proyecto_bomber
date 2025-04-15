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
@Table(name = "ciudadano")
@Data
@EqualsAndHashCode(callSuper = false)
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Ciudadano {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id_ciudadano;
	@Column(length = 255, nullable = false)
	private String documento;
	@Column(length = 255, nullable = false)
	private String nombre;
	@Column(length = 255, nullable = false)
	private String apellido;
	@Column(length = 255, nullable = false)
	private String telefono;
	@Column(length = 255)
	private String email;
	@Column(length = 255)
	private String direccion;
	@Column(length = 45, nullable = false)
	private String genero;
	@Column(length = 255)
	private String profecion;
	
	
	
	@OneToMany(mappedBy = "ciudadano")
	@JsonIgnore
	private List<DepositoAgua> depositoagua;
	
	

	
}
