import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.IOException;
import java.io.File;

//Open Window With Certain Size
class Window {
    public static JFrame frame;
    private static JPanel p1;
    public static JPanel panel = new JPanel();

    private static JLabel jLabel;
    private static JLabel t1;
    private static String title;
    public static String sid;
    public static String loadsid;

    public static int dl;
    public static int mn;
    public static int hm;
    public static int at;

    public static boolean booldl = false;
    public static boolean boolmn = false;
    public static boolean boolhm = false;
    public static boolean boolat = false;

    public static int GameWinner = 0;

    public static boolean solutionActivation = false;

    public static boolean initialize = false;
    public static boolean startnewgame= false;
    public static boolean ready = false;
    public static boolean exceptioninload = false;

    public static String[] GameMineNumber = {"-","-","-","-","-"};

    public static String[] GameAttempts = {"-","-","-","-","-"};

    public static String[] GameTime = {"-","-","-","-","-"};

    public static String[] GameWinners = {"-","-","-","-","-"};

    //Create Option Pane For MenuItem Create
    public class CreateOptionPane {
        JFrame f;
        CreateOptionPane() {
            f = new JFrame();
            JTextField scenarioid = new JTextField();
            JTextField diflevel = new JTextField();
            JTextField minenum = new JTextField();
            JTextField hyperm = new JTextField();
            JTextField availtime = new JTextField();
            Object[] message = {
                    "SCENARIO-ID:", scenarioid,
                    "Difficulty Level:", diflevel,
                    "Mine Number:", minenum,
                    "Hypermine:", hyperm,
                    "Available Time:", availtime
            };
            int option = JOptionPane.showConfirmDialog(null, message, "Select SCENARIO-ID", JOptionPane.OK_CANCEL_OPTION);  //Pop up Window
            if (option == JOptionPane.OK_OPTION) {                       //If User Clicks to Ok Button
                sid = scenarioid.getText();                              //Read Inputs
                if((diflevel.getText()).length() == 0) {booldl = true;}  //If Input Field is Empty
                else {
                    try{                                                 //Check If Input Is Integer, Else Exception
                        dl = Integer.parseInt(diflevel.getText());
                    } catch (NumberFormatException e) {
                        booldl = true;
                       System.out.println("Given Difficulty Level is Not Integer!");
                    }
                }

                if((minenum.getText()).length() == 0) {boolmn = true;}  //If Input Field is Empty
                else {
                    try{                                                //Check If Input Is Integer, Else Exception
                        mn = Integer.parseInt(minenum.getText());
                    } catch (NumberFormatException e) {
                        boolmn = true;
                        System.out.println("Given Mine Number is Not Integer!");
                    }
                }

                if((hyperm.getText()).length() == 0) {boolhm = true;}   //If Input Field is Empty
                else {
                    try{                                                //Check If Input Is Integer, Else Exception
                        hm = Integer.parseInt(hyperm.getText());
                    } catch (NumberFormatException e) {
                        boolhm = true;
                        System.out.println("Given Hyper Mine Existence is Not Integer!");
                    }
                }

                if(availtime.getText().length() == 0){boolat = true;}   //If Input Field is Empty
                else {
                    try{                                                //Check If Input Is Integer, Else Exception
                        at = Integer.parseInt(availtime.getText());
                    } catch (NumberFormatException e) {
                        boolat = true;
                        System.out.println("Given Available Time is Not Integer!");
                    }
                }

                new CreateFile();                                                                                                              //Create File with name sid
            }
             else {                                                                                                                            //If User Clicks to Cancel Button
                System.out.println("Cancel Button");
            }
        }
    }

    //Load Option Pane For MenuItem Load
    public class LoadOptionPane {
        JFrame fr;
        LoadOptionPane() {
            fr = new JFrame();
            JTextField loadscenarioid = new JTextField();
            int option = JOptionPane.showConfirmDialog(null, loadscenarioid, "Load SCENARIO-ID", JOptionPane.OK_CANCEL_OPTION); //Pop up Window
            if (option == JOptionPane.OK_OPTION) {                                                                                                 //If User Clicks to Ok Button
                loadsid = loadscenarioid.getText();                                                                                                //Read sid
                File f = new File("C:\\Users\\Ειρήνη\\Documents\\JAVA\\src\\medialab\\"+loadsid+".txt");                                  //Open file with name sid
                File deff = new File("C:\\Users\\Ειρήνη\\Documents\\JAVA\\src\\medialab\\SCENARIO-ID.txt");
                if(f.exists() && f.isFile()) {                                                                                                     //If sid Exists
                    exceptioninload =false;
                    try{
                        CopyFile.copyContent(f, deff);                                                                                             //Copy file sid to SCENARIOID
                        FileDetails fd = new FileDetails();
                        FileService fs = new FileService(fd);
                        initialize = true;
                    }
                    catch(InvalidDescriptionException | InvalidValueException |IOException ex){                                                    //If Exception Occurs
                        exceptioninload = true;
                        System.out.println(ex.getMessage());                                                                                       //Print Message
                    }
                    ready = true; //if file is ok
                }
                else {                                                                                                                             //If the File Does Not Exist
                    System.out.println("The File Does Not Exist");
                }
            }
            else {                                                                                                                                 //If User Clicks to Cancel Button
                System.out.println("Cancel Button");
            }
        }
    }

    //Rounds Option Pane For MenuItem Rounds
    public class RoundsOptionPane {
        JFrame f;
        RoundsOptionPane() {                                   //Update Arrays and Update Window With User Wins
            JLabel minenumb = new JLabel(GameMineNumber[0]+" ,"+GameMineNumber[1]+" ,"+GameMineNumber[2]+" ,"+GameMineNumber[3]+" ,"+GameMineNumber[4]);
            JLabel attempt = new JLabel(GameAttempts[0]+" ,"+GameAttempts[1]+" ,"+GameAttempts[2]+" ,"+GameAttempts[3]+" ,"+GameAttempts[4]);
            JLabel gametime = new JLabel(GameTime[0]+" ,"+GameTime[1]+" ,"+GameTime[2]+" ,"+GameTime[3]+" ,"+GameTime[4]);
            JLabel winner = new JLabel(GameWinners[0]+" ,"+GameWinners[1]+" ,"+GameWinners[2]+" ,"+GameWinners[3]+" ,"+GameWinners[4]);
            Object[] message = {
                    "Mine Number:", minenumb,
                    "Attempts:", attempt,
                    "Game Time:", gametime,
                    "Winner:", winner,
            };
            int option = JOptionPane.showConfirmDialog(null, message, "Rounds for 5 Finished Games", JOptionPane.DEFAULT_OPTION);
            if (option != JOptionPane.DEFAULT_OPTION) {       //If User Clicks Ok Button
                System.out.println("Ok Button");
            }
        }
    }

    public Window(int width, int height, int gridSize, String title, Game game, Handler handler) throws IOException {
        Window.title = title;
        frame = new JFrame(title);     // Create New Frame For Game

        //Main Game Frame Style

        p1 = new JPanel();            //Panel for Game Details
        t1 = new JLabel("",SwingConstants.CENTER);
        t1.setFont(new Font("Serif", Font.HANGING_BASELINE, 20));
        t1.setForeground(Color.BLUE);
        t1.setPreferredSize(new Dimension(750,25)); //center
        p1.add(t1);

        JMenuBar mb1=new JMenuBar();

        //Main Window Menu Bar

        // Create Menu Bar "Application" on Window Menu Bar

        JMenu menu1=new JMenu("Application");

        JMenuItem submenu1=new JMenuItem("Create");
        menu1.add(submenu1);

        JMenuItem submenu2=new JMenuItem("Load");
        menu1.add(submenu2);

        JMenuItem submenu3=new JMenuItem("Start");
        menu1.add(submenu3);

        JMenuItem submenu4=new JMenuItem("Exit");

        menu1.add(submenu4);
        mb1.add(menu1);

        submenu1.addActionListener(new ActionListener(){
            public void actionPerformed(ActionEvent e){
                new CreateOptionPane();
            }
        });

        submenu2.addActionListener(new ActionListener(){
            public void actionPerformed(ActionEvent e){
                new LoadOptionPane();
            }
        });

        submenu3.addActionListener(new ActionListener(){
            public void actionPerformed(ActionEvent e) {
                if(ready && !exceptioninload && initialize) {   //if There Are no Exception in Load and Initialized Without Problems
                    startnewgame = true;
                    Window.frame.setVisible(false);
                    Window.panel.removeAll();
                    frame.repaint();
                    try {
                        Grid.removeCells(); //Refresh Game
                        Window.solutionActivation = false;
                        Handler.win = false;
                        Handler.clickmine = 0;
                        Handler.flaggedCells = 0;
                        Handler.trial = 0;
                        Handler.empties = 0;
                        Game g = new Game(); //Initialize new Game
                        Window.panel.revalidate();
                        Window.panel.repaint();
                        Window.frame.pack();
                        Main.timer.cancel();//In Case there is previous running timer, cancel timer
                        Main.TimerStart();//Begin New Timer
                        Main.timer.scheduleAtFixedRate(Main.task, 0, 1000); //Change Counter Value After 1 sec
                        Window.frame.setVisible(true);                                  //Reveal Game Frame
                    }
                    catch(InvalidDescriptionException | InvalidValueException | IOException ex){ //If Exception Occurs
                        System.out.println(ex.getMessage());                                     //Print Message
                    }
                }
                ready = false;
                initialize = false;
            }
        });

        submenu4.addActionListener(new ActionListener(){
            public void actionPerformed(ActionEvent e){
                System.exit(0);                    //Exit
            }
        });

        // Create Menu Bar "Details" on Window Menu Bar

        JMenu menu2=new JMenu("Details");

        JMenuItem submenu5=new JMenuItem("Rounds");
        menu2.add(submenu5);

        JMenuItem submenu6=new JMenuItem("Solution");

        menu2.add(submenu6);
        mb1.add(menu2);

        submenu5.addActionListener(new ActionListener(){
            public void actionPerformed(ActionEvent e){
                new RoundsOptionPane();
            }
        });

        submenu6.addActionListener(new ActionListener(){
            public void actionPerformed(ActionEvent e){
                if(startnewgame && !Handler.win && Handler.clickmine != 1) {                //Reveal Position of Mines
                    solutionActivation = true;
                    for (int x = 0; x < Grid.cellGrid.size(); x++) {
                        Grid.cellGrid.get(x).setEnabled(false);
                        Grid.cellGrid.get(x).setText("");
                        if (Grid.cellGrid.get(x).getType() == 1) {
                            Grid.cellGrid.get(x).setText("X");
                        }
                    }
                }else{
                    System.out.println("No Initialized Game");
                }
                startnewgame = false;
            }
        });

        frame.setJMenuBar(mb1);

        //Display Main Frame
        panel = new Grid(new GridLayout(gridSize, gridSize), handler);
        frame.getContentPane().add(p1, BorderLayout.NORTH);
        frame.getContentPane().add(panel, BorderLayout.SOUTH);
        panel.setPreferredSize(new Dimension(width + 100, height + 5));
        panel.setMinimumSize(new Dimension(width + 100, height + 5));
        panel.setMaximumSize(new Dimension(width + 100, height + 5));
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setLocationRelativeTo(null);
        frame.pack();
    }

    public static void update(int flagged) {                                                  //Update Window Panel With Game
        t1.setText("Mines: " + Game.MINECOUNT + " - Flags: " +flagged+" - Time Remain:    ");
    }
    public static void timeupdate(String time){                                               //Update Timer in Panel With Game
        String st = t1.getText();
        if(Integer.parseInt(time) != Game.AVAILABLETIME) {
            if (Integer.parseInt(time) == 99 || Integer.parseInt(time) == 9) {
                st = st.substring(0, st.length() - time.length()-1);
            }
            else {
                st = st.substring(0,st.length()-time.length());
            }
        }
        t1.setText(st+time);
    }
}