import java.io.*;
//class that Copy File from another one

/**
 * A class that provides a method for copying the contents of a file to another file.
 * It uses FileInputStream and FileOutputStream to read and write the contents of files.
 */
public class CopyFile {
    /**
     * Constructs a new CopyFile.
     */
    public CopyFile() {
        // constructor implementation doesn't need
    }

    /**
     * Copies the contents of one file to another.
     * This method reads the contents of the sourceFile file using FileInputStream and writes them
     * to the destFile file using FileOutputStream. Input and output streams close after the copy operation is complete.
     *
     * @param sourceFile The file to copy from
     * @param destFile The file to copy to
     * @throws IOException If an I/O error occurs while reading or writing the files
     */
    public static void copyContent(File sourceFile, File destFile) throws IOException
    {
        FileInputStream in = new FileInputStream(sourceFile);
        FileOutputStream out = new FileOutputStream(destFile);

        try {
            int n;
            while ((n = in.read()) != -1) { //When is not EOF
                out.write(n);
            }
        }
        finally {
            if (in != null) {               //Close FileStreams
                in.close();
            }
            if (out != null) {
                out.close();
            }
        }
        System.out.println("File Copied");
    }
}
