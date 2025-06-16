package py.edu.com.facitec.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import py.edu.com.facitec.model.Ciudadano;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class DepositoAguaDTO {

	private int id_deposito_agua;
    private String latitud;
    private String longitud;
    private double capacidad;
    private String estado;
    private Ciudadano ciudadano;
    
}
