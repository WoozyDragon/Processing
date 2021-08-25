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
