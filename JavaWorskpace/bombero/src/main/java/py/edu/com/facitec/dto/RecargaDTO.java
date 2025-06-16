package py.edu.com.facitec.dto;

import java.time.LocalDateTime;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import py.edu.com.facitec.model.Bombero;
import py.edu.com.facitec.model.DepositoAgua;
import py.edu.com.facitec.model.Movil;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class RecargaDTO {

	private int idRecarga;
    @JsonFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss")
	private LocalDateTime fecha_hora;
	private String descripcion;
	private double cantidad_litros;
	private Movil movil;
	private Bombero bombero;
	private DepositoAgua depositoAgua;
}
