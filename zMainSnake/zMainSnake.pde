import java.util.ArrayList;

final int WIDTH         = 20;
final int HEIGHT        = 20;


final int SCREENWIDTH   = 800;
final int SCREENHEIGHT  = 800;

int       direction     = 0;

//init the list of tile classes
tileClass[][] tiles = new tileClass[WIDTH+1][HEIGHT+1];

int fruitX;
int fruitY;

int score = 0;

//init the list of snake Classes 
ArrayList<snakeClass> snake = new ArrayList<snakeClass>();

void checkFruit() //<>//
{
  while (true)
  {
    int exit = 0;
    for(int i = 0; i < HEIGHT+1; ++i)
    {
      for(int j = 0; j < WIDTH+1; ++j)
      {
        //tiles[j][i]
        //if the snake is in a tile that has fruit
        if (tiles[j][i].hasFruit && tiles[j][i].hasSnake)
        {
          //increase score
          score += 1;
          
          //generate a new fruit somewhere
          int fruitX = (int)Math.floor(Math.random()*(WIDTH-0+1)+0);
          int fruitY = (int)Math.floor(Math.random()*(HEIGHT-0+1)+0);
          tiles[fruitX][fruitY].addFruit();
          
          //Set it so that we don't exit, because the new fruit may be on the snake
          exit = 1;
        }
      }
    }
    //if exit hasn't been changed, we're good, the fruit hasn't been found
    if (exit == 0) break;
  }
}

void setup()
{
  //setup screen
  size(800, 800);
  
  //actually create all the tiles for the grid
  for(int i = 0; i < HEIGHT+1; ++i)
  {
    for(int j = 0; j < WIDTH+1; ++j)
    {
      //no comment
      //tiles[j][i]
      tileClass newTile = new tileClass();
      tiles[j][i] = newTile;
    }
  }
  
  //create head
  snakeClass newBlock = new snakeClass((int)Math.floor(HEIGHT/2), (int)Math.floor(WIDTH/2));
  snake.add(newBlock);
  
  //Create a fruit and stick it somwhere random
  int fruitX = (int)Math.floor(Math.random()*(WIDTH-1+1)+0);
  int fruitY = (int)Math.floor(Math.random()*(HEIGHT-1+1)+0);
  tiles[fruitX][fruitY].addFruit();
}

void draw()
{
  for(int i = 0; i < HEIGHT+1; ++i)  { //<>//
    //System.out.print(i + " :");
    for(int j = 0; j < WIDTH+1; ++j)
    {
      //no comment
      
      // set color
      tiles[j][i].draw();
      //draw square
      rect(i*40, j*40, i*40+40, j*40+40);
    }
  }
  
  //snake update loop
  for (int i = 0; i < snake.size(); ++i)
  {
    //update the selected block 
    //(length of snake, tiles list)
    snake.get(i).update(snake.size(), tiles);
    
    //if block is to be deleted, delete it;
    if (snake.get(i).delete) snake.remove(i);
  }
  
  checkFruit();
  
  
  delay(200);
}


void keyPressed()
{
 if (key == CODED)
 {
  if (keyCode == UP)
  {
    direction = 1;
  } else if (keyCode == LEFT)
  {
    direction = 2;
  } else if (keyCode == DOWN)
  {
    direction = 3;
  } else if (keyCode == RIGHT)
  {
    direction = 0;
  }
 }
}
