package xml2rdf;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Properties;

public class XMLIterator {

	// iterates over found xml files
	public static void main(String[] args) throws IOException {

		long startTime = System.currentTimeMillis();
		// read filepaths from property file
		Properties properties = new Properties();
		BufferedInputStream stream = new BufferedInputStream(new FileInputStream(
				"xml2rdf.properties"));
		properties.load(stream);
		stream.close();
		String path = properties.getProperty("path");
		String xslt = properties.getProperty("xslt");

		File f = new File(path);
		File[] fileArray = f.listFiles();
		for (int i = 0; i < fileArray.length; i++) {

			if (fileArray[i].getName().toLowerCase().endsWith(".xml")) {

				XSLTTransformer xt = new XSLTTransformer();
				xt.read_section(fileArray[i].getAbsolutePath(),
						xslt, fileArray[i].getAbsolutePath().toLowerCase().replace(".xml", ".nt"));

			}
		}
		long stopTime = System.currentTimeMillis();
		long elapsedTime = stopTime - startTime;
		double conversionTime = elapsedTime / 1000.0d / 60.0d;
		System.out.println("Conversion Time: " + conversionTime);

	}
}
