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
