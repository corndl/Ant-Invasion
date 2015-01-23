class Tile {
  /*
    A tile is an element of the grid. It can contain :
      - Ants
      - The Colony
      - A Food Spot
      - Pheromones  
  */
  
  // Food quantity  
  private int _food;
  // Number of ants on that tile
  private int ants;
  private Pheromone _p;
  
  public boolean HasPheromone;
  public boolean HasAnt;
  public boolean IsColony;
  public boolean HasFood;
  public int x;
  public int y;

  Tile(int _x, int _y) {
    x = _x;
    y = _y;
    HasPheromone = false;
    HasAnt = false;
    IsColony = false;
    HasFood = false;
  }
  
  public boolean equals (Tile t) {
    return (t.x == x && t.y == y);  
  }
  
  // When an ants drops a pheromone on this tile
  public void DropPheromone(Pheromone p) {
    HasPheromone = true;
    _p = p;
  }
  
  // A pheromone is destroyed after a certain time (cooldown)
  public void DestroyPheromone() {
    HasPheromone = false;
  }
  
  public Pheromone GetPheromone() {
    return _p;
  }
  
  // When an ant comes on this tile
  public void AntComing() {
    ants++;
    HasAnt = true; 
  }
  
  // When an ant leaves this tile
  public void AntLeaving() {
    ants--;
    if (ants == 0) 
      HasAnt = false;
  }
  
  // For food generation
  public void PutFood() {
    _food = 10;
    HasFood = true;
  }
  
  // When an ant takes a portion of food
  public void TakeFood() {
    _food--;
    if (_food == 0)
      HasFood = false;
  }
}
