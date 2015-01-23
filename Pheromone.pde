class Pheromone {
  /*
    A pheromone indicates the coordinates (tile) of a food spot.
    It is dropped on a tile by an ant carrying food.
    It is destroyed after a certain time.
  */ 
  
  public int instantiationTime;
  
  private Tile _tile;
  
  Pheromone(Tile t) {
    _tile = t;
    // Store the instantiation time
    instantiationTime = minute() * 60 + second();
  }
  
  public Tile GetTile() {
    return _tile;
  }
}
