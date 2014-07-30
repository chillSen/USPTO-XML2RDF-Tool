package xml2rdf;

import java.io.File;
import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;

public class XMLIterator {

    // iterates over found xml files
    public static void main(String[] args) throws IOException {

        String input_dir = "";
        String output_dir = "";
        String xsl_file = "";

        //parse command line arguments
        if(args.length==3){

            input_dir = args[0];
            output_dir = args[1];
            xsl_file = args[2];

            /*Path out = Paths.get(output_dir);
            if(!Files.isDirectory(out)){
                Files.createDirectory(out);
            }*/

        }else{
            System.out.println("Argument error! Arguments need to be in the following order" +
                    "\nxml input filename" +
                    "\nturtle output directory" +
                    "\nxsl file");
            System.exit(1);
        }


        long startTime = System.currentTimeMillis();
        
		/*File f = new File(input_dir);
		File[] fileArray = f.listFiles();
        if(fileArray!=null) {
            for (File aFileArray : fileArray) {
                if (aFileArray.getName().toLowerCase().endsWith(".xml")) {
                    System.out.println("converting File: " + aFileArray.getName());
                    XSLTTransformer xt = new XSLTTransformer();
                    xt.read_section(aFileArray.getAbsolutePath(),
                            xsl_file, output_dir + aFileArray.getName().toLowerCase().replace(".xml", ".nt"));

                }
            }
        }*/
        File f = new File(input_dir);
        if(f.getName().toLowerCase().endsWith(".xml")){
            System.out.println("converting File: " + f.getName());
            XSLTTransformer xt = new XSLTTransformer();
            xt.read_section(f.getAbsolutePath(),
                    xsl_file, output_dir + f.getName().toLowerCase().replace(".xml", ".nt"));
        }

		long stopTime = System.currentTimeMillis();
		long elapsedTime = stopTime - startTime;
		double conversionTime = elapsedTime / 1000.0d / 60.0d;
		System.out.println("Conversion Time: " + conversionTime);

	}
}
