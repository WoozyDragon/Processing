import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.Random; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class zMainPong extends PApplet {



//two score variables, one for left player and the other for the right player
int lscore = 0;
int rscore = 0;

//direction that the paddles are moving
//'1' is no motion
char ldirect = '1';
char rdirect = '1';

//number of times through the main loop
int runLoop = 0;

//toggle random(ish) ball bouncing
boolean randoBall = false;

//constants that are used in multiple places
//to reduce magic numbers
final int paddleXWide = 15;
final int paddleYWide = 75;
final int ballXWide = 10;
final int ballYWide = 10;
final int wide = 800;
final int tall = 400;

//some useful colors
final int white = color(255,255,255);
final int black = color(0,0,0);

//create rng
Random rand = new Random();

//create the left paddle at (20, 20)
paddle lpad = new paddle(20, 20, paddleXWide, paddleYWide, white, true);
//create the right paddle at (20 units from right of screen (minus the width of the paddle, because important corner is at top left), 20)
paddle rpad = new paddle(wide - 20 - paddleXWide, 20, paddleXWide, paddleYWide, white, false);

//create ball at middle(ish) of screen
ball pong = new ball(wide/2, tall/2, ballXWide, ballYWide, white);


public void setup()
{

    
    //set screen size
    
    
    //background color
    background(black);
    
    //reset scores?
    lscore = 0;
    rscore = 0;
    
}

public void draw()
{
    frameRate(60);
    //if the keys aren't pressed, don't move   
    if (runLoop % 8 == 0)
    {
        ldirect = '1';
        rdirect = '1';
    }

    
    //clear screen
    background(black);
    
    //update left, right paddle
    lpad.update();
    rpad.update();
    
    //update ball
    pong.update();
    
    //update text
    textUpdate();
     
     
    //increment loop counter
    runLoop++;
}

//reurns +1 or -1
public int plusminus()
{
    boolean out = rand.nextBoolean();
    if (out) return 1;
    else return -1;
}

public void textUpdate()
{
    PFont font;
    font = createFont("Arial",20,true);
    textFont(font);
    fill(white);
    textAlign(CENTER);
    text(rscore, wide/2 - wide/8, 20);
    text(lscore, wide/2 + wide/8, 20);
    
    if (randoBall){
        fill(white);
        rect(390, 0, 10, 10);
    }
}

public void keyPressed(){
    if (key == CODED)
    {
        if (keyCode == UP)
        {
            rdirect = 'u';
        } else if (keyCode == DOWN)
        {
            rdirect = 'd';
        }
    } 
    if (key == 'w')
    {
        ldirect = 'u';
    } else if (key == 's')
    {
        ldirect = 'd';
    } else if (key == 'r')
    {
        if (randoBall)
        {
            randoBall = false;   
        } else {
            randoBall = true;   
        }
    }

}
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
    
    
    ball(int x_init, int y_init, int xWide_init, int yTall_init, int color_init)
    {
        //assign all below varaibles (5) using block's constructor
        super(x_init, y_init, xWide_init, yTall_init, color_init);
        
        this.initSpeedX = 2.5f;
        this.initSpeedY = 2.5f;
        
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
            out = -1 * value + 0.25f;
        } else {
            out = -1 * value + ((rand.nextFloat()*2)-0.5f);
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
    
    paddle(int x_init, int y_init, int xWide_init, int yTall_init, int color_init, boolean left_init)
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
public class block
{
    //top left corner
    protected int x;
    protected int y;
    
    //size in pixels
    protected int xWide;
    protected int yTall;
    
    //color of the block
    protected int rectColor;
    
    block(int x_init, int y_init, int xWide_init, int yTall_init, int color_init)
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
    public void settings() {  size(800,400); }
    static public void main(String[] passedArgs) {
        String[] appletArgs = new String[] { "zMainPong" };
        if (passedArgs != null) {
          PApplet.main(concat(appletArgs, passedArgs));
        } else {
          PApplet.main(appletArgs);
        }
    }
}
