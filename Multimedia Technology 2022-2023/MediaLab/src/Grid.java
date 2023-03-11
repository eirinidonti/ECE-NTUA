import javax.swing.*;
import java.awt.*;
import java.util.ArrayList;
import java.io.FileWriter;   // Import the FileWriter class
import java.io.IOException;  // Import the IOException class to handle errors
import java.io.*;

// Create Grid
public class Grid extends JPanel {
    public int bound = Game.GRIDSIZE * Game.GRIDSIZE;
    private boolean picked = false;
    private ArrayList<Integer> mines = new ArrayList<Integer>();
    public static ArrayList<Cell> cellGrid = new ArrayList<Cell>();
    public static int hyperminepos;
    private int[] minepos = new int[Game.MINECOUNT+1];

    public static int hyperrow;
    public static int hypercolumn;

    public Grid(GridLayout g, Handler h) throws IOException{  //Display Grid
        super(g);
        createCells(h);
        addCells();
    }

    String str = "";
    public void createCells(Handler h) throws IOException{
        File minesfile = new File("C:\\Users\\Ειρήνη\\Documents\\JAVA\\src\\medialab\\mines.txt");
        FileWriter myWriter = new FileWriter(minesfile);                   //Open mines.txt file

        for(int i = 1; i <= Game.MINECOUNT; i++) {                         //Pick Random Position For Mines
            while (!picked) {
                int minePosition = (int) (Math.random() * bound);
                minepos[i] = minePosition;
                if (!mines.contains(minePosition)) {
                    mines.add(minePosition);
                    picked = true;
                }
            }
            picked = false;
        }

        int rows = 0;
        int counter = 0;
        int columns = 0;

        for(int i=0; i<bound; i+=Game.GRIDSIZE) {                           //Save to String Axis For Mines (And Hypermine If Exists)
            for(int k=1; k<=Game.MINECOUNT; k++) {
                if (minepos[k] < i+Game.GRIDSIZE && minepos[k] >= i){
                    rows = counter;
                    columns = minepos[k] - rows*Game.GRIDSIZE;
                    String hstr = "0\n";
                    if(Game.DIFFICULTYLEVEL == 2 && k == Game.MINECOUNT/2){ //Hypermine Thesis Is minepos[Game.MINECOUNT/2]
                        this.hyperminepos = minepos[k];
                        hstr = "1\n";
                        this.hyperrow = rows;
                        this.hypercolumn = columns;

                    }
                    str= str+rows+","+columns+","+hstr;
                }

            }
            counter++;
        }

        myWriter.write(str);                                               //Save String to mines.txt
        myWriter.close();

        for(int i = 0; i < bound; i++){
            if(mines.contains(i)){                                         //If It is Mine Position, Add Cell With Type 1
                cellGrid.add(new Cell(1, i, false, false, h));
            }
            else if(i%Game.GRIDSIZE == 0) {                                //If There Are Adjacent Mines, Add Cell With Type 2
                if (mines.contains(i - Game.GRIDSIZE) ||                   //Else Add Cell With Type 0
                        mines.contains(i-Game.GRIDSIZE +1) ||
                        mines.contains(i + 1) ||
                        mines.contains(i + Game.GRIDSIZE) ||
                        mines.contains(i + Game.GRIDSIZE + 1)) {
                    cellGrid.add(new Cell(2, i, false, false, h));
                } else {
                    cellGrid.add(new Cell(0, i, false, false, h));
                }
            }
            else if(i%Game.GRIDSIZE == Game.GRIDSIZE -1) {
                if(mines.contains(i-Game.GRIDSIZE -1) ||
                        mines.contains(i-Game.GRIDSIZE) ||
                        mines.contains(i-1) ||
                        mines.contains(i+Game.GRIDSIZE -1) ||
                        mines.contains(i+Game.GRIDSIZE)){
                    cellGrid.add(new Cell(2,i,false,false, h));
                }
                else{
                    cellGrid.add(new Cell(0,i,false,false, h));
                }
            }
            else {
                if (mines.contains(i - Game.GRIDSIZE - 1) ||
                        mines.contains(i - Game.GRIDSIZE) ||
                        mines.contains(i - 1) ||
                        mines.contains(i + 1) ||
                        mines.contains(i + Game.GRIDSIZE - 1) ||
                        mines.contains(i + Game.GRIDSIZE) ||
                        mines.contains(i + Game.GRIDSIZE + 1)) {
                    cellGrid.add(new Cell(2, i, false, false, h));
                } else {
                    cellGrid.add(new Cell(0, i, false, false, h));
                }
            }
        }

    }
    private void addCells() {                                         //Add Cells to Grid
        for(int i = 0; i < cellGrid.size(); i++){
            add(cellGrid.get(i));
        }
    }
    public static void removeCells() {                               //Remove Cells from Grid
        cellGrid.clear();
    }
}

