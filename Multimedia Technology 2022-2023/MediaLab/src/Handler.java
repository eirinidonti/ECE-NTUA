import java.util.ArrayList;

// Handler Class
public class Handler {

    static FileDetails fileDetails = new FileDetails();
    private ArrayList<Cell> current = new ArrayList<Cell>();
    private ArrayList<Cell> queue = new ArrayList<Cell>();
    static public int clickmine;
    static public boolean win = false;
    public static int flaggedCells = 0;
    public static int trial = 0;
    public static int empties = 0;
    public int discoveredCells = 0;
    public void click(Cell cell) {             //Handle Left Click
        win = false;
        this.trial++;
        this.discoveredCells = 0;               //Initialize Discovered Cells
        if (!cell.isFlagged()) {               //If Cell Is Not Flagged
            cell.setEnabled(false);            //Stop Editing
            cell.getDiscovered(true);       //Cell Is Discovered When Is Clicked
            int position = cell.getPosition();

            if (cell.getType() == 0) {         //If Cell Is Empty
                if (position < Game.GRIDSIZE) { // if clicked cell is from zero to nine
                    if (position % Game.GRIDSIZE == 0) { //if clicked cell is adj to top left
                        queue.add(Grid.cellGrid.get((position + Game.GRIDSIZE))); //bottom
                        queue.add(Grid.cellGrid.get((position + Game.GRIDSIZE + 1))); //bottom right
                        queue.add(Grid.cellGrid.get((position + 1))); //next
                    } else if (position % Game.GRIDSIZE == Game.GRIDSIZE - 1) { //if clicked cell is adj to top right
                        queue.add(Grid.cellGrid.get((position + Game.GRIDSIZE))); //bottom
                        queue.add(Grid.cellGrid.get((position + Game.GRIDSIZE - 1))); //bottom left
                        queue.add(Grid.cellGrid.get((position - 1))); //previous
                    } else { // top row cells - not in corners
                        queue.add(Grid.cellGrid.get((position + Game.GRIDSIZE))); //bottom
                        queue.add(Grid.cellGrid.get((position + Game.GRIDSIZE + 1))); //bottom right
                        queue.add(Grid.cellGrid.get((position + Game.GRIDSIZE - 1))); //bottom left
                        queue.add(Grid.cellGrid.get((position + 1))); //next
                        queue.add(Grid.cellGrid.get((position - 1))); //right
                    }
                } else if (position >= (Game.GRIDSIZE * (Game.GRIDSIZE - 1))) { //if clicked cell is in last row
                    if (position % Game.GRIDSIZE == 0) { //if clicked cell is adj to top left
                        queue.add(Grid.cellGrid.get((position - Game.GRIDSIZE))); //top
                        queue.add(Grid.cellGrid.get((position - Game.GRIDSIZE + 1))); //top right
                        queue.add(Grid.cellGrid.get((position + 1))); //next
                    } else if (position % Game.GRIDSIZE == Game.GRIDSIZE - 1) {  //if clicked cell is adj to top right
                        queue.add(Grid.cellGrid.get((position - Game.GRIDSIZE))); //top
                        queue.add(Grid.cellGrid.get((position - Game.GRIDSIZE - 1))); //top left
                        queue.add(Grid.cellGrid.get((position - 1))); //previous
                    } else { // top row cells - not in corners
                        queue.add(Grid.cellGrid.get((position - Game.GRIDSIZE))); //top
                        queue.add(Grid.cellGrid.get((position - Game.GRIDSIZE + 1))); //top right
                        queue.add(Grid.cellGrid.get((position - Game.GRIDSIZE - 1))); //top left
                        queue.add(Grid.cellGrid.get((position + 1))); //next
                        queue.add(Grid.cellGrid.get((position - 1))); //previous
                    }
                } else if (position % Game.GRIDSIZE == 0) { // leftmost column
                    queue.add(Grid.cellGrid.get((position - Game.GRIDSIZE))); //top
                    queue.add(Grid.cellGrid.get((position + Game.GRIDSIZE))); //bottom
                    queue.add(Grid.cellGrid.get((position - Game.GRIDSIZE + 1))); //top right
                    queue.add(Grid.cellGrid.get((position + Game.GRIDSIZE + 1))); //bottom right
                    queue.add(Grid.cellGrid.get((position + 1))); //next
                } else if (position % Game.GRIDSIZE == Game.GRIDSIZE - 1) { // rightmost column
                    queue.add(Grid.cellGrid.get((position - Game.GRIDSIZE))); //top
                    queue.add(Grid.cellGrid.get((position + Game.GRIDSIZE))); //bottom
                    queue.add(Grid.cellGrid.get((position - Game.GRIDSIZE - 1))); //top left
                    queue.add(Grid.cellGrid.get((position + Game.GRIDSIZE - 1))); //bottom right
                    queue.add(Grid.cellGrid.get((position - 1))); //previous
                } else {
                    queue.add(Grid.cellGrid.get((position - Game.GRIDSIZE))); //top
                    queue.add(Grid.cellGrid.get((position + Game.GRIDSIZE))); //bottom
                    queue.add(Grid.cellGrid.get((position - Game.GRIDSIZE - 1))); //top left
                    queue.add(Grid.cellGrid.get((position + Game.GRIDSIZE - 1))); //bottom right
                    queue.add(Grid.cellGrid.get((position - Game.GRIDSIZE + 1))); //top left
                    queue.add(Grid.cellGrid.get((position + Game.GRIDSIZE + 1))); //bottom left
                    queue.add(Grid.cellGrid.get((position - 1))); //previous
                    queue.add(Grid.cellGrid.get((position + 1))); //next
                }
            } else if (cell.getType() == 2) {  //If There Are Adjacent Mines
                int dangerCount = 0;
                if (position < Game.GRIDSIZE) {
                    if (position % Game.GRIDSIZE == 0) {
                        if (Grid.cellGrid.get((position + Game.GRIDSIZE)).getType() == 1) dangerCount++;
                        if (Grid.cellGrid.get((position + Game.GRIDSIZE + 1)).getType() == 1) dangerCount++;
                        if (Grid.cellGrid.get((position + 1)).getType() == 1) dangerCount++;
                    } else if (position % Game.GRIDSIZE == Game.GRIDSIZE - 1) {
                        if (Grid.cellGrid.get((position + Game.GRIDSIZE)).getType() == 1) dangerCount++;
                        if (Grid.cellGrid.get((position + Game.GRIDSIZE - 1)).getType() == 1) dangerCount++;
                        if (position - 1 >=0 && Grid.cellGrid.get((position - 1)).getType() == 1) dangerCount++;
                    } else {
                        if (Grid.cellGrid.get((position + Game.GRIDSIZE)).getType() == 1) dangerCount++;
                        if (Grid.cellGrid.get((position + Game.GRIDSIZE + 1)).getType() == 1) dangerCount++;
                        if (Grid.cellGrid.get((position + Game.GRIDSIZE - 1)).getType() == 1) dangerCount++;
                        if (Grid.cellGrid.get((position + 1)).getType() == 1) dangerCount++;
                        if (position - 1 >=0 && Grid.cellGrid.get((position - 1)).getType() == 1) dangerCount++;
                    }
                }
                if (position >= Game.GRIDSIZE * (Game.GRIDSIZE - 1)) {
                    if (position % Game.GRIDSIZE == 0) {
                        if (position - Game.GRIDSIZE >=0 && Grid.cellGrid.get((position - Game.GRIDSIZE)).getType() == 1) dangerCount++;
                        if (position - Game.GRIDSIZE + 1 >= 0 && Grid.cellGrid.get((position - Game.GRIDSIZE + 1)).getType() == 1) dangerCount++;
                        if (Grid.cellGrid.get((position + 1)).getType() == 1) dangerCount++;
                    } else if (position % Game.GRIDSIZE == Game.GRIDSIZE - 1) {
                        if (position - Game.GRIDSIZE >= 0 && Grid.cellGrid.get((position - Game.GRIDSIZE)).getType() == 1) dangerCount++;
                        if (position - Game.GRIDSIZE - 1 >=0 && Grid.cellGrid.get((position - Game.GRIDSIZE - 1)).getType() == 1) dangerCount++;
                        if (position - 1 >= 0 && Grid.cellGrid.get((position - 1)).getType() == 1) dangerCount++;
                    } else {
                        if (position - Game.GRIDSIZE >=0 && Grid.cellGrid.get((position - Game.GRIDSIZE)).getType() == 1) dangerCount++;
                        if (position - Game.GRIDSIZE + 1 >= 0 && Grid.cellGrid.get((position - Game.GRIDSIZE + 1)).getType() == 1) dangerCount++;
                        if (position - Game.GRIDSIZE - 1 >= 0 && Grid.cellGrid.get((position - Game.GRIDSIZE - 1)).getType() == 1) dangerCount++;
                        if (Grid.cellGrid.get((position + 1)).getType() == 1) dangerCount++;
                        if (position - 1 >= 0 && Grid.cellGrid.get((position - 1)).getType() == 1) dangerCount++;
                    }
                } else if (position % Game.GRIDSIZE == 0) {
                    if (position - Game.GRIDSIZE >= 0 && Grid.cellGrid.get((position - Game.GRIDSIZE)).getType() == 1) dangerCount++;
                    if (Grid.cellGrid.get((position + Game.GRIDSIZE)).getType() == 1) dangerCount++;
                    if (position - Game.GRIDSIZE + 1 >= 0 && Grid.cellGrid.get((position - Game.GRIDSIZE + 1)).getType() == 1) dangerCount++;
                    if (Grid.cellGrid.get((position + Game.GRIDSIZE + 1)).getType() == 1) dangerCount++;
                    if (Grid.cellGrid.get((position + 1)).getType() == 1) dangerCount++;
                } else if (position % Game.GRIDSIZE == Game.GRIDSIZE - 1) {
                    if (position - Game.GRIDSIZE>=0 && Grid.cellGrid.get((position - Game.GRIDSIZE)).getType() == 1) dangerCount++;
                    if (Grid.cellGrid.get((position + Game.GRIDSIZE)).getType() == 1) dangerCount++;
                    if (position - Game.GRIDSIZE - 1 >= 0 && Grid.cellGrid.get((position - Game.GRIDSIZE - 1)).getType() == 1) dangerCount++;
                    if (Grid.cellGrid.get((position + Game.GRIDSIZE - 1)).getType() == 1) dangerCount++;
                    if (position - 1 >= 0 && Grid.cellGrid.get((position - 1)).getType() == 1) dangerCount++;
                } else {
                    if (position - Game.GRIDSIZE >= 0 && Grid.cellGrid.get((position - Game.GRIDSIZE)).getType() == 1) dangerCount++;
                    if (Grid.cellGrid.get((position + Game.GRIDSIZE)).getType() == 1) dangerCount++;
                    if (position - Game.GRIDSIZE - 1 >= 0 && Grid.cellGrid.get((position - Game.GRIDSIZE - 1)).getType() == 1) dangerCount++;
                    if (Grid.cellGrid.get((position + Game.GRIDSIZE - 1)).getType() == 1) dangerCount++;
                    if (position - Game.GRIDSIZE + 1 >=0 && Grid.cellGrid.get((position - Game.GRIDSIZE + 1)).getType() == 1) dangerCount++;
                    if (Grid.cellGrid.get((position + Game.GRIDSIZE + 1)).getType() == 1) dangerCount++;
                    if (position - 1>= 0 && Grid.cellGrid.get((position - 1)).getType() == 1) dangerCount++;
                    if (Grid.cellGrid.get((position + 1)).getType() == 1) dangerCount++;
                }
                cell.setText(String.valueOf(dangerCount));

            } else if (cell.getType() == 1) { //If It is Mine
                this.clickmine = 1;
                for (int x = 0; x < Grid.cellGrid.size(); x++) { //Reveal Positions Of Mines
                    Grid.cellGrid.get(x).setEnabled(false);
                    Grid.cellGrid.get(x).setText("");
                    if (Grid.cellGrid.get(x).getType() == 1) {
                        Grid.cellGrid.get(x).setText("X");
                    }
                }
                cell.setText("MINE");
            }

            for (int x = 0; x < queue.size(); x++) { // If Cell Is Empty, Reveal Adjacent Blocks
                if (!queue.get(x).isDiscovered()) {
                    if (queue.get(x).getType() != 1) {
                        current.add(queue.get(x));
                        queue.get(x).getDiscovered(true);
                    }
                }
            }

            queue.clear();

            while (!current.isEmpty()) {
                Cell temp = current.get(0);
                current.remove(0);
                this.empties++;
                temp.clickButton();
            }

            for (int x = 0; x < Grid.cellGrid.size(); x++) { //Update Number Of Discovered Cells
                if (Grid.cellGrid.get(x).isDiscovered()) {
                    this.discoveredCells++;
                }
            }

            if (this.discoveredCells == Grid.cellGrid.size() - Game.MINECOUNT) { //If Gamer Wins, Fill Cells
                win = true;
                for (int x = 0; x < Grid.cellGrid.size(); x++) {
                    if (Grid.cellGrid.get(x).getType() == 1) {
                        Grid.cellGrid.get(x).setEnabled(false);
                        Grid.cellGrid.get(x).setText("X");
                    } else {
                        Grid.cellGrid.get(x).setEnabled(false);
                        Grid.cellGrid.get(x).setText("WIN");
                    }
                }
                if(Window.GameWinner < 5) {                                 //Update Win In Window
                    Window.GameMineNumber[Window.GameWinner] = Integer.toString(Game.MINECOUNT);
                    Window.GameAttempts[Window.GameWinner] = Integer.toString(trial - empties);
                    Window.GameTime[Window.GameWinner] = Main.c;
                    Window.GameWinners[Window.GameWinner] = "User" + Integer.toString(Window.GameWinner + 1);
                    Window.GameWinner++;
                }
            }
        }
    }
    public void rightClick(Cell cell) {             //Handle Right Click
        if(!cell.isDiscovered()) {
            if(!cell.isFlagged()){
                if(flaggedCells < Game.MINECOUNT) { //if Flagged Cells Are Less Than Mines
                    if(trial - empties <= 4 && Game.DIFFICULTYLEVEL == 2 && cell.getPosition() == Grid.hyperminepos) { //Row and Column: 1:With Another Flag, 0:Without Recursion, 2:Show Number
                        //Reveal Cells When Hypermine Is Activated

                        cell.setFlagged(true); //Flag
                        cell.setText("H");     //Hypermine Cell
                        flaggedCells++;
                        Window.update(flaggedCells);

                        //Reveal Cells From Same Row And Column

                        for(int i=0; i<Game.GRIDSIZE; i++) {
                            //Check Every Row And Fill Columns
                            int cps = Grid.hypercolumn + i * Game.GRIDSIZE;

                            if (Grid.cellGrid.get(cps).getType() == 1) {         //If Cell Is Mine
                                if(cps == Grid.hyperminepos) {continue;}
                                Grid.cellGrid.get(cps).setText("M");
                                Grid.cellGrid.get(cps).setEnabled(false);
                                if(Grid.cellGrid.get(cps).isFlagged() == false){
                                    Grid.cellGrid.get(cps).setFlagged(true);
                                    flaggedCells++;
                                    Window.update(flaggedCells);
                                }
                            } else if (Grid.cellGrid.get(cps).getType() == 0) {  //If Cell Is Empty
                                if(Grid.cellGrid.get(cps).isEnabled()) {
                                    Grid.cellGrid.get(cps).setEnabled(false);
                                    Grid.cellGrid.get(cps).setText("");
                                }
                            } else if (Grid.cellGrid.get(cps).getType() == 2) {  //If Cell Has Adjacent Mines
                                if(Grid.cellGrid.get(cps).isEnabled()) {
                                    this.click(Grid.cellGrid.get(cps));
                                }
                            }
                        }
                        for(int j=0; j<Game.GRIDSIZE; j++) {
                            //Check Every Column And Fill Rows
                            int rps = Grid.hyperrow * Game.GRIDSIZE + j;

                            if (Grid.cellGrid.get(rps).getType() == 1) {         //If Cell Is Mine
                                if(rps == Grid.hyperminepos) {continue;}
                                Grid.cellGrid.get(rps).setText("M");
                                Grid.cellGrid.get(rps).setEnabled(false);
                                if(Grid.cellGrid.get(rps).isFlagged() == false){
                                    Grid.cellGrid.get(rps).setFlagged(true);
                                    flaggedCells++;
                                    Window.update(flaggedCells);
                                }
                            } else if (Grid.cellGrid.get(rps).getType() == 0) {  //If Cell Is Empty
                                if(Grid.cellGrid.get(rps).isEnabled()) {
                                    Grid.cellGrid.get(rps).setEnabled(false);
                                    Grid.cellGrid.get(rps).setText("");
                                }
                            } else if (Grid.cellGrid.get(rps).getType() == 2){   //If Cell Has Adjacent Mines
                                if(Grid.cellGrid.get(rps).isEnabled()) {
                                    this.click(Grid.cellGrid.get(rps));
                                }
                            }
                        }
                    }
                    else {  //If the Cell is not Activated Hypermine
                        cell.setFlagged(true);
                        cell.setText("F");
                        flaggedCells++;
                        Window.update(flaggedCells);
                    }
                }
            }
            else { //If it Is Flagged, With Right Click Cell is Flag Free
                cell.setFlagged(false);
                cell.setText("");
                flaggedCells--;
                Window.update(flaggedCells);
            }
        }
    }

}

