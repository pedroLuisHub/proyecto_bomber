package py.edu.com.facitec.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class DepositoAguaDTO {

	
	private int idDepositoAgua;
    private String latitud;
    private String longitud;
    private double capacidad;
    private String estado;
    private int ciudadanoId;


}
