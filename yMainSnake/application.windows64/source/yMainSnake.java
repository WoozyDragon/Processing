import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.ArrayList; 
import java.util.Random; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class yMainSnake extends PApplet {





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
public void death()
{
  died = true;
  noLoop();
  redraw();
}

public void newFruit()
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
public void newSnake(int x, int y)
{
  snakeClass newBlock = new snakeClass(x, y);
  snake.add(newBlock);
}

public void newSnake(int x, int y, int pos)
{
  snakeClass newBlock = new snakeClass(x, y, pos);
  snake.add(newBlock);
}

public void drawTiles()
{
  for(int i = 0; i < 20; ++i)
  {
   for(int j = 0; j < 20; ++j)
   {
    tiles[i][j].drawThis(); 
   }
  }
}


public void setup()
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
  
  
  maxSnakeSize = 1;
  
  score = 0;
  
  died = false; //<>//
  
  framerate = 2;
}

public void draw()
{
  frameRate(framerate);
  framerate += 0.05f;
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


public void keyPressed()
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

public void mouseClicked()
{
  if (died)
  {
    setup();
    died = false;
    loop();
  }
}
public class snakeClass
{
  //position of block
  private int posX, posY;
  
  //position in snake
  private int posSnake;
  
  //boolean if delete
  public boolean delete;
  
  //constructor number 1 (if snakePos is supplied)
  snakeClass(int x, int y, int inSnakePos)
  {
    gen(x, y, inSnakePos);
  }
  
  //constructor number 2 (if snakePos is not supplied)
  snakeClass(int x, int y)
  {
    gen(x, y, 0);
  }
  
  //provides the init code, dealing with differences
  //to DRY my code.
  //is there a better way? proably.
  private void gen(int x, int y, int pos)
  {
    //try to add snake, but if out of bounds (off screen) die
    //if snake is already in the tile, die
    try
    {
      //set position of snake (in tiles)
      this.posX = x;
      this.posY = y;
      
      //add snake to tile
      if (tiles[this.posX][this.posY].hasSnake)
      {
        death();
      } else {
        tiles[this.posX][this.posY].addSnake();
      }
      
    } catch (ArrayIndexOutOfBoundsException e1) {
      death();
    }


    //set position in snake
    this.posSnake = pos;
    
    //don't delete block yet
    this.delete = false;
    
    //check for fruit
    //if exists:
    //add score
    //remove the fruit
    //make a new fruit
    //extend the max length of the snake
    try {
      if(tiles[this.posX][this.posY].hasFruit)
      {
        tiles[this.posX][this.posY].removeFruit();
        ++score;
        newFruit();
        //newSnakeGen(1);
        maxSnakeSize += 1;
        //this.posSnake += 1;
      }
    } catch (ArrayIndexOutOfBoundsException e2) {
     death(); 
    }
    
  }
  
  
  
  public void update()
  {
    //move the block up in the position of the snake
    this.posSnake += 1;    

    
    //if first block (used to be 0, but is now one becuase of increase)
    //generate a new block
    if (this.posSnake == 1)
    {      
      newSnakeGen(0);
    }
    
    
  }
  
  //generate a new snake block based on the direction input from the user
  //dist is the new block's snakepos
  private void newSnakeGen(int dist)
  {
      if (direction == 0)
      {
        newSnake(this.posX, this.posY + 1, dist);
      } else if (direction == 1)
      {
        newSnake(this.posX - 1, this.posY, dist);
      } else if (direction == 2)
      {
        newSnake(this.posX, this.posY - 1, dist);
      } else if (direction == 3)
      {
        newSnake(this.posX + 1, this.posY, dist);
      } else {
        System.out.println("HELP (snake update loop)");
      }
  }
  

}
class tileClass
{
  //position in board (pixels)
  private int posBoardX;
  private int posBoardY;

  //width of tiles
  final static int tileWide = 40;

  //boolean contains snake, fruit
  public boolean hasSnake;
  public boolean hasFruit;


  //initalizer 
  tileClass(int i, int j)
  {
    //make sure each tile is empty
    this.hasSnake = false;
    this.hasFruit = false;

    //set absolute position (in pixels)
    this.posBoardX = i*tileWide;
    this.posBoardY = j*tileWide;
  }

  //draw self
  public void drawThis()
  {
    //make sure snake and fruit aren't in the same tile
    //that check happens earlier in the update cycle
    assert !(this.hasSnake == true && this.hasFruit == true);

    //white borders around tiles
    stroke(255, 255, 255);

    //set fill colors
    if (this.hasSnake)
    {
      //set black if snake in square
      fill(0, 0, 0);
    } else if (this.hasFruit)
    {
      //set red if snake in square
      fill(255, 0, 0);
    } else {
      //set green if neither in square
      fill(0, 255, 0);
    }

    //actually draw rectangle
    //remember tilewide is the width of each tile
    rect(this.posBoardX, this.posBoardY, this.posBoardX + tileWide, this.posBoardY + tileWide);
  }

  //add/remove Snake
  public void addSnake()
  {
    this.hasSnake = true;
  }

  public void removeSnake()
  {
    this.hasSnake = false;
  }

  //add/remove Fruit  
  public void addFruit()
  {
    this.hasFruit = true;
  }

  public void removeFruit()
  {
    this.hasFruit = false;
  }
}
    public void settings() {  size(800,800); }
    static public void main(String[] passedArgs) {
        String[] appletArgs = new String[] { "yMainSnake" };
        if (passedArgs != null) {
          PApplet.main(concat(appletArgs, passedArgs));
        } else {
          PApplet.main(appletArgs);
        }
    }
}
