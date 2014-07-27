package xml2rdf;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;

import javax.xml.transform.OutputKeys;
import javax.xml.transform.Result;
import javax.xml.transform.Source;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;

class XSLTTransformer {

    // open XSL file
    private Source xsl = null;
	// open output file to write the output data
    private Result output = null;
	// tmpBuffer to split xml files
    private StringBuilder stringBuilder = null;

	void transform() {

		try
		{

			// write the xml to temporary file
			BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(
					"temp.xml"), "UTF8"));

			// create tmp XML file
			bw.write(stringBuilder.toString());
			stringBuilder.delete(0, stringBuilder.length());
			bw.close();

			Source input = new StreamSource(new FileInputStream("temp.xml"));
			TransformerFactory tf = TransformerFactory.newInstance();
			Transformer trans = tf.newTransformer(xsl);
			trans.setOutputProperty(OutputKeys.METHOD, "text");
			trans.setOutputProperty(OutputKeys.OMIT_XML_DECLARATION, "yes");
			trans.setOutputProperty(OutputKeys.INDENT, "yes");
			trans.setOutputProperty(OutputKeys.ENCODING, "UTF8");
			
			trans.transform(input, output);

		} catch (Exception c) {
			System.err.println("ERROR");
			c.printStackTrace();
		}
	}

	public void read_section(String xml_file, String xsl_file, String rdf_file)
	{
		try {

            BufferedReader reader = new BufferedReader(new InputStreamReader(new FileInputStream(xml_file), "UTF8"));
			// open XSL file
			xsl = new StreamSource(new File(xsl_file));
			// open output file to write the output data
			output = new StreamResult(new FileOutputStream("tempfile.rdf"));
			// buffer
			stringBuilder = new StringBuilder();

			String line;
			String ls = System.getProperty("line.separator");
			boolean firstPatent = true;

			// reading XML file line by line
			while ((line = reader.readLine()) != null)
			{
				if(xsl_file.contains("2002-2004.xsl") ){
                    line = line.replace("&num;", "").replace("&apos;", "").replace("&ouml;", "").replace("&ldquo;", "").replace("&auml;", "").replace("&mdash;", "").replace("&plus;","").replace("&rdquo;", "").replace("&quest;", "").replace("&deg;", "").replace("&reg;", "").replace("&equals;","").replace("&","").replace(";", "");
                }

				if (!(line.contains("<?xml version=\"1.0\" encoding=\"UTF-8\"?>") || line.contains("<!DOCTYPE")|| line.contains("]>") || line.contains("<!ENTITY"))) {
					//.contains("<!DOCTYPE") || line.contains("]>") || line.contains("<!ENTITY"))) {
					stringBuilder.append(line);
					stringBuilder.append(ls);
				} else if (line.contains("<?xml version=\"1.0\" encoding=\"UTF-8\"?>")
						&& !firstPatent) {
					transform();
				//} else if (line.contains("]>")) {
				} else if (line.contains("<!DOCTYPE")) {
					firstPatent = false;
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
            BufferedReader br = new BufferedReader(new InputStreamReader(new FileInputStream("tempfile.rdf"), "UTF8"));
			BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(
					rdf_file, false), "UTF8"));

			bw.write("@prefix xsd:	<http://www.w3.org/2001/XMLSchema#> .");
			bw.newLine();
            bw.newLine();
            bw.newLine();
			// replace tags
			while ((line = br.readLine()) != null)
			{
				//if (!line.contains("@prefix xsd:")) {
					bw.write(line);
					bw.newLine();
				//}
			}
			// close reader and writer
            output = null;
            bw.flush();
            bw.close();
			br.close();


			// delete tmpFile
            File tmp2 = new File("tempfile.rdf");
			tmp2.delete();

		} catch (Exception e)
		{
			e.printStackTrace();

		}
	}

}
