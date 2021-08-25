class ball extends block
{
    ////top left corner
    //protected int x;
    //protected int y;

    ////size in pixels
    //protected int xWide;
    //protected int yTall;

    ////color of the block
    //protected color rectColor;
    
    //how fast the ball is moving at any given time
    //together they make the speed vector
    private float speedX;
    private float speedY;

    //starting speeds of ball
    private float initSpeedX;
    private float initSpeedY;
    
    //save the ball if it gets trapped inside a paddle
    private int trapped;
    
    
    ball(int x_init, int y_init, int xWide_init, int yTall_init, color color_init)
    {
        //assign all below varaibles (5) using block's constructor
        super(x_init, y_init, xWide_init, yTall_init, color_init);
        
        this.initSpeedX = 2.5;
        this.initSpeedY = 2.5;
        
        //assigning inital speeds
        this.speedX = initSpeedX;
        this.speedY = initSpeedY;
        
        
    }

    public void update()
    {
        move();
        drawThis();
    }

    private void move()
    {
        //move the ball
        this.x += this.speedX;
        this.y += this.speedY;
        
        bounce();
        
    }
    
    private void bounce()
    {
        //check for collision, first x, then y
        //on x (left and right sides), add points as needed
        if (this.x <= 0)
        {
            lscore++;
            this.reset();
            //this.speedX = flip(this.speedX);
        } else if (this.x + ballXWide >= wide)
        {
            rscore++;
            this.reset();
            //this.speedX = flip(this.speedX);
        } 
        if (this.y <= 0)
        {
            this.speedY = flip(this.speedY);
        } else if (this.y + ballYWide >= tall)
        {
            this.speedY = flip(this.speedY);
        }
        
        //check left side paddle
        //if x is less than the top left corner's x, but greater than the top right corners X
        if (  ((this.x < lpad.getX()) && (this.x > lpad.getX() - lpad.getXSize())) && ((this.y > lpad.getY()) && (this.y < lpad.getY() + lpad.getYSize()))  )
        {
            this.speedX = flip(this.speedX);   
            if (trapped > 5)
            {
                this.x += 15;
                this.speedX = Math.abs(this.speedX);
            }
            trapped++;
            return;
        }
        
        //and the right side
        if (  ((this.x < rpad.getX()) && (this.x > rpad.getX() - rpad.getXSize())) && ((this.y > rpad.getY()) && (this.y < rpad.getY() + rpad.getYSize()))  )
        {
            this.speedX = flip(this.speedX); 
            if (trapped > 5)
            {
                this.x -= 15;
                this.speedX = Math.abs(this.speedX) * -1;
            }
            trapped++;
            return;
        }
        
        trapped = 0;

    }
    
    //takes and value and multiples it by -1
    //if randoBall is enabled, adds a bit of randomness
    private float flip(float value)
    {
        float out;
        float outAbs;
        
        if (!randoBall)
        {
            out = -1 * value + 0.25;
        } else {
            out = -1 * value + ((rand.nextFloat()*2)-0.5);
        }
        
        //gets the sign of out (out = +, +/+ = + ; out = -, -/+ = -)
        outAbs = out/Math.abs(out);
        
        //to make sure the ball doesn't go <i>too</i> slow
        if (Math.abs(out) < 1)
        {
            out = 2 * outAbs;
        } 
        
        if (Math.abs(out) > 10)
        {
            out = 10 * outAbs;
        } 
        
        return out;
        
    }
    
    //resets the ball and speed
    public void reset()
    {        
        //reset speeds, but randomize exact direction
        this.speedX = initSpeedX*plusminus();
        this.speedY = initSpeedY*plusminus();
        
        //reset position
        this.x = wide/2;
        this.y = tall/2;
    }
}
