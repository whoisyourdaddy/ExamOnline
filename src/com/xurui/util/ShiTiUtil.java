package com.xurui.util;

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

import com.xurui.dormain.Question;

public class ShiTiUtil {
	public static void main(String[] args) throws IOException {
		List list = ShiTiUtil
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
	public static List<Question> reasXls(String filePath) throws IOException {
		File file = new File(filePath);
		InputStream is = new FileInputStream(file);
		HSSFWorkbook hssfWorkbook = new HSSFWorkbook(is);

		List<Question> data = new ArrayList<Question>();

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
					+ " "+getValue(title.getCell(1)) + getValue(title.getCell(2))
					+ " "+ getValue(title.getCell(3))+getValue(title.getCell(4))
					+ " "+ getValue(title.getCell(5))+getValue(title.getCell(6))
					+ " "+ getValue(title.getCell(7))
					);

			// 获取当前工作薄的每一行
			//System.out.println(hssfSheet.getLastRowNum());
			for (int rowNum = 1; rowNum <= hssfSheet.getLastRowNum(); rowNum++) {
				HSSFRow hssfRow = hssfSheet.getRow(rowNum);
				if (hssfRow != null) {
					Question s = new Question();
					HSSFCell type = hssfRow.getCell(0);
					type.setCellType(1);//int类型
					
					HSSFCell course = hssfRow.getCell(1);
					
					HSSFCell keyA = hssfRow.getCell(2);
					HSSFCell keyB = hssfRow.getCell(3);
					HSSFCell keyC = hssfRow.getCell(4);
					HSSFCell keyD = hssfRow.getCell(5);
					HSSFCell ques = hssfRow.getCell(6);
					HSSFCell answer = hssfRow.getCell(7);
					
					
					s.setType(Integer.valueOf(getValue(type)));
					s.setCourse(getValue(course));
					s.setQues(getValue(ques));
					s.setKeyA(getValue(keyA));
					s.setKeyB(getValue(keyB));
					s.setKeyC(getValue(keyC));
					s.setKeyD(getValue(keyD));
					s.setAnswer(getValue(answer));

					data.add(s);
				}
			}
		}

		return data;
	}

	// 转换数据格式
	@SuppressWarnings("static-access")
	private static String getValue(HSSFCell hssfCell) {
		if(hssfCell ==null){
			return "";
		}
	    else if (hssfCell.getCellType() == hssfCell.CELL_TYPE_BOOLEAN) {
			return String.valueOf(hssfCell.getBooleanCellValue());
		} else if (hssfCell.getCellType() == hssfCell.CELL_TYPE_NUMERIC) {
			return String.valueOf(hssfCell.getNumericCellValue());
		} else {
			return String.valueOf(hssfCell.getStringCellValue());
		}
	}
}


