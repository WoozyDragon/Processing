import java.util.ArrayList;
import java.util.Random;


//variableSetup
//final int WIDTH =   20;
//final int HEIGHT =  20;

//is the whole game over?
boolean died;

//max length of the snake
int maxSnakeSize = 1;

//score. It does what it says on the tin
int score = 0;

//transfer variable for current direction
int direction;

//create tile grid
tileClass[][] tiles = new tileClass[20][20];

//create random number
Random rand = new Random();

//holds all blocks of the snake
ArrayList<snakeClass> snake = new ArrayList<snakeClass>();

//framerate for the game to run at. Increases as time goes on
float framerate;

//to be called on death
void death()
{
  died = true;
  noLoop();
  redraw();
}

void newFruit()
{
  //location of fruit placeholders
  int fruitX, fruitY;
  
  //create a new fruit in a random position that's not already taken by the snake 
  fruitX = rand.nextInt(20);
  fruitY = rand.nextInt(20);
  tiles[fruitX][fruitY].addFruit();
}

/*
create a new snake block at (x,y)
note that x,y starts at 0

0, 0 ------------ 19, 0 
|                    | 
|                    |
|                    |
|                    |
|                    |
|                    |
0, 19 ----------- 19, 19

like so
*/
void newSnake(int x, int y)
{
  snakeClass newBlock = new snakeClass(x, y);
  snake.add(newBlock);
}

void newSnake(int x, int y, int pos)
{
  snakeClass newBlock = new snakeClass(x, y, pos);
  snake.add(newBlock);
}

void drawTiles()
{
  for(int i = 0; i < 20; ++i)
  {
   for(int j = 0; j < 20; ++j)
   {
    tiles[i][j].drawThis(); 
   }
  }
}


void setup()
{
  snake.clear();
  
  for(int i = 0; i < 20; ++i)
  {
   for(int j = 0; j < 20; ++j)
   {
    tileClass newTile = new tileClass(i, j);
    tiles[i][j] = newTile;
   }
  }
  
  //create snake head
  newSnake(10, 10);
  //newSnake(10, 11);
  
  //place fruit
  newFruit();
  
  //create window
  size(800,800);
  
  maxSnakeSize = 1;
  
  score = 0;
  
  died = false; //<>//
  
  framerate = 2;
}

void draw()
{
  frameRate(framerate);
  framerate += 0.05;
  //move snake
  //snake.update()
    //check if snake eats fruit, add score
    //implemented inside snake update
  //for every block in the snake...
  //not using the length in the loop because that would check it every time
  //which means that it would end up updating the new blocks, not what I want
  int siz = snake.size();
  for (int i = 0; i < siz ; ++i)
  {
    //...make an alias so that I don't have to type everything //<>//
    snakeClass snek = snake.get(i);
    
    //...update it
    snek.update();
    
    //...and maybe kill it
    //if the delete flag is set in the alias (snek), 
    //remove the snake from the grid
    //remove that block from the arraylist
    if (snek.posSnake >= maxSnakeSize) 
    {
      snek.delete = true;
    }
  }
  
  //delete all the dead snakes. 
  //here because it broke the code if above (reduced the length of the list but not the iterations)
  for (int i = 0; i < snake.size(); ++i)
  {
    snakeClass snek = snake.get(i);
    if (snek.delete)
    {
      tiles[snek.posX][snek.posY].removeSnake();
      snake.remove(i); 
    }
  }
  

  //draw updated grid
  drawTiles();
  
  if (died)
  {
    rectMode(CORNERS);
    fill(255,255,255);
    rect(0, 0, 800, 800);
    
    PFont f;
    f = createFont("Arial",36,true);
    textFont(f);
    fill(0, 0, 0);
    textAlign(CENTER);
    text("Your score was: " + score + "\n click to play again", 400, 400);
  }
}


void keyPressed()
{
 if (key == CODED)
 {
  if (keyCode == UP)
  {
    direction = 2;
  } else if (keyCode == LEFT)
  {
    direction = 1;
  } else if (keyCode == DOWN)
  {
    direction = 0;
  } else if (keyCode == RIGHT)
  {
    direction = 3;
  }
 }
}

void mouseClicked()
{
  if (died)
  {
    setup();
    died = false;
    loop();
  }
}
