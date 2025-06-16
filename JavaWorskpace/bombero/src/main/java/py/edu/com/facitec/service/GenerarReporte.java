package py.edu.com.facitec.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.util.Base64;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.ResourceUtils;

import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;

@Service
@Transactional(rollbackFor = Exception.class)
public class GenerarReporte {

	public ResponseEntity<?> crearReporte(String timeOffSet, String filtro, String nombreDeReporte, List<?> list) {

		String path = "classpath:reports/";

		if (filtro == null || filtro.isEmpty()) {
			filtro = "SIN FILTROS";
		}

		try {
			File file = ResourceUtils.getFile(path + nombreDeReporte + ".jrxml");
			InputStream input = new FileInputStream(file);
			JasperReport jasperReport = JasperCompileManager.compileReport(input);
			JRBeanCollectionDataSource source = new JRBeanCollectionDataSource(list);
			Map<String, Object> parameters = new HashMap<>();
			parameters.put("TIME_OFF_SET", timeOffSet);
			parameters.put("SUB_REPORT_DIR", path);
			parameters.put("FILTRO", filtro);

			JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport, parameters, source);

			byte[] data = JasperExportManager.exportReportToPdf(jasperPrint);
			if (data == null) {
				return ResponseEntity.ok(null);
			}
			String strg = Base64.getEncoder().encodeToString(data);
			return ResponseEntity.ok().header("Content-Type", "application/pdf; charset=UTF-8")
					.header("Content-Disposition", "inline; filename=\"" + ".pdf\"").body(strg);

		} catch (Exception e) {
			System.out.println(e.getMessage());
			return ResponseEntity.ok("ERROR AL GENERAR EL REPORTE");
		}
	}

}