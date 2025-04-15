package py.edu.com.facitec.model;

import java.util.List;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "bombero")
@Data
@EqualsAndHashCode(callSuper = false)
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Bombero {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id_bombero;
	@Column(length = 255, nullable = true)
	private String documento;
	@Column(length = 255, nullable = true)
	private String nombre;
	@Column(length = 255, nullable = true)
	private String apellido;
	@Column(length = 255, nullable = true)
	private String telefono;
	@Column(length = 255, nullable = true)
	private String email;
	@Column(length = 255, nullable = true)
	private String direccion;
	@Column(length = 255, nullable = true)
	private String cargo;

	@OneToMany(mappedBy = "bombero")
	private List<RecargaMovil> recargaMovil;

	@OneToMany(mappedBy = "bombero")
	private List<Abastecimiento> abastecimiento;

}
