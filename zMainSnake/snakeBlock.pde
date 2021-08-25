class snakeClass
{
  private int       posBoardX;
  private int       posBoardY;
  private int       posSnake;
  public boolean    delete;
  
  snakeClass (int posX, int posY) 
  {
    //set local position varaibles
    this.posBoardX = posX;
    this.posBoardY = posY;
    
    //set as head of snake
    this.posSnake = 0;
    
    //set to not delete
    this.delete = false;
    
    //add snake to respective tile
    try {
     tiles[this.posBoardX][this.posBoardY].addSnake();
    } catch (ArrayIndexOutOfBoundsException e1) {
      System.out.println(e1);
      exit();
    }
    
  }
  
  boolean checkDeath()
  {
    return false;
  }
  
void update(int maxLength, tileClass[][] tiles) //<>//
  {
    if (this.posSnake == 0)
    {
      snakeClass newBlock;
      if (direction == 0) {
        newBlock = new snakeClass(this.posBoardX, this.posBoardY + 1);
      } else if (direction == 1)
      {
        newBlock = new snakeClass(this.posBoardX - 1, this.posBoardY);
      } else if (direction == 2)
      {
        newBlock = new snakeClass(this.posBoardX, this.posBoardY - 1);
      } else //if (direction == 3)
      {
        newBlock = new snakeClass(this.posBoardX + 1, this.posBoardY);
      }
      snake.add(newBlock);
    }
    
    this.posSnake += 1;
    if (this.posSnake >= maxLength)
    {
      tiles[this.posBoardX][this.posBoardY].removeSnake();
      this.delete = true;
    }
  }

}
