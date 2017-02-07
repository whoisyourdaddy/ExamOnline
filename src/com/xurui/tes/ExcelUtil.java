package com.xurui.tes;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

public class ExcelUtil {
	public static void main(String[] args) throws IOException {
		List list = ExcelUtil
				.reasXls(EXCEL_PATH);
		for (Object o : list) {
			System.out.println(o);
		}

	}

	public static final String EXCEL_PATH = "WebContent/WEB-INF/lib/student_info.xls";

	/**
	 * 读取 xls文件
	 * 
	 * @param filePath
	 * @return
	 * @throws IOException
	 */
	public static List reasXls(String filePath) throws IOException {
		File file = new File(filePath);
		InputStream is = new FileInputStream(file);
		HSSFWorkbook hssfWorkbook = new HSSFWorkbook(is);

		List<Student> data = new ArrayList<Student>();

		System.out.println("sheet个数:" + hssfWorkbook.getNumberOfSheets());
		// 获取每一个工作薄
		for (int numSheet = 0; numSheet < hssfWorkbook.getNumberOfSheets(); numSheet++) {
			HSSFSheet hssfSheet = hssfWorkbook.getSheetAt(numSheet);
			if (hssfSheet == null) {
				continue;
			}

			// 标题
			HSSFRow title = hssfSheet.getRow(0);
			System.out.println("表头:"+getValue(title.getCell(0))
					+ getValue(title.getCell(1)) + getValue(title.getCell(2))
					+ getValue(title.getCell(3)));

			// 获取当前工作薄的每一行
			//System.out.println(hssfSheet.getLastRowNum());
			for (int rowNum = 1; rowNum <= hssfSheet.getLastRowNum(); rowNum++) {
				HSSFRow hssfRow = hssfSheet.getRow(rowNum);
				if (hssfRow != null) {
					Student s = new Student();
					HSSFCell no = hssfRow.getCell(0);
					no.setCellType(1);//int类型
					HSSFCell name = hssfRow.getCell(1);
					
					HSSFCell age = hssfRow.getCell(2);
					age.setCellType(1);
					
					HSSFCell score = hssfRow.getCell(3);
					
					
					s.setNo(Integer.valueOf(getValue(no)));
					s.setName(getValue(name));
					s.setAge(Integer.valueOf(getValue(age)));
					s.setScore(Float.valueOf(getValue(score)));

					data.add(s);
				}
			}
		}

		return data;
	}

	// 转换数据格式
	@SuppressWarnings("static-access")
	private static String getValue(HSSFCell hssfCell) {
		if (hssfCell.getCellType() == hssfCell.CELL_TYPE_BOOLEAN) {
			return String.valueOf(hssfCell.getBooleanCellValue());
		} else if (hssfCell.getCellType() == hssfCell.CELL_TYPE_NUMERIC) {
			return String.valueOf(hssfCell.getNumericCellValue());
		} else {
			return String.valueOf(hssfCell.getStringCellValue());
		}
	}
}


