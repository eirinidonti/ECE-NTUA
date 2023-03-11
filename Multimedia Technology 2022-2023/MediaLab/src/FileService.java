import java.io.File;
import java.io.FileNotFoundException;
import java.util.Scanner;
public class FileService extends FileDetails {
        public static File myObj = new File("C:\\Users\\Ειρήνη\\Documents\\JAVA\\src\\medialab\\SCENARIO-ID.txt");
        public FileService(FileDetails fileDetails) throws InvalidDescriptionException, InvalidValueException {
                try {
                    Scanner myReader = new Scanner(myObj);
                    int[] input = new int[4];
                    int i =0;
                    while (myReader.hasNextInt()) {            //Read Integers in SCENARIOID File
                        final int data = myReader.nextInt();
                        input[i] = data;
                                                                //input[0] is difficulty level
                                                                //input[1] is number of mines
                                                                //input[2] is available time (secs)
                                                                //input[3] is the existence of hyper-mine
                        i++;
                    }
                    ValidDescription(i);                                //Check If There Isn't Valid Description
                    ValidValue(input[0], input[1], input[2], input[3]); //Check If There Isn't Valid Value
                    int dl = input[0];
                    int mn = input[1];
                    int at = input[2];
                    int hm = input[3];

                    fileDetails.setDifficultylevel(dl);                 //Save Fields calling FileDetails methods
                    fileDetails.setMineNumber(mn);
                    fileDetails.setHyperMine(hm);
                    fileDetails.setAvailableTime(at);

                    myReader.close();
                } catch (FileNotFoundException e) {                     //If the File not Found, Exception
                    System.out.println("Error Occurred.");
                    e.printStackTrace();
                }

    }
        private static void ValidDescription(int j) throws InvalidDescriptionException{                                   //Throw InvalidDescriptionException
        if (j != 4){                                                                                                      //If There Are Not The Appropriate Rows In Description File
            throw new InvalidDescriptionException("Wrong Description!");                                                  //Print "Wrong Description!"
        }
    }

        private static void ValidValue(int value0, int value1, int value2, int value3) throws InvalidValueException{      //Throw InvalidValueException
        if (!((value0 == 1 && (value1 <=11 && value1 >= 9) && (value2 <= 180 && value2 >= 120) && (value3 == 0))          //If There Are Not The Appropriate Values In Description File
                || (value0 == 2 && (value1 <=45 && value1 >= 35) && (value2 <= 360 && value2 >= 240) && (value3 == 1)))){ //Print "Wrong Value(s)!"
            throw new InvalidValueException("Wrong Value(s)!");
        }
    }

}