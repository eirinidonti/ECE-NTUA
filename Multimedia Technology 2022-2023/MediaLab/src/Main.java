import java.io.IOException;
import java.util.Timer;
import java.util.TimerTask;

//Main
public class Main {
    public static Timer timer;
    public static TimerTask task;
    public static String c;

    public static void main(String[] args) throws IOException {
        new InitWindow("MediaLab Minesweeper"); //Show an Initial Welcome Window
    }
    public static void TimerStart() {
        timer = new Timer();
        task = new TimerTask() {
            int counter = Game.AVAILABLETIME;                                                                    //Max Time Given From File

            @Override
            public void run() {
                if (counter >= 0) {                                                                              //If Available Time is Positive
                    String counter1 = String.valueOf(counter);
                    c = counter1;
                    Window.timeupdate(counter1);                                                                 //Update Timer In Window
                    if (Handler.clickmine == 1 || Window.solutionActivation || Handler.win) {                    //If Click On Mine or Click on Solution In Menu or Win => Cancel Timer
                        timer.cancel();
                        timer = new Timer();
                    }
                    counter--;                                                                                   //Decrease Time in Timer
                    c = Integer.toString(counter);
                } else {                                                                                         //If Available Time is Negative => Game Is Over, User Loses Game
                    timer.cancel();                                                                              //Cancel Timer
                    timer = new Timer();
                    for (int x = 0; x < Grid.cellGrid.size(); x++) {                                             //Show Mine Positions
                        Grid.cellGrid.get(x).setEnabled(false);
                        Grid.cellGrid.get(x).setText("");
                        if (Grid.cellGrid.get(x).getType() == 1) {
                            Grid.cellGrid.get(x).setText("X");
                        }
                    }
                }
            }
        };
    }
}
