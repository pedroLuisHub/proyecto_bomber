package py.edu.com.facitec.model;

import java.time.LocalDate;

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
@Table(name = "abastecimiento")
@Data
@EqualsAndHashCode(callSuper = false)
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Abastecimiento {

	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id_abastecimiento;
	@JsonFormat(shape = JsonFormat.Shape.STRING,pattern = "dd-MM-yyyy")
	@Column(nullable = false)
	private LocalDate fecha_inicio;
	@JsonFormat(shape = JsonFormat.Shape.STRING,pattern = "dd-MM-yyyy")
	@Column(nullable = false)
	private LocalDate fecha_finalizacion;
	@Column(nullable = false)
	private double cant_litros;
	@Column(nullable = false)
	private String descripcion;
	@Column(nullable = false)
	private int cant_viajes;
	
	
	
	@ManyToOne
	@JoinColumn(name = "id_deposito_agua",nullable = false)
	private DepositoAgua depositoAgua;
	
	
	@ManyToOne
	@JoinColumn(name = "id_movil",nullable = false)
	private Movil movil;
	
	
	@ManyToOne
	@JoinColumn(name = "id_bombero",nullable = false)
	private Bombero bombero;

	
	
	
}
