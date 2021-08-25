public class block
{
    //top left corner
    protected int x;
    protected int y;
    
    //size in pixels
    protected int xWide;
    protected int yTall;
    
    //color of the block
    protected color rectColor;
    
    block(int x_init, int y_init, int xWide_init, int yTall_init, color color_init)
    {
        this.x         = x_init;
        this.y         = y_init;
        this.xWide     = xWide_init;
        this.yTall     = yTall_init;
        this.rectColor = color_init;
    }
    
    protected void update()
    {
        drawThis();
    }
    
    protected void drawThis()
    {
        //turn off outline and set fill color to rectColor
        noStroke();
        fill(rectColor);
        
        //draw the rectangle
        rect(x, y, xWide, yTall); 
    }
}
