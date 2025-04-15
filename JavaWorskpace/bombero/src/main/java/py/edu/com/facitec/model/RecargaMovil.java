package py.edu.com.facitec.model;

import java.time.LocalDateTime;

import com.fasterxml.jackson.annotation.JsonFormat;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "recarga_movil")
@Data
@EqualsAndHashCode(callSuper = false)
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class RecargaMovil {

	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id_recarga_movil;
	@JsonFormat(shape = JsonFormat.Shape.STRING,pattern = "yyyy-MM-dd'T'HH:mm:ss")
	@Column(nullable = false)
	private LocalDateTime fecha_hora;
	@Column(length = 45, nullable = false)
	private String descripcion;
	@Column(nullable = false)
	private double cantidad_litros;
	/*@Column(nullable = false)
	private int id_movil;
	@Column(nullable = false)
	private int id_bombero;
	@Column(nullable = false)
	private int id_deposito_agua;*/
	
	
	@ManyToOne
	@JoinColumn(name = "id_deposito_agua",nullable = false)
	private DepositoAgua depositoAgua;
	
	@ManyToOne
	@JoinColumn(name = "id_movil", nullable = false)
	private Movil movil;
	
	@ManyToOne
	@JoinColumn(name = "id_bombero", nullable = false)
	private Bombero bombero;
	
	
//	@Transient
//	@JsonProperty("id_recarga_movil")
//	private Integer recargaMovilId;
	
	
}