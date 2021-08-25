class tileClass
{  
  public boolean hasSnake;
  public boolean hasFruit;
  
  tileClass()
  {
    this.hasSnake = false;
  }
  
  public void addSnake()
  {
    this.hasSnake = true;
  }
  
  public void removeSnake()
  {
    this.hasSnake = false;
  }
  
  
  public void addFruit()
  {
    this.hasFruit = true;
  }
  
  public void removeFruit()
  {
    this.hasFruit = false;
  }    
  
  public void draw()
  {   
   //check to make sure tile doesn't have both snake and fruit
   //that check happens elsewhere
   //assert !(this.hasSnake && this.hasFruit);
   
   //white borders between tiles
   stroke(255, 255, 255);
   
   if (this.hasSnake) 
   {
    rectMode(CORNERS);
    //set fill color to black
    fill(0,0,0);    
   } else if (this.hasFruit)
   {
    //set fill color to red
    fill(255,0,0);
   } else {
    //set fill color to green
    fill(0,255,0);
   }
   
  }
}
