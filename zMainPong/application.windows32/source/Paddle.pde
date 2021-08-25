class paddle extends block
{
    ////top left corner
    //protected int x;
    //protected int y;
    
    ////size in pixels
    //protected int xWide;
    //protected int yTall;
    
    ////color of the block
    //protected color rectColor;
    
    //if on the left side (false if on the right)
    private boolean left;
    
    //how fast the paddle moves
    private float speed = 5;
    
    paddle(int x_init, int y_init, int xWide_init, int yTall_init, color color_init, boolean left_init)
    {
        //assign all below varaibles (5) using block's constructor
        super(x_init, y_init, xWide_init, yTall_init, color_init);
        
        this.left = left_init;
        
    }
    
    //gets the top corner (y pos)
    public int getY()
    {
        return this.y;
    }
    
    //gets interior top corner
    public int getX()
    {
        if (left)
        {
            return this.x + this.xWide;
        } else {
            return this.x;   
        }
    }
    
    public int getYSize()
    {
        return this.yTall;
    }
    
    public int getXSize()
    {
        return this.xWide;   
    }
    
    public void update()
    {
        move();
        
        drawThis();
    }
    
    //move the paddle
    private void move()
    {
        if (this.left)
        {
            moveActual(ldirect);
        } else {
            moveActual(rdirect);   
        }
    }
    
    private void moveActual(char direction)
    {
        if (direction == '1')
        {
            return;   
        } else if (direction == 'u')
        {
            if (this.y > 0)
            {
                this.y -= this.speed;
            }
        } else if (direction == 'd')
        {
            if (this.y + paddleYWide < tall)
            {
                this.y += this.speed;
            } 
        }
    }
}
