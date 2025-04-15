package py.edu.com.facitec.dto;

import java.time.LocalDate;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class AbastecimientoDTO {

    private int idAbastecimiento;

    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "dd-MM-yyyy")
    private LocalDate fechaInicio;

    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "dd-MM-yyyy")
    private LocalDate fechaFinalizacion;

    private double cantLitros;

    private String descripcion;

    private int cantViajes;

    private Integer depositoAguaId;

    private Integer movilId;

    private Integer bomberoId;
}