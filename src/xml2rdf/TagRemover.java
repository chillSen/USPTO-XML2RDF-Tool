package xml2rdf;

import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;

public class TagRemover {

	// path of rdf files
	static String path = "C:/Users/Simon-Notebook/Downloads/XML2RDF/RDF/2005";

	// iterates over all rdf files
	public static void main(String[] args) throws IOException {

		File f = new File(path);
		File[] fileArray = f.listFiles();
		int counter = 0;
		for (int i = 0; i < fileArray.length; i++) {

			if (fileArray[i].getName().endsWith(".rdf")) {
				BufferedReader src = new BufferedReader(new InputStreamReader(new FileInputStream(
						fileArray[i].getAbsolutePath())));
				BufferedWriter br = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(fileArray[i].getAbsolutePath()
						+ ".clean")));

				while (src.ready()) {
					String line = src.readLine();
					if (line.contains("<?xml version=\"1.0\" encoding=\"UTF-8\"?>")) {
						System.out.println(++counter);
					} else {
						br.write(line);
						br.newLine();
					}

				}
				src.close();
				br.close();

			}
		}
	}
}
