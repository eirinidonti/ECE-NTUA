import java.io.File;
import java.io.IOException;
import java.io.*;

//Create File
public class CreateFile
{
    {
        File file = new File("C:\\Users\\Ειρήνη\\Documents\\JAVA\\src\\medialab\\"+Window.sid+".txt"); //Initialize File Object and Passing Path As Argument

        File parentDirectory = file.getParentFile();
        if (!parentDirectory.exists()) {
            parentDirectory.mkdirs();
        }

        FileWriter fr = null;
        boolean result;
        try
        {
            result = file.createNewFile();  //Creates a new file
            if(result)                      //Test If Successfully Created a New File
            {
                fr = new FileWriter(file);
                BufferedWriter writer = new BufferedWriter(fr);

                String str = ""; //Check if any input is empty, and save in case input is not empty
                if(!Window.booldl){
                    str = str+Window.dl+"\n";
                }

                if(!Window.boolmn){
                    str = str+Window.mn+"\n";
                }

                if(!Window.boolat){
                    str = str+Window.at+"\n";
                }

                if(!Window.boolhm){
                    str = str+Window.hm;
                }
                Window.booldl = false;
                Window.boolmn = false;
                Window.boolat = false;
                Window.boolmn = false;

                writer.write(str);
                writer.close();
            }

        }
        catch (IOException e)
        {
            e.printStackTrace();           //If There is IOException, Prints Exception
        }
    }
}
