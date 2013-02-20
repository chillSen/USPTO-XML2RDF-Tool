package xml2rdf;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.OutputStreamWriter;

import javax.xml.transform.OutputKeys;
import javax.xml.transform.Result;
import javax.xml.transform.Source;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;

public class XSLTTransformer {

	// read XML FIle
	BufferedReader reader = null;
	// open XSL file
	Source xsl = null;
	// open output file to write the output data
	Result output = null;
	// tmpBuffer to spilt xml files
	StringBuilder stringBuilder = null;

	public void transform() throws IOException {

		try
		{

			// write the xml to temporary file
			BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(
					"temp.xml")));

			// create tmp XML file
			bw.write(stringBuilder.toString());
			stringBuilder.delete(0, stringBuilder.length());
			bw.close();

			Source input = new StreamSource(new FileInputStream("temp.xml"));

			TransformerFactory tf = TransformerFactory.newInstance();
			Transformer trans = tf.newTransformer(xsl);
			trans.setOutputProperty(OutputKeys.OMIT_XML_DECLARATION, "yes");
			trans.transform(input, output);

		} catch (Exception c) {
			System.err.println("ERROR");
			c.printStackTrace();
		} finally {

			//File tmp1 = new File("temp.xml");
			//tmp1.delete();
		}
	}

	public void read_section(String xml_file, String xslt_file, String rdf_file)
	{
		long startTime = System.currentTimeMillis();
		try {

			reader = new BufferedReader(new FileReader(xml_file));
			// open XSL file
			xsl = new StreamSource(new File(xslt_file));
			// open output file to write the output data
			output = new StreamResult(new FileOutputStream("tempfile.rdf"));
			// buffer
			stringBuilder = new StringBuilder();

			String line = null;
			String ls = System.getProperty("line.separator");
			boolean firstTag = true;

			// reading XML file line by line
			while ((line = reader.readLine()) != null)
			{

				if (!(line.contains("<?xml version=\"1.0\" encoding=\"UTF-8\"?>") || line
						.contains("<!DOCTYPE"))) {
					stringBuilder.append(line);
					stringBuilder.append(ls);
				} else if (line.contains("<?xml version=\"1.0\" encoding=\"UTF-8\"?>")
						&& firstTag == false) {
					transform();
				} else if (line.contains("<!DOCTYPE")) {
					firstTag = false;
				}
			}
			transform();
			reader.close();
			if (stringBuilder.length() != 0)
				System.out.println(stringBuilder.toString());

			stringBuilder.delete(0, stringBuilder.length());

			// ################################REPLACING SOME
			// TAGS##############################################

			// update output file
			BufferedReader br = new BufferedReader(new FileReader("tempfile.rdf"));
			BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(
					rdf_file, false)));

			bw.write("@prefix xsd:	<http://www.w3.org/2001/XMLSchema#> .");
			bw.newLine();
			// replace tags
			while ((line = br.readLine()) != null)
			{
				if (!line.contains("@prefix xsd:")) {
					bw.write(line.replaceAll("&lt;", "<").replaceAll("&gt;", ">"));
					bw.newLine();
				}
			}
			// close reader and writer
			br.close();
			bw.close();

			// delete tmpFile
			File tmp2 = new File("tempfile.rdf");
			tmp2.delete();

		} catch (Exception e)
		{
			e.printStackTrace();

		}
	}

}
