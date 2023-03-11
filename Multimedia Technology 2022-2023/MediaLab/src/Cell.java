import javax.swing.*;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;

// Creating Cells
public class Cell extends JButton {
    private int type;
    private int position;
    private boolean discovered;
    private boolean flagged;
    private Handler handler;
    public Cell(int type, int position, boolean discovered, boolean flagged, Handler handler){
        this.type = type;                //Cell type: empty, mine, number
        this.position = position;        //Cell position
        this.discovered = discovered;    //Cell discovered
        this.flagged = flagged;          //Cell flag
        this.handler = handler;          //Cell handler

        addMouseListener(new MouseListener(){              //Mouse Listener for Cell
            @Override
            public void mouseClicked(MouseEvent e){
                if(SwingUtilities.isRightMouseButton(e)) { //Right Click
                    rightClickButton();
                }
                else {                                     //Left Click
                        clickButton();
                }

            }

            public void mouseEntered(MouseEvent e) {}
            public void mouseExited(MouseEvent e) {}
            public void mousePressed(MouseEvent e) {}
            public void mouseReleased(MouseEvent e) {}

        });
    }

    public int getType(){ //0:empty 1:mine 2:number
        return type;
    }

    public int getPosition(){
        return position;
    }

    public boolean isDiscovered(){
        return discovered;
    }

    public void getDiscovered(boolean d) {
        this.discovered = d;
    }

    public boolean isFlagged(){
        return flagged;
    }

    public void setFlagged(boolean f){
        this.flagged = f;
    }

    public void clickButton() {        //If Cell is Enabled, open Cell
        if(this.isEnabled()) {
            handler.click(this);
        }
    }

    public void rightClickButton() {  //If Cell is Enabled, mark Cell
        if(this.isEnabled()) {
            handler.rightClick(this);
        }
    }

}
