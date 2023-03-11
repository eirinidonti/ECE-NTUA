import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.IOException;
import java.io.File;

//Open Initial Window
public class InitWindow {
    private static JFrame initframe;
    private  static JPanel initp1;
    private static JLabel initt1;
    private static String title;

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
            if (option == JOptionPane.OK_OPTION) {//If User Clicks to Ok Button
                Window.sid = scenarioid.getText();//Read Inputs
                if((diflevel.getText()).length() == 0) {Window.booldl = true;}  //If Input Field is Empty
                else {
                    try{                                                 //Check If Input Is Integer, Else Exception
                        Window.dl = Integer.parseInt(diflevel.getText());
                    } catch (NumberFormatException e) {
                        Window.booldl = true;
                        System.out.println("Given Difficulty Level is Not Integer!");
                    }
                }

                if((minenum.getText()).length() == 0) {Window.boolmn = true;}  //If Input Field is Empty
                else {
                    try{                                                //Check If Input Is Integer, Else Exception
                        Window.mn = Integer.parseInt(minenum.getText());
                    } catch (NumberFormatException e) {
                        Window.boolmn = true;
                        System.out.println("Given Mine Number is Not Integer!");
                    }
                }

                if((hyperm.getText()).length() == 0) {Window.boolhm = true;}   //If Input Field is Empty
                else {
                    try{                                                //Check If Input Is Integer, Else Exception
                        Window.hm = Integer.parseInt(hyperm.getText());
                    } catch (NumberFormatException e) {
                        Window.boolhm = true;
                        System.out.println("Given Hyper Mine Existence is Not Integer!");
                    }
                }

                if(availtime.getText().length() == 0){Window.boolat = true;}   //If Input Field is Empty
                else {
                    try{                                                //Check If Input Is Integer, Else Exception
                        Window.at = Integer.parseInt(availtime.getText());
                    } catch (NumberFormatException e) {
                        Window.boolat = true;
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
                Window.loadsid = loadscenarioid.getText();                                                                                         //Read sid
                File f = new File("C:\\Users\\Ειρήνη\\Documents\\JAVA\\src\\medialab\\"+Window.loadsid+".txt");                           //Open file with name sid
                File deff = new File("C:\\Users\\Ειρήνη\\Documents\\JAVA\\src\\medialab\\SCENARIO-ID.txt");
                if(f.exists() && f.isFile()) {                                                                                                     //If sid Exists
                    Window.exceptioninload =false;
                    try{
                        CopyFile.copyContent(f, deff);                                                                                             //Copy file sid to SCENARIOID
                        FileDetails fd = new FileDetails();
                        FileService fs = new FileService(fd);
                        Window.initialize = true;
                    }
                    catch(InvalidDescriptionException | InvalidValueException |IOException ex){                                                    //If Exception Occurs
                        Window.exceptioninload = true;
                        System.out.println(ex.getMessage());                                                                                       //Print Message
                    }
                    Window.ready = true;                                                                                                           //if file is ok
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
        RoundsOptionPane() {
            JLabel minenumb = new JLabel("- ,- ,- ,- ,-");
            JLabel attempt = new JLabel("- ,- ,- ,- ,-");
            JLabel gametime = new JLabel("- ,- ,- ,- ,-");
            JLabel winner = new JLabel("- ,- ,- ,- ,-");
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

    public InitWindow(String title) throws IOException {

        InitWindow.title = title;
        initframe = new JFrame(title); // Create New Frame (Initial)

        //Initial Frame Style

        initp1 = new JPanel();        //Initial Frame Style
        initt1 = new JLabel("Welcome To The Minesweeper Game", SwingConstants.CENTER);
        initt1.setFont(new Font("Serif", Font.HANGING_BASELINE, 25));
        initt1.setForeground(new Color(0, 51, 77));
        initp1.setBackground(new Color(204, 238, 255));
        initt1.setPreferredSize(new Dimension(845, 750));
        initp1.add(initt1);

        JMenuBar initmb1 = new JMenuBar();
        initframe.setJMenuBar(initmb1);

        //Initial Window Menu Bar

        // Create Menu Bar "Application" on Window Menu Bar

        JMenu initmenu1 = new JMenu("Application");

        JMenuItem initsubmenu1 = new JMenuItem("Create");
        initmenu1.add(initsubmenu1);

        JMenuItem initsubmenu2 = new JMenuItem("Load");
        initmenu1.add(initsubmenu2);

        JMenuItem initsubmenu3 = new JMenuItem("Start");
        initmenu1.add(initsubmenu3);

        JMenuItem initsubmenu4 = new JMenuItem("Exit");
        initmenu1.add(initsubmenu4);

        initmb1.add(initmenu1);

        initsubmenu1.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e) {
                new InitWindow.CreateOptionPane();
            }
        });

        initsubmenu2.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e) {
                new InitWindow.LoadOptionPane();
            }
        });

        initsubmenu3.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e) {                                //start valid initialised game (first)
                if (Window.ready && !Window.exceptioninload && Window.initialize) {     //if There Are no Exception in Load and Initialized Without Problems
                    Window.startnewgame = true;
                    try {
                        new Game();                                                     //Initialize new Game
                        InitWindow.initframe.dispose();                                 //Dispose Welcome frame
                        Main.TimerStart();                                              //Begin New Timer
                        Main.timer.scheduleAtFixedRate(Main.task, 0, 1000); //Change Counter Value After 1 sec
                        Window.frame.setVisible(true);                                  //Reveal Game Frame
                    } catch (InvalidDescriptionException | InvalidValueException | IOException ex) { //If Exception Occurs
                        System.out.println(ex.getMessage());                                         //Print Message
                    }
                }
                Window.ready = false;
                Window.initialize = false;
            }
        });

        initsubmenu4.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e) {
                System.exit(0);                   //Exit
            }
        });

        // Create Menu Bar "Details" on Window Menu Bar

        JMenu initmenu2 = new JMenu("Details");

        JMenuItem initsubmenu5 = new JMenuItem("Rounds");
        initmenu2.add(initsubmenu5);

        JMenuItem initsubmenu6 = new JMenuItem("Solution");
        initmenu2.add(initsubmenu6);

        initmb1.add(initmenu2);

        initsubmenu5.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e) {
                new InitWindow.RoundsOptionPane();
            }
        });

        initsubmenu6.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e) {
                System.out.println("No Initialized Game");
            }
        });

        //Display Initial Frame

        initframe.getContentPane().add(initp1, BorderLayout.CENTER);
        initframe.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        initframe.setLocationRelativeTo(null);
        initframe.pack();
        initframe.setVisible(true);
    }

}
