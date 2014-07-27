package xml2rdf;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.Properties;

public class XMLIterator {

    // iterates over found xml files
    public static void main(String[] args) throws IOException {

        long startTime = System.currentTimeMillis();
        // read filepaths from property file
        Properties properties = new Properties();
        BufferedInputStream stream = new BufferedInputStream(new FileInputStream("xml2rdf.properties"));
		properties.load(stream);
		stream.close();
		String path = properties.getProperty("path");
		String xsl = properties.getProperty("xsl");

		File f = new File(path);
		File[] fileArray = f.listFiles();
        if(fileArray!=null) {
            for (File aFileArray : fileArray) {
                if (aFileArray.getName().toLowerCase().endsWith(".xml")) {
                    System.out.println("converting File: " + aFileArray.getName());
                    XSLTTransformer xt = new XSLTTransformer();
                    xt.read_section(aFileArray.getAbsolutePath(),
                            xsl, aFileArray.getAbsolutePath().toLowerCase().replace(".xml", ".nt"));

                }
            }
        }
		long stopTime = System.currentTimeMillis();
		long elapsedTime = stopTime - startTime;
		double conversionTime = elapsedTime / 1000.0d / 60.0d;
		System.out.println("Conversion Time: " + conversionTime);

	}
}
