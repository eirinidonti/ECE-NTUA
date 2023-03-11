import java.io.IOException;

//Initialize size of frame
public class Game {
    static FileDetails fileDetails = new FileDetails();
    FileService fileService = new FileService(fileDetails);

    public static final int WIDTH = 720, HEIGHT = 720;
    public static int GRIDSIZE;
    public static int MINECOUNT;
    public static int AVAILABLETIME;
    public  static int DIFFICULTYLEVEL;
    public static Handler handler = new Handler();
    public Game() throws InvalidDescriptionException, InvalidValueException, IOException {
        this.MINECOUNT = fileDetails.getMineNumber();

        this.AVAILABLETIME = fileDetails.getAvailableTime();

        this.DIFFICULTYLEVEL = fileDetails.getDifficultylevel();

        //Define GRIDSIZE Depending on Difficulty Level
        if(fileDetails.getDifficultylevel() == 1) { //Easy Level
            this.GRIDSIZE = 9;
        }
        else if(fileDetails.getDifficultylevel() == 2){ // Hard Level
            this.GRIDSIZE = 16;
        }

        new Window(WIDTH, HEIGHT, GRIDSIZE,"MediaLab Minesweeper ", this, handler);  //Initialize A New Window
        Window.update(0);
    }
}
