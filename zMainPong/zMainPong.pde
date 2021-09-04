import java.util.Random;

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
final color white = color(255,255,255);
final color black = color(0,0,0);

//create rng
Random rand = new Random();

//create the left paddle at (20, 20)
paddle lpad = new paddle(20, 20, paddleXWide, paddleYWide, white, true);
//create the right paddle at (20 units from right of screen (minus the width of the paddle, because important corner is at top left), 20)
paddle rpad = new paddle(wide - 20 - paddleXWide, 20, paddleXWide, paddleYWide, white, false);

//create ball at middle(ish) of screen
ball pong = new ball(wide/2, tall/2, ballXWide, ballYWide, white);


void setup()
{

    
    //set screen size
    size(800,400);
    
    //background color
    background(black);
    
    frameRate(60);
    
    //reset scores?
    lscore = 0;
    rscore = 0;
    
}

void draw()
{
    //frameRate(60);
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

void textUpdate()
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

void keyPressed(){
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
